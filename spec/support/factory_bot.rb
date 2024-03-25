# frozen_string_literal: true

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include ActiveStorage::Blob::Analyzable
end
