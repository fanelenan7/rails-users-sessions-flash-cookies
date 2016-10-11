# Sessions, Permissions and Flash

## Learning Objectives

- Contrast the use cases for sessions and permanent storage
- Define and then access a session variable in a Rails application
- Add sign-in, sign-up and sign-out functionality to a Rails application

Today we'll be adding a pretty huge feature to Tunr: user authentication. By that we mean the ability for a user to sign up, sign in and sign out of an application. This a big move for us since, up until this point, all of our applications have had one single user.

In implementing this feature, we will be learning about an important feature in Rails: Sessions. Sessions are not unique to Rails but are an important concept to understand as we dive further into user authentication in future classes.

## [I Do: Intro to Sessions](sessions-intro.md) (20 minutes)

Sessions are not specific to user authentication. They can be used for a number of things. [Let's talk about them at a higher level](sessions-intro.md).

## [Setup & Logistics](setup.md) (10 minutes)

The rest of this lesson will be primarily exercise-based. Before you dive into them, [let's spend some time making sure we're all set up properly](setup.md).

## [You Do: Adding Sessions](adding-sessions.md) (40 minutes)

> 30 minutes exercise. 10 minutes review.

<details>
  <summary><strong>Why can't we just add an `is_signed_in` column to our `users` table?</strong></summary>

  > How would Rails know how to sign out? More importantly, if multiple users are accessing the app, how would Rails know which signed in user is on which computer?

</details>

Our goals for this exercise...
  1. Allow a user to sign into Tunr
  2. Allow a user to sign out of Tunr

[Click here to get started.](adding-sessions.md)

### Reflect

- What's the difference between `resources` and `resource`?
- True or false: Every controller has to have a model, and vice-versa.
- What's the difference between the Sessions controller and the Users controller?
- What's the benefit of putting a method in the Application Controller?
- What's is a `before_action`?
- What's the difference between `params` and `session`?

### Shortcomings

- How are you told if you entered the wrong password?
- What can you do when you're signed in that you can't when you're not signed in?

## Break (10 minutes)

## [You Do: Add Permissions](adding-permissions.md) (30 minutes)

> 20 minutes exercise. 10 minutes review.

Users can now sign in and out of Tunr. Now let's make it so that only certain things can be done by signed in users. For example...
- Only signed-in users should be able to sign out of Tunr.
- A user should be the only one able to change his/her username or password.

[Your next exercise is to add these and other permissions to Tunr.](adding-permissions.md)

### Reflect

- How are permissions related to sessions?
- What's the difference between adding permissions on the front-end and the back-end?

## Break (10 minutes)

## [You Do: Adding Flash](adding-flash.md) (30 minutes)

> 20 minutes exercise. 10 minutes review.

It isn't helpful to the end-user if errors are only `puts`ed to the Terminal. They need error messages they can see in the browser!

Rails helps us with a feature called "Flash", a method for showing error messages to users that relies on sessions.

[For your next exercise, you will learn how to implement Flash.](adding-flash.md)

### Reflect

- Across how many browser requests or controller actions is a flash message available?
- What are the two conventional types of flash messages, and what's the difference between them?
- True or false: Flash should be used to store information from the database.

--------

## Features To Implement If You Finish Early

- For each Artist and Song, show the username of the person who submitted it
- On each User page, show all the Artists and Songs they've submitted
- Prevent someone from signing up with a username that's already in use
- Prevent someone from editing Songs and Artists they did not create

Some of these things have been addressed [in the solution branch.](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/6)

--------

# Bonuses

## Cookies

This next "You Do" is **individual**: it doesn't involve writing any code, so do it on your own computer.

### [You Do: Exploring Cookies](exploring-cookies.md)

### Reflect

- What's the difference between a cookie and a session?
- How do sessions use cookies?
- Cookies seem to be really concerned with security, considering "secure connections only", "accessible to script", expiration dates, and so on. Why?
- What would make you choose to put something in a cookie versus in a session?

Please go back to pair-programming:

### [You Do: Adding Cookies](adding-cookies.md)

## Important Note About Security

This version of Tunr breaks the fundamental rule of web security: Don't store passwords as plain text, even in a database. They should always be encrypted.

That said, security is *complicated*, and you shouldn't let it prevent you from making an app (hence why we're not worrying about it here).

--------

## References

- Screencasts
  - WDI 8, Robin
    - [Part 1](https://youtu.be/3YK3qDwnkQ8)
    - [Part 2](https://youtu.be/w51DnoJUsLA)
    - [Part 3](https://youtu.be/YYEtEsFE9Mw)
    - [Part 4](https://youtu.be/N67YBiLkrSE)
    - [Part 5](https://youtu.be/3h34Guspvp8)
