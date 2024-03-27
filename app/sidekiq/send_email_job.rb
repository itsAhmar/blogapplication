# frozen_string_literal: true

# This class represents a Sidekiq background job for sending emails asynchronously.
class SendEmailJob
  include Sidekiq::Job

  def perform(action, title, user_email)
    PostMailer.send_email(action, title, user_email).deliver_now
  end
end
