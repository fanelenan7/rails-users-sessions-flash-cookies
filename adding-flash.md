# Adding Flash

Flash is a hash that is generated in one controller action, and is accessible only in the *next* controller action. It is used only to contain messages to the user, not any other sort of data.

By convention, there are two types of flash messages: alerts and notices. Alerts are used for warnings and errors; notices are used for everything else.

## 1. Replace every `puts` with the appropriate `flash`

Check for `puts` statements in the Application, Sessions, and Users controllers. For instance:

### [session#create](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/4/files#diff-d5241d488259f32ecbe2f636133e5ddaR12)

Whether you make a particular message an `alert` or `notice` is up to you. But remember convention: alerts are used for warnings and errors, and notices are used for everything else.

## [2. Show the messages in your user interface](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/4/files#diff-9599427925097c3c66f26ac1e0de5cadR23)

We can't actually see the flashes yet because we haven't put them anywhere in our `.html.erb` files yet.

The simplest place to put `flash` messages is in the `layouts/application.html.erb` page. That's because it's the wrapper into which every other view is inserted. If we include `flash` in this file, we're automatically including it in every view.

> Notice how files named `application` tend to affect every other file of that type?

The reason we're writing `|type, message|` -- including both the key and value of each Flash -- instead of just `|message|` will be explained in the next step.

Try making flash messages show up.

## [3. Differentiate between alerts and notices](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/4/files#diff-fb7484bc2f56c263954da6fc44982eeaR96)

We wrote `|type, message|` instead of just `|message|` because it gives us a handy way of styling alerts and notices differently from each other. We can use each `type` as an HTML class. We'll make Alerts red, and Notices blue.

Try making flash messages show up. Refresh the page. What happens?
