# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/

class DeviseMailerPreview < ActionMailer::Preview
  def reset_password_instructions
    user = FactoryBot.build(:user)

    Devise::Mailer.reset_password_instructions(user, "faketoken")
  end

  def password_change
    user = FactoryBot.build(:user)

    Devise::Mailer.password_change(user)
  end
end
