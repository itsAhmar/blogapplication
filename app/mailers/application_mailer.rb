# frozen_string_literal: true

# Base mailer class for the application
class ApplicationMailer < ActionMailer::Base
  default from: 'Jack <support.blogapplication@gmail.com>'
  layout 'mailer'
end
