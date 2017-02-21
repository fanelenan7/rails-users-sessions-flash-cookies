# Adding Sessions

## Framing

**Sessions** are a component of virtually every web framework. They're *crucial* to any website that lets you log on and log off.

In your everyday life, you've probably gotten an error page that said something like, "Session expired: log in again".

**In a nutshell**, a session is two things:
- An instance of you using a website, usually -- but not always -- with you having signed in somewhere.
- A way for your Rails app to temporarily store some data about you "in memory" -- that is, not in Postgres -- and to associate the data with your particular computer. These data are called "session variables".

Sessions work using cookies. See the bonus content in this lesson plan for more on that.

We can use them to make Rails "remember" you're logged in to Tunr.

## 1. Create A Sessions Controller

When a User signs in, we'll call that a new "session". Signing in is very different from signing up: signing up changes the database, whereas signing in doesn't affect the database. Instead, it just compares the username and password typed by the user to the usernames and passwords in the database without changing them.

Because it doesn't add anything to the database, we don't necessarily need a model for it.

We will allow users to sign in by creating a form that corresponds to the `new` action in a Sessions controller. Let's begin by creating that controller and then the `new` action...

```bash
$ rails g controller sessions
```

```ruby
# app/controllers/sessions_controller.rb

class SessionsController < ApplicationController
  def new
    @user = User.new
  end
end
```

## 2. Create Sessions Routes

Now let's reference sessions in `routes.rb`. We're going to do this a little differently than usual though...

```rb
resource :session   # Add this after the resources already in the file.
```

This is one of relatively few cases in which we'll use `resource` (singular). The difference between `resource` and `resources` is that the routes have singular names. That means there's no `index` route.

```bash
resources :sessions
=> rake routes

     sessions GET        /sessions(.:format)            sessions#index
              POST       /sessions(.:format)            sessions#create
  new_session GET        /sessions/new(.:format)        sessions#new
 edit_session GET        /sessions/:id/edit(.:format)   sessions#edit
      session GET        /sessions/:id(.:format)        sessions#show
              PUT        /sessions/:id(.:format)        sessions#update
              DELETE     /sessions/:id(.:format)        sessions#destroy

resource :session
=> rake routes
      session POST       /session(.:format)            sessions#create
  new_session GET        /session/new(.:format)        sessions#new
 edit_session GET        /session/:id/edit(.:format)   sessions#edit
              GET        /session/:id(.:format)        sessions#show
              PUT        /session/:id(.:format)        sessions#update
              DELETE     /session/:id(.:format)        sessions#destroy
```

While a Session can have ids, we are not making use of them. The implication here is that a Session is something that will not be saved to the database, and therefore does not need an id.

## 3. Create A Sign-In View

