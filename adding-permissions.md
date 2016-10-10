# Adding Permissions

"Permissions" are what a given user is "permitted" to do.

Often permissions are very nuanced: an app can have several "roles", like "admin," "member" and "super-admin," all of which are permitted to do different things.

We're going to keep Tunr more general, and add two "sets" of permissions...
- Only signed-in users can CRUD Artists and Songs
- A User can edit only their own profile -- not another User's

## 1. Hide Create/Update/Delete Links for Signed-Out Users

If you're signed out, you should not be able to create, update or delete any Artist or Song from the app.

One way to begin to hide this functionality from signed-out users is to never present them with the links that correspond with those actions in the first place.

We can do that by leveraging the `@current_user` variable we defined in the "Adding Sessions" section. Here's an example of how we would use it to hide the "Add Artist (+)" option from the Artist index page.

```html
<!-- views/artists/index.html.erb -->

<h2>Artists <%= link_to("(+)", new_artist_path) if @current_user %></h2>
```

This could also be written as...

```html
<!-- application.html.erb -->

<h3>Songs
  <% if @current_user %>
    <%= link_to("(+)", new_artist_song_path(@artist))%>
  <% end %>
</h3>
```

**Look through the rest of the application and use this same technique to hide all links that allow a user to create, update or delete Artists and Songs.**

## [2. Hide User Edit Links For Users Who Aren't The Current User](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/3/files#diff-c7c9a522f39f5d8cd9b512cd928b2d14R1)

A User should be able to edit only their own profile.

<details>
  <summary><strong>How could you use the same technique as in the previous step to accomplish this?</strong></summary>

  ```html
  <h2><%= @user.username %> <%= link_to("(edit)", edit_user_path(@user)) if @current_user == @user %></h2>
  ```

  or...

  ```html
  <h2>
    <% if @current_user == @user %>
      <%= @user.username %> <%= link_to("(edit)", edit_user_path(@user))%>
    <% end %>
  </h2>
  ```

</details>

## 3. Disable Create/Update/Delete Routes for Signed-Out Users

Hiding these links is a good start. But if someone just types `/artists/new` into their browser's address bar, they can access the page anyway.

To prevent this, whenever a user tries to access one of these sensitive routes we can check whether they're signed in, and redirect them away if they aren't.

We'll add one line to the beginning of the relevant controller actions

```rb
# app/controllers/artists_controller.rb

def new
  redirect_to root_path unless @current_user  # Don't even allow this page to load if a user isn't signed-in
  @artist = Artist.new
end
```

If `@current_user` is nil that means `session[:user_id]` is also nil, which means the user isn't signed in. The controller action will stop before any data is modified, and the user will be redirected to the "root" URL.

**Now add that to the rest of the relevant controller actions.**

## 4. [Disable User Edit Routes for Users Who Aren't the Current User](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/3/files#diff-4e05ad0d64e6100656b63ad1e78f32c5R23)

<details>
  <summary><strong>How could you use the same technique as in the previous step to accomplish this?</strong></summary>

  ```rb
  # app/controllers/users_controller.rb

  def edit
    @user = User.find(params[:id])
    redirect_to root_url unless @current_user == @user
  end
  ```

</details>

## [5. When a user "signs up", they should also be "signed in"](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/3/files#diff-4e05ad0d64e6100656b63ad1e78f32c5R13)

Currently, signing up and signing in are different processes. After you sign up, you then have to sign in. This isn't really a permissions issue -- just a little annoyance.

Fix this by setting `session[:user_id]` whenever a new User is created.
