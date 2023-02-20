require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RpsRails
  class Application < Rails::Application
    config.load_defaults 7.0
    Rails.application.config.assets.version = '1.0'
    Rails.application.config.assets.precompile += %w( start.css )
  end
end
