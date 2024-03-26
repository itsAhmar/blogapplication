class PostMailer < ApplicationMailer

  def create_post(object)
    @object = object
    mail(to: @object.user.email, subject: "Post Created")
  end

  def delete_post(title, user_email)
    @user_email = user_email
    @title = title
    mail(to: @user_email, subject: "Post Deleted")
  end
end

 