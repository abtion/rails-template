# frozen_string_literal: true

return if Rails.env.production?

Rails.application.configure do
  config.after_initialize do
    Bullet.enable = true
    Bullet.bullet_logger = true

    if Rails.env.development?
      Bullet.alert = true
      Bullet.console = true
      Bullet.rails_logger = true
      Bullet.add_footer = true
    end

    if Rails.env.test?
      Bullet.raise = true # raise an error if n+1 query occurs
      Bullet.unused_eager_loading_enable = false
    end
  end
end
