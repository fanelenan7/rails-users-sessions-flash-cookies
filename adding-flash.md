# Adding Flash

> If you need some starter code for this section, checkout the `2-added-sessions` branch of [`tunr_rails_users`](https://github.com/ga-wdi-exercises/tunr_rails_users/tree/2-added-sessions).

Flash is a hash that is generated in one controller action, and is accessible only in the *next* controller action. It is used only to contain messages to the user, not any other sort of data.

Think of flash as a session that only lasts for one request.

By convention, there are two types of flash messages: alerts and notices.
- Alerts are used for warnings and errors
- Notices are used for everything else

## 1. Replace every `puts` with the appropriate `flash`

Check for `puts` statements in the Application, Sessions and Users controllers. For example...

```rb
# app/controllers/sessions_controller.rb

def create
  input_username = params[:user][:username]
  if User.exists?(username: input_username)
    @user = User.find_by(username: input_username)
    if @user.password === params[:user][:password]
      # The below line replaces `puts "You're signed in!"`
      flash[:notice] = "You're signed in!"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:alert] = "Wrong password!"
      redirect_to new_session_path
    end
  else
    flash[:alert] = "That user doesn't exist!"
    redirect_to new_session_path
  end
end
```

Whether you make a particular message an `alert` or `notice` is up to you. But remember convention: alerts are used for warnings and errors, and notices are used for everything else.

## [2. Show the messages in your user interface](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/4/files#diff-9599427925097c3c66f26ac1e0de5cadR23)

We can't actually see the flashes yet because we haven't put them anywhere in our `.html.erb` files yet.

The simplest place to put `flash` messages is in the `layouts/application.html.erb` page. That's because it's the wrapper into which every other view is inserted. If we include `flash` in this file, we're automatically including it in every view.

> Notice how files named `application` tend to affect every other file of that type?

```html
<!-- application.html.erb -->

<% flash.each do |type, message| %>
  <p class="<%= type %>"><%= message %></p>
<% end %>
```

The reason we're writing `|type, message|` -- including both the key and value of each Flash -- instead of just `|message|` will be explained in the next step.

## [3. Differentiate Between Alerts and Notices](https://github.com/ga-wdi-exercises/tunr_rails_users/pull/4/files#diff-fb7484bc2f56c263954da6fc44982eeaR96)

We wrote `|type, message|` instead of just `|message|` because it gives us a handy way of styling alerts and notices differently from each other. We can use each `type` as an HTML class.

Inspect an alert and notice in the browser console. Based on what you see, add CSS to `app/assets/stylesheets/application.css` so that Alerts are red and Notices blue.

<details>
  <summary><strong>A solution...</strong></summary>

  ```css
  .alert{
     color:#f00;
  }

  .notice{
     color:#00f;
  }
  ```

</details>
