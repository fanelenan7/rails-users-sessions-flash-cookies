# Adding Differentiation

## [1. When a user "signs up", they should also be "signed in"](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/3/files#diff-4e05ad0d64e6100656b63ad1e78f32c5R13)

Currently, signing up and signing in are different processes. After you sign up, you then have to sign in, which is a little annoying.

Fix this by setting `session[:user_id]` whenever a new User is created.

## 2. Hide Artist/Song create/update/delete links for signed-out users

[For example, this is hiding the Artist#new link.](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/3/files#diff-aa5b918dd696155038a63e2700090eafR1)

Notice all the other `link_to`s that have `if @current_user` added to them.

## [3. Hide User edit links for users who aren't the current user](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/3/files#diff-c7c9a522f39f5d8cd9b512cd928b2d14R1)

A User should be able to edit only their own profile.

## 4. Disable Artist/Song create/update/delete routes for signed-out Users

Hiding these links is a good start. But if someone just types `/artists/new` into their browser's address bar, they can access the page anyway.

To prevent this, whenever a user tries to access one of these sensitive routes we can check whether they're signed in, and redirect them away if they aren't.

I'll add one line to the beginning of each `new`, `create`, `edit`, `update`, and `delete` controller action in the Artists and Songs controllers:

### [redirect_to root_path unless @current_user](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/3/files#diff-5890a028f3f16dc4a2fe5a61c1fcdd89R9)

If `@current_user` is nil that means `session[:user_id]` is also nil, which means the user isn't signed in. The controller action will stop before any data is modified, and the user will be redirected to the "root" URL.

## 5. [Disable User edit routes for users who aren't the current user](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/3/files#diff-4e05ad0d64e6100656b63ad1e78f32c5R23)
