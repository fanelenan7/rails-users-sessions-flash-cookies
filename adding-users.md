# Adding Users

Most of these steps are exactly like the steps for any other Rails model you've created so far.

## [1. Create a User table](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/c038ec882f7974f5fb1e5776e603c65494876593#diff-4b1a57db4f61ac5445c45966a27ece5dR1)

It's going to be really simple, with just a username and password.

```
$ rails g migration create_users
```

## [1.5 Associate Artists and Songs with Users](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/c038ec882f7974f5fb1e5776e603c65494876593#diff-0bdaad38bfd65cc68acaa6db206ae358R1)

```
$ rails g migration add_users_to_artists_and_songs
```

## 2. Migrate

```
$ rake db:migrate
```

## 3. [Create the User model](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/c038ec882f7974f5fb1e5776e603c65494876593#diff-4676c008b11a5480d73d4a6de01e45b9R1)

We could add in fancy validations to make sure passwords are at least 8 characters or what-have-you, but that's a "nice-to-have" we can come back to later.

## 3.5 Update the [Artist](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/c038ec882f7974f5fb1e5776e603c65494876593#diff-8e4d37cdfca18efc71e0dbc0609a4e4fR4) and [Song](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/c038ec882f7974f5fb1e5776e603c65494876593#diff-90f827681ccbedf6cbfabf956112dc89R5) models to belong to Users

## [4. Create the Users controller](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/c038ec882f7974f5fb1e5776e603c65494876593#diff-4e05ad0d64e6100656b63ad1e78f32c5R1)

It looks exactly like the Artists and Songs controllers.

## [5. Create a "Users#new" page](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/c038ec882f7974f5fb1e5776e603c65494876593#diff-722653b3f7d83a0b935a57e09c3cd757R1)

That is: a "Sign Up" page.

We're using a new kind of form field here, `password_field`. All it does is replace text characters with dots. It's secure only against someone looking over your shoulder. Anyone with "Inspect Element" could figure out its contents in about two seconds.

## 5.5 Create [Edit](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/c038ec882f7974f5fb1e5776e603c65494876593#diff-a64b323ee7e173624d069215a90b7e7cR1), [Show](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/c038ec882f7974f5fb1e5776e603c65494876593#diff-c7c9a522f39f5d8cd9b512cd928b2d14R1), and [Index](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/c038ec882f7974f5fb1e5776e603c65494876593#diff-92444b9cfa8fd1c47fee508e5d1c08a6R1) pages for Users as well

## [6. Create a Sessions controller](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/c038ec882f7974f5fb1e5776e603c65494876593#diff-d5241d488259f32ecbe2f636133e5ddaR1)

When a User signs in, we'll call that a new "session". Signing in is very different from signing up: signing up changes the database, whereas signing in doesn't affect the database. Instead, it just compares user input to something that's in the database.

Because it doesn't add anything to the database, we don't necessarily need a model for it.

We *could* have created `sign_in` actions on the Users controller. But it's convention to treat Sessions and Users as pretty separate things. This also lets us use the standard RESTful routes: `new`, `create`, and so on.

The Sessions controller should have these actions:
- `new`, to show the "Sign In" form
- `create`, to which the "Sign In" form POSTs its information
- `delete`, to "Sign Out"

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

## [7. Create a Sign In form](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/c038ec882f7974f5fb1e5776e603c65494876593#diff-1587463304d0ae5fa6135099203b6df9R1)

This is almost identical to the Sign Up form. However, because there's no Session model, we can't just say `form_for @user`. If we do, it'll try to POST the data to the `User#create` route, which we don't want.

We have to explicitly direct the form where we want it to go.

## [8. Create routes](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/c038ec882f7974f5fb1e5776e603c65494876593#diff-21497849d8f00507c9c8dcaf6288b136R8)

We want our users to be able to see each others' profile pages. When there's a model for which you want each instance of it to have its own webpage, you create routes for it using `resources`.

However, we don't want our users to be able to see each others' sessions. A session isn't really a "thing" anyway, which is why we didn't make a model for it, so there's nothing to see.

This is one of relatively few cases in which we'll use `resource` (singular). The difference is Rails doesn't expect to be making an index route for sessions, nor any session routes with IDs in them.

## [9. Create navigation](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/c038ec882f7974f5fb1e5776e603c65494876593#diff-9599427925097c3c66f26ac1e0de5cadR12)

Next, we'll make links to sign-in, sign-up, and sign-out on the **main application layout**. *(We don't actually have a page for sign-out yet... But we will... sort of!)*

...and now if we **run** our application, we can see that it's working successfully! Try creating a user.
