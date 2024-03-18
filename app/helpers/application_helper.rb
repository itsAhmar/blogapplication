# frozen_string_literal: true

# Helper methods available across the application
module ApplicationHelper
  include Pagy::Frontend

  def formatted_date(date)
    date.strftime('%B %e, %Y')
  end

  def split_email(email)
    email.split('@').first
  end

  def truncate_description(des)
    des.truncate(120, separator: ' ')
  end

  def user_image(obj)
    image_tag obj, class: 'rounded-circle', width: '40', height: '40'
  end
end
