# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default
# values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with
# db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.find_or_initialize_by(email: ENV.fetch("SEED_ADMIN_EMAIL", "admin@example.com")) do |u|
  password = ENV.fetch("SEED_ADMIN_INITIAL_PASSWORD", SecureRandom.hex(64))

  u.password = u.password_confirmation = password
  u.admin = true
end
user.save!(validate: false)
