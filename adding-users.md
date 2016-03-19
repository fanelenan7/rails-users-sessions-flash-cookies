# Adding Users

Most of these steps are exactly like the steps for any other Rails model you've created so far.

## [1. Create a User table](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/2/files?diff=unified#diff-4b1a57db4f61ac5445c45966a27ece5dR1)

It's going to be really simple, with just a username and password.

```
$ rails g migration create_users
```

## [1.5 Associate Artists and Songs with Users](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/2/files?diff=unified#diff-0bdaad38bfd65cc68acaa6db206ae358R1)

```
$ rails g migration add_users_to_artists_and_songs
```

## 2. Migrate

```
$ rake db:migrate
```

## 3. [Create the User model](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/2/files?diff=unified#diff-4676c008b11a5480d73d4a6de01e45b9R1)

We're just going to give users a standard `username` and `password` field. We *could* add in fancy validations to make sure passwords are at least 8 characters or what-have-you, but that's a "nice-to-have" we can come back to later.

## 4. Update the [Artist](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/2/files?diff=unified#diff-8e4d37cdfca18efc71e0dbc0609a4e4fR1) and [Song](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/2/files?diff=unified#diff-90f827681ccbedf6cbfabf956112dc89R2) models to belong to Users

## [5. Add RESTful routes for Users](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/2/files?diff=unified#diff-21497849d8f00507c9c8dcaf6288b136R8)

## [6. Create the Users controller](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/2/files?diff=unified#diff-4e05ad0d64e6100656b63ad1e78f32c5R1)

It looks exactly like the Artists and Songs controllers.

## [7. Create a "Users#new" page](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/2/files?diff=unified#diff-722653b3f7d83a0b935a57e09c3cd757R1)

That is: a "Sign Up" page.

We're using a new kind of form field here, `password_field`. All it does is replace text characters with dots. It's secure only against someone looking over your shoulder. Anyone with "Inspect Element" could figure out its contents in about two seconds.

## 8. Create [Edit](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/2/files?diff=unified#diff-a64b323ee7e173624d069215a90b7e7cR1), [Show](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/2/files?diff=unified#diff-c7c9a522f39f5d8cd9b512cd928b2d14R1), and [Index](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/2/files?diff=unified#diff-92444b9cfa8fd1c47fee508e5d1c08a6R1) pages for Users as well

## [9. Add some navigation links](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/2/files?diff=unified#diff-9599427925097c3c66f26ac1e0de5cadR12)
