# Adding Sessions

## Framing

**Sessions** are a component of virtually every web framework. They're *crucial* to any website that lets you log in and log off.

In your everyday life at some point you've probably gotten an error page that said something like, "Session expired: log in again".

**In a nutshell**, a session is two things:
- An instance of you using a website, usually (but not always) with you having signed in somewhere.
- A way for your Rails app to temporarily store some data about you "in memory" -- that is, not in Postgres -- and to associate the data with your particular computer. These data are called "session variables".

Sessions work using cookies. We'll talk about that later.

We can use this to make Rails "remember" you're logged in to Tunr.

## [1. When your users log in, save their ID to a session variable](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/633497f11da5d8a204a33f4e1b91cb72cd3de2fa#diff-d5241d488259f32ecbe2f636133e5ddaR12)

`session` is a hash that exists in *every controller action*. It's different from `params`, but you access it the same way.

In every subsequent controller action, you can now access `session[:user_id]`.

You can put as many key/value pairs as you would like into `session`.

## [2. Be able to access the current user](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/633497f11da5d8a204a33f4e1b91cb72cd3de2fa#diff-55c5b7aecfb519d0e4880eaf2788eb6eR5)

We're going to create a `before_action` in the `ApplicationController`.

- `before_action`: A method (or collection of methods) that runs before every single controller action. You can declare `before_action` in any controller.
- `ApplicationController`: The class from which every single controller inherits (i.e. `class SessionController < ApplicationController`). That means if you do something in `ApplicationController`, it also applies to every other controller.

This `before_action` will check if `session[:user_id]` has been set.

If it has, it will find the User with that ID in the Postgres database, and put it in an instance variable called `@current_user`.

This `@instance_variable` behaves like any other instance variable in a controller: you can access it in your views.

## [3. Let your user know they're signed in](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/633497f11da5d8a204a33f4e1b91cb72cd3de2fa#diff-9599427925097c3c66f26ac1e0de5cadR12)

As mentioned before, `@current_user` can be accessed in your views just like any other instance variable in a controller.

Because `@current_user` is declared in the `before_action` in the `ApplicationController`, we can access it in literally every view.

This means we can change the way things look depending on whether the user is signed in. For instance: we only want to direct them to "Sign Up" or "Sign In" if they aren't currently signed in.

## [4. Let your user sign out](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/633497f11da5d8a204a33f4e1b91cb72cd3de2fa#diff-d5241d488259f32ecbe2f636133e5ddaR26)

To "sign out" the user, we simply need to remove `session[:user_id]` or set it to nil. Then, the next time the `before_action` runs, `@current_user` will also be nil.

`reset_session` is a shortcut to remove *all* session variables at once.

Try signing in and signing out now!

## [5. Make "signing up" also "signing in"](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/633497f11da5d8a204a33f4e1b91cb72cd3de2fa#diff-4e05ad0d64e6100656b63ad1e78f32c5R13)

Currently, once you sign up you have to sign in as well. To make signing up also sign you in, simply declare `session[:user_id]` when the user signs up.

## [6. Hide create/update/delete links from signed-out users](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/633497f11da5d8a204a33f4e1b91cb72cd3de2fa#diff-aa5b918dd696155038a63e2700090eafR1)

Notice the other `link_to` that have `if @current_user` added to them.

## [7. Allow users to edit only their own profiles](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/633497f11da5d8a204a33f4e1b91cb72cd3de2fa#diff-c7c9a522f39f5d8cd9b512cd928b2d14R1)

## 8. Disable create/update/delete routes for users on the back-end

Hiding these links is a good start. But if someone just types `/artists/new` into their browser's address bar, they can access the page anyway.

To prevent this, whenever a user tries to access one of these sensitive routes we can check whether they're authorized to use it, and redirect them away if they aren't.

I know I'm going to want to check this before lots of controller actions, so save some time and typing I'll create make my code reusable by putting it in a method -- an `authorized` method in the Application Controller. Since all the other controllers inherit from the Application Controller, I'll be able to access this same method in each of them.

### [def authorized](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/633497f11da5d8a204a33f4e1b91cb72cd3de2fa#diff-55c5b7aecfb519d0e4880eaf2788eb6eR16)

**Note: This is NOT a `before_action`.** I'd use that if I wanted to run this in every single route. But I want to run this only in specific routes: ones that involve writing new data. I have no problem with not-signed-in users *seeing* Artist and Song info as long as they can't *change* it.

Now, I'd add one line to the beginning of each `new`, `create`, `edit`, `update`, and `delete` controller action in the Artists and Songs controllers:

### [return unless authorized](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/633497f11da5d8a204a33f4e1b91cb72cd3de2fa#diff-5890a028f3f16dc4a2fe5a61c1fcdd89R9)

This means if the user isn't authorized, the controller action will stop (in this case) before the Artist is created, and the user will be redirected to the "root" URL as specified in the `authorized` method.

## 9. Disable updating someone else's user on the back-end

The previous `authorized` method just checks whether a user is logged in. To prevent a user from updating another user's profile I need to also check whether the user is editing their own profile.

This means I need a new `authorized` method. This one is a special case for users only, so instead of putting it in the Application Controller I'll put it in the Users Controller. It'll **override** the Application Controller's `authorized` method, but *only in the Users Controller*.

### [def authorized](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/633497f11da5d8a204a33f4e1b91cb72cd3de2fa#diff-4e05ad0d64e6100656b63ad1e78f32c5R38)

Now to the `edit` and `update` controller actions I can add that line:

### [return unless authorized](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/633497f11da5d8a204a33f4e1b91cb72cd3de2fa#diff-4e05ad0d64e6100656b63ad1e78f32c5R22)
