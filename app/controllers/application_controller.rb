# frozen_string_literal: true

# ApplicationController serves as the base controller for all other controllers in the application.
# It includes common functionality and configurations shared across controllers.
class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  include Pagy::Backend
end
