


require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
# require "action_mailbox/engine"
# require "action_text/engine"
require 'action_view/railtie'
# require 'action_cable/engine'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application
    config.load_defaults 7.0

    config.api_only = true

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja

    # https://github.com/lynndylanhurley/devise_token_auth/issues/1536
    config.action_controller.raise_on_open_redirects = false

    config.generators do |g|
      g.test_framework :rspec
    end

    # userのSTI設定
    config.autoload_paths += %W[#{config.root}/app/models/user]

    # ストロングパラメータで許可しないパラメータが存在した場合、エラーを返す
    config.action_controller.action_on_unpermitted_parameters = :raise
  end
end
