# Sessions, Cookies, Errors, and Flash

## Learning Objectives
- Contrast the use cases for cookies, sessions, and permanent storage.
- Define and then access a session variable in a Rails application.
- Add sign-in, sign-up, and sign-out functionality to a Rails application.

## Framing

Currently, Tunr just supports one single "God" user. It would be nice if it could have multiple users. Whenever a user logs in, they'd see only *their* artists and songs.

[Please clone down this repo.](https://github.com/ga-wdi-exercises/tunr_rails_users)

## Adding Users

This class is going to be mostly you walking through README files yourself, adding functionality to Tunr.

In any step that asks you to add code, there will be a link to a "diff" on Github in the solution branch of this repo that shows you that particular piece of code being added.

As you go, keep in mind the "Reflect" questions below which we'll address as a class.

### [You Do: Adding Users](adding-users.md) (30 / 30)

### Reflect (10 / 40)

- What's the difference between `resources` and `resource`?
- True or false: Every controller has to have a model, and vice-versa.
- What's the difference between the Sessions controller and the Users controller?
- How does `f.password_field` protect you from malware and hackers?
- How could this be DRY-ed up? (Hint: There are 3 views that are almost identical.)

### Shortcomings of this User system

- How are you told if you entered the wrong password?
- How are users' passwords protected?
- What's different between being signed in and not being signed in?

## Break (10 / 50)

## Sessions

We need to figure out a way for Rails remember I'm signed in.

#### Why not create an "is_signed_in" column in my User table?

- How would Rails know how to sign out? More importantly, if multiple users are accessing the app, how would Rails know which signed in user is on which computer?

### [You Do: Adding Sessions](adding-sessions.md) (30 / 80)

### Reflect (10 / 90)

- What's the benefit of putting a method in the Application Controller?
- What's is a `before_action`?
- What's the difference between `params` and `session`?

## Break (10 / 100)

## Flash

`puts`ing out error messages isn't very helpful, since the user is never going to be able to see them.

Rails gives us a handy method for showing error messages to users, called `flash`. It relies on sessions.

### [You Do: Adding Flash](adding-flash.md) (10 / 110)

### Reflect (5 / 115)

- Across how many browser requests or controller actions is a flash message available?
- What are the two conventional types of flash messages, and what's the difference between them?
- True or false: Flash should be used to store information from the database.

## Cookies

### [You Do: Exploring Cookies](exploring-cookies.md) (10 / 125)

### Reflect (5 / 130)

- What's the difference between a cookie and a session?
- How do sessions use cookies?
- Cookies seem to be really concerned with security, considering "secure connections only", "accessible to script", expiration dates, and so on. Why?
- What would make you choose to put something in a cookie versus in a session?

### [You Do: Adding Cookies](adding-cookies.md) (10 / 140)

## Important Note About Security

This version of Tunr breaks the fundamental rule of web security: Don't store passwords as plain text, even in a database. They should always be encrypted.

That said, security is *complicated*, and you shouldn't let it prevent you from making an app (hence why we're not worrying about it here).

## Easy wins we didn't cover

- For each Artist and Song, show the username of the person who submitted it
- On each User page, show all the Artists and Songs they've submitted
- Prevent someone from signing up with a username that's already in use
- What else?

These things have been addressed [in the solution branch.](https://github.com/ga-wdi-exercises/tunr_rails_users/commit/43ccf55d3a7b7b7f1139eab791201e737348c38d)
