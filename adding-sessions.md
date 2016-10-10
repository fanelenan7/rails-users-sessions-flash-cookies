# Adding Sessions

## Framing

**Sessions** are a component of virtually every web framework. They're *crucial* to any website that lets you log on and log off.

In your everyday life at some point you've probably gotten an error page that said something like, "Session expired: log in again".

**In a nutshell**, a session is two things:
- An instance of you using a website, usually -- but not always -- with you having signed in somewhere.
- A way for your Rails app to temporarily store some data about you "in memory" -- that is, not in Postgres -- and to associate the data with your particular computer. These data are called "session variables".

Sessions work using cookies. We'll talk about that later.

We can use them to make Rails "remember" you're logged in to Tunr.

<!-- AM: What form does a session take? Where exactly is it stored? -->

## 1. Create a Sessions Controller

When a User signs in, we'll call that a new "session". Signing in is very different from signing up: signing up changes the database, whereas signing in doesn't affect the database. Instead, it just compares the username and password typed by the user to the usernames and passwords in the database without changing them.

Because it doesn't add anything to the database, we don't necessarily need a model for it.

### [For now, just define the Session#new action](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/3/files#diff-d5241d488259f32ecbe2f636133e5ddaR3)

> This will be for the "Sign In" form.

## [2. Create Sessions routes](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/3/files#diff-21497849d8f00507c9c8dcaf6288b136R9)

This is one of relatively few cases in which we'll use `resource` (singular). The difference between `resource` and `resources` is that the routes have singular names, there's no `index` route, and there are no IDs in the `show`, `edit`, and `delete` routes.

The implication is that a Resource is something that will not be saved to the database, and therefore does not need IDs.

## [3. Create a Sign In View](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/3/files#diff-1587463304d0ae5fa6135099203b6df9R1)

This is almost identical to the Sign Up form. However, because there's no Session model, we can't just say `form_for @user`. If we do, it'll try to POST the data to the `User#create` route, which we don't want.

We have to explicitly direct the form where we want it to go. In this case, we want it to send information to the `Session#create` action, which we'll define next.

## [4. Define a Sign In action](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/3/files#diff-d5241d488259f32ecbe2f636133e5ddaR7)

When your users log in, save their ID to `session[:user_id]`.

`session` is a hash that exists in *every controller action*. It's different from `params`, but you access it the same way.

<!-- AM: Why does it exist in every controller action? Is that word special in Rails? -->

In every subsequent controller action, you can now access `session[:user_id]`.

You can put as many key/value pairs as you would like into the `session` hash.

> We *could* have created `sign_in` actions on the Users controller. But it's convention to treat Sessions and Users as separate things. This also lets us use the standard RESTful routes: `new`, `create` and so on.

Note that we can't just write `params[:username]`; we must write `params[:user][:username]`. The data that gets POSTed looks like this, with the form input in a nested hash:

```rb
{
  "utf8"=>"v",
  "authenticity_token"=>"GA3K043m/Sj7pmvNBKnEd/czz1gEmtst/OWfiagUAfunKcgznFkGLp22e2mwsA5xVlOlvEUxQOhtKucSX1Z8bg==",
  "user"=>{
    "username"=>"juan",
    "password"=>"[FILTERED]"
  },
  "commit"=>"Submit"
}
```

## [5. Let your user sign out](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/3/files#diff-d5241d488259f32ecbe2f636133e5ddaR25)

To "sign out" the user, we simply need to remove `session[:user_id]` or set it to `nil`. Then, the next time the `before_action` runs, `@current_user` will also be nil.

<!-- AM: Has @current_user been mentioned in this lesson plan yet? Find out where to do that. -->

`reset_session` is a shortcut to remove *all* session variables at once.

Try signing in and signing out now!

## [6. Be able to access the current user](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/3/files#diff-55c5b7aecfb519d0e4880eaf2788eb6eR5)

We're going to create a `before_action` in the `ApplicationController`.

- **`before_action`**: A method (or collection of methods) that runs before every single controller action. You can declare `before_action` in any controller.
- **`ApplicationController`**: The class from which every single controller inherits (i.e. `class SessionController < ApplicationController`). That means if you do something in `ApplicationController`, it also applies to every other controller.

This `before_action` will check if a User exists in the Postgres database with an ID that matches `session[:user_id]`. (If we haven't set `session[:user_id]` yet it will be `nil`, and so won't match any Users anyway.)

If a matching User does exist, ActiveRecord will put that user into an instance variable called `@current_user`.

<!-- AM: Is this the first time we start using @current_user in our code? -->

This `@instance_variable` behaves like any other instance variable in a controller: you can access it in your views.

<!-- AM: Is there a good way to diagram how Session interacts with User? -->

## [7. Create navigation](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/3/files#diff-9599427925097c3c66f26ac1e0de5cadR11)

Next, we'll make links to sign-in and sign-out on the **main application layout**. *(We don't actually have a page for sign-out yet... But we will... sort of!)*

As mentioned before, `@current_user` can be accessed in your views just like any other instance variable in a controller.

Because `@current_user` is declared in the `before_action` in the `ApplicationController`, we can access it in literally every view.

This means we can change the way things look depending on whether the user is signed in. For instance: we only want to show the "Sign Up" and "Sign In" links to users who are not already signed in.
