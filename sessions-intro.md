# Sessions

## Framing

Many of us have been to several webpages that only allow us to access content if we are users of the webpage. Annoying, yes, but quite necessary for many websites. That said, how is this concept of "being signed in" done programmatically? How is that information persisted from request to request? Enter Sessions.

## What's In A Session?

Most applications need to keep track of the state of a particular user. Is a user logged-in? Is there information that is unique to this user's instance of being signed in?

HTTP is by nature, however, stateless. Without state, a user would have to identify themselves after every request. Our shopping carts in Amazon couldn't keep their contents.

A session is just a place to store data during one request that you can read during later requests. Just like params, the session in ruby is a hash. This hash allows us to keep track of this information. Rails will create a new session automatically when a new user accesses the application. It will load an existing session if the user has already used the application.

## I Do: Session Demo

For this next part of the class, we will go through a demo showing how sessions work. You don't need to follow along -- just grasp the concept.

Should you want to play with this code later, the starting point is the [edit/feature branch of Reminder.ly](https://github.com/ga-wdi-exercises/reminderly/tree/edit-feature), a one-model to-do app.

Let's add a controller and some views that we'll need to demonstrate sessions...

```bash
$ touch app/controllers/sessions_controller.rb
$ mkdir views/sessions
$ touch views/sessions/index.html.erb
$ touch views/sessions/another_page.html.erb
$ touch views/sessions/set_session.html.erb
```

Here are the contents for those files...

```ruby
# app/controllers/sessions_controller.rb

class SessionsController < ApplicationController

  def index
    @name = session[:name]
  end

  # When we visit the corresponding view for this page, it will trigger this controller action and run the below code.
  def set_session
    session[:name] = "bob"
  end

  def another
    @name = session[:name]
  end
end
```

```html
<!-- app/views/sessions/index.html.erb -->

<h1>Testing sessions</h1>
<% if @name %>
<h2><%= @name %></h2>
<% end %>
```

```html
<!-- app/views/sessions/another.html.erb -->

<h1>Another pages to test sessions</h1>
<% if @name %>
<h2><%= @name %></h2>
<% end %>
```

```html
<!-- app/views/sessions/set_session.html.erb -->

<h1>Setting Session</h1>

<!-- No content needs to go in here. Just know that when this view is visited, we are setting a session in our controller. -->
```

Finally we need to update our `config/routes.rb` so that we can actually access these actions and views...

```ruby
Rails.application.routes.draw do
  get 'show_session' => 'sessions#index'
  get 'set_session' => 'sessions#set_session'
  get 'another' => 'sessions#another'

  resources :todos
end
```

Great now let's navigate to `http://localhost:3000/show_session`. We can clearly see no sign of the string `bob`.

If we now navigate to `http://localhost:3000/set_session`, then navigate back to `http://localhost:3000/show_session`, we can clearly see the string `bob` show up!

If we navigate to another page that leverages that session value(`http://localhost:3000/another`), we can still leverage that same session value.

This is a contrived use case of sessions but we can clearly see that the state of `session[:name] = "bob"` persisting from request to request. Normally session values will be set in `POST` requests, because we're "creating" data.

## Sessions in the Wild

Sessions are used mostly for -- but are not limited to -- the following...

- User authentication and authorization
- Shopping carts
- Setting a current model to persist throughout requests
