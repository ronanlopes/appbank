require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Appbank
  class Application < Rails::Application
    # S# Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Brasilia'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :"pt-BR"

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.exceptions_app = self.routes

    config.serve_static_files = true

    if Rails.env.production?
      # config.action_mailer.smtp_settings = {
      #   :address => 'smtp.mandrillapp.com',
      #   :port => 587,
      #   :domain => 'impulsoti.com.br',
      #   :user_name => 'impulsoproject@impulsoti.com.br',
      #   :password => 'CRnK9kmfVDDYNot9YcFeBg',
      #   :authentication => 'plain',
      #   :enable_starttls_auto => true
      # }
    else
      config.action_mailer.smtp_settings = { address: "localhost", port: 1025 }
      config.action_mailer.default_url_options = { host: "localhost" }
    end
    config.action_mailer.delivery_method = :smtp
  end
end
