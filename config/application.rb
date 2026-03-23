# config/application.rb
require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
Bundler.require(*Rails.groups)

module MercariHelper
  class Application < Rails::Application
    config.load_defaults 7.2
    config.i18n.default_locale = :ja
    config.autoload_lib(ignore: %w[assets tasks])
  end
end
