# frozen_string_literal: true

module ProjectNamePascal
  class Application < Rails::Application
    config.i18n.available_locales = [:da, :en]
    config.i18n.default_locale = ENV.fetch("LOCALE", "en")
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.yml")]
  end
end
