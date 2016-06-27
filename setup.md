## Framing

Currently, Tunr just supports one single "God" user. It would be nice if it could have multiple users. Each could have their own list of Artists and Songs that they'd added.

### [Please clone down this repo.](https://github.com/ga-wdi-exercises/tunr_rails_users)

```
$ cd tunr_rails_users
$ git checkout 1-added-users
$ bundle install
$ rake db:create db:migrate db:seed
$ rails s
```

This class is going to be mostly you walking through README files with a partner, adding functionality to Tunr.

In any step that asks you to add code, there will be a link to a "diff" page on Github that shows you that particular piece of code being added.

### Logistics

With your partner, please pick one computer to be the "driving" computer, and one to be the "navigating" computer.

All of the coding will be done on the "driving" computer; the "navigating" computer will be used for looking things up.

After each section, we'll ask you to *physically* switch computers: whoever was on the "driving" computer should start using the "navigating" computer, and vice-versa.

This means:

- By the end of class only one of the two computers will have any code on it.
- You will be using someone else's computer. (So wash your hands and cover your mouth when you sneeze.)

The reasons for this:

- To practice pair programming and rubber ducking
- Loading Github's "diff" pages is a little slow. Using two computers, you can speed things up by looking at the diff pages only on the "navigating" computer.
- All the code you'll be writing is on Github, so there's not really an advantage to writing it out

#### "But I want to comment the code!"

You can *comment on the commits themselves on Github*. (This is **optional**.) Your classmates will be able to see your comments, and you can see theirs!

When looking at a "diff" page, just mouse over the line number and a blue `+` box should show up. Click on it to add your comment.

![Github comments](images/gh-comments.jpg)

#### Too many comments?

Github includes jQuery on all its webpages. To hide the comments, just open the console in your browser and enter:

```js
$(".inline-comments").hide()
```

### After each "You Do"

Please checkout the solution branch for that particular You Do (except for the Adding Differentiation section, which has the same branch as Adding Sessions).

```
$ git checkout 1-added-users
```

This way we'll all stay on the same page, and will have fewer set-up errors caused by one person's code looking different from another person's code.

**If you get an error**, simply `add` and `commit`, then try checking out again.