This form will go in the view that corresponds with `Session#new` (i.e., out Sessions controller's `new` action). Let's create that view file and write out the form...

```html
<!-- app/views/sessions/new.html.erb -->

<h2>Sign In</h2>
<%= form_for @user, url: session_path, method: :post do |f| %>
  <%= f.label :username %>
  <%= f.text_field :username %>

  <%= f.label :password %>
  <%= f.password_field :password %>

  <%= f.submit "Submit" %>
<% end %>
```

This is almost identical to the Sign Up form. Because there is no Session model, however, we can't just say `form_for @user`. If we do, it'll try to POST the data to the `User#create` route, which we don't want.

We have to explicitly direct the form where we want it to go. In this case, we want it to send information to the `Session#create` action, which we'll define next. This is where `url: session_path` and `method: :post` come in, as demonstrated in the above snippet.

## 4. Define A Sign-In Controller Action

Let's create a controller action that corresponds with singing in. Here's the flow we're going to follow...
  1. Store the username that was submitted through the form
  2. Find the user that corresponds with that username
  3. Check to see if that user's password matches the one submitted through the form
  4. If they match, set the Session's `user_id` to that of the logged-in user (i.e., indicate that this user is currently logged in)

If the username and/or password submitted through the form is incorrect at any point in this process, the user is re-directed to the application's root page.

```rb
def create
  input_username = params[:user][:username]   # Save the username value submitted through the form

  # If the user exists, sign them in...
  if User.exists?(username: input_username)
    @user = User.find_by(username: input_username)  # Find that user

    # If the password submitted through the form is correct...
    if @user.password == params[:user][:password]
      puts "You're signed in!"
      session[:user_id] = @user.id  # Set the session user_id to that of the user trying to log in
      redirect_to root_path   # Send them back to the app
    else
      puts "Wrong password!"
      redirect_to new_session_path  # Send them back to the sign-in form
    end

  # Otherwise, send them back to the sign-in form so they can enter a valid username-password combination
  else
    puts "That user doesn't exist!"
    redirect_to new_session_path
  end
end
```

<details>

  <summary><strong>Why does `session[:user_id]` work in here?</strong></summary>

  > That's because `session` is a special hash that exists in *every controller action*. It's different from `params`, but you access it the same way.

</details>

In every subsequent controller action, you can now access `session[:user_id]`.

You can put as many key-value pairs as you would like into the `session` hash.

> We *could* have created `sign_in` actions on the Users controller. But it's convention to treat Sessions and Users as separate things. This also lets us use the standard RESTful routes: `new`, `create` and so on.

Note that we can't just write `params[:username]`. We must write `params[:user][:username]`. The data that gets POSTed looks like this, with the form input in a nested hash...

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
> Note that `username` and `password` exist inside of a `user` hash.

## 5. Let Your User Sign Out

Let's give the user the option to sign out. Let's start by adding a link to navigation that will eventually allow the user to do this. Place the following code anywhere inside of the `<nav>` element...

```html
<!-- application.html.erb -->

<%= link_to "Sign Out", session_path, method: :delete %>
```

This link will correspond to a `destroy` method that we will define in our Sessions controller. In this method, we need to remove `session[:user_id]` or set it to `nil`. That way, the application thinks nobody is signed in.

```rb
def destroy
  reset_session   # Delete all sessions
  puts "You're signed out!"
  redirect_to :root   # Send the user back to the homepage
end
```

`reset_session` is a shortcut that comes packaged with Rails that is used to remove *all* session variables at once.

Try signing in and signing out now!

## 6. Be Able To Access The Current User

Wouldn't it be nice if, when a user is signed in, we had a shorthand for accessing that user. We'll do that by defining our own `@current_user` instance variable that is accessible throughout the application.

We'll start doing that by creating a `before_action` in the `controllers/application_controller.rb`

```rb
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception   # This line should already be in your code.
  before_action :set_current_user   # Here we're saying "run the method set_current_user before every controller action"

  def set_current_user
    if User.exists?(session[:user_id])    # If there is a user_id currently stored in the session hash...
      @current_user = User.find(session[:user_id])  # ...find and save that user in @current_user
    else
      @current_user = nil   # ...otherwise, set @current_user to nil
    end
  end
end
```

- **`before_action`**: A method (or collection of methods) that runs before every single controller action. You can declare `before_action` in any controller.
- **`ApplicationController`**: The class from which every single controller inherits (i.e. `class SessionController < ApplicationController`). That means if you do something in `ApplicationController`, it also applies to every other controller.

This `before_action` will check if a User exists in the database with an id that matches `session[:user_id]`. If we haven't set `session[:user_id]` yet it will be `nil` and so won't match any Users anyway.

If a matching User does exist, ActiveRecord will put that user into an instance variable called `@current_user`. This instance variable behaves like any other instance variable in a controller: you can access it in your views.

## 7. Finish Updating Navigation

Depending on whether a user is logged-in or not, we'll want the navigation to look a certain way.
- If a user is logged-in, we would like to see a "Sign Out" option and welcome the user
- If a user is not logged-in, we would like to give them the option to either "Sign Up" or "Sign In"

To do this we will leverage our new `@current_user` variable, which can be accessed in our views just like any other instance variable in a controller.

```html
<nav>
  <% if @current_user %>
    <%= link_to "Welcome, #{@current_user.username}!", user_path(@current_user) %>
    <%= link_to "Sign Out", session_path, method: :delete %>
  <% else %>
    <%= link_to "Sign Up", new_user_path %>
    <%= link_to "Sign In", new_session_path %>
  <% end %>
</nav>
```

> Because `@current_user` is declared in the `before_action` in the `ApplicationController`, we can access it in literally every view.

This means we can change the way things look depending on whether the user is signed in. For instance: we only want to show the "Sign Up" and "Sign In" links to users who are not already signed in.
