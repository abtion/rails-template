# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/users/edit" do
  it "renders edit user form" do
    user = create(:user)
    assign(:user, user)

    render

    email_selector = [
      "input",
      "[type=email]",
      "[name='user[email]']",
      "[value=#{user.email.to_json}]"
    ].join

    name_selector = [
      "input",
      "[type=text]",
      "[name='user[name]']",
      "[value=#{user.name.to_json}]"
    ].join

    password_selector = [
      "input",
      "[type=password]",
      "[name='user[password]']",
      "[placeholder='Enter password']"
    ].join

    password_confirmation_selector = [
      "input",
      "[type=password]",
      "[name='user[password_confirmation]']",
      "[placeholder='Password confirmation']"
    ].join

    expect(rendered).to have_content("Edit user: #{user.email}")
    expect(rendered).to have_css(email_selector)
    expect(rendered).to have_css(name_selector)
    expect(rendered).to have_css(password_selector)
    expect(rendered).to have_css(password_confirmation_selector)
    expect(rendered).to have_button("Save")
    expect(rendered).to have_link("Back", href: admin_users_path)
  end
end
