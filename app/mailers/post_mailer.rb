# frozen_string_literal: true

# This class handles the email notifications related to posts.
class PostMailer < ApplicationMailer
  def send_email(action, title, user_email)
    @title = title
    @user_email = user_email
    @action = action
    mail(to: @user_email, subject: "Post #{@action}")
  end
end
