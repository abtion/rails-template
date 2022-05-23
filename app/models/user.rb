# frozen_string_literal: true

class User < ApplicationRecord
  include ApiAuthenticable

  # Included devise modules. Others available are:
  # :registerable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :pwned_password
end
