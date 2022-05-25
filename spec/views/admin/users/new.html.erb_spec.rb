# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/users/new", type: :view do
  it "renders new user form" do
    user = User.new
    assign(:user, user)

    render

    email_selector = [
      "input",
      "[type=email]",
      "[name='user[email]']",
      "[placeholder='name@address.com']"
    ].join

    name_selector = [
      "input",
      "[type=text]",
      "[name='user[name]']",
      "[placeholder='Name']"
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

    submit_selector = [
      "[data-react-component=Button]"
    ].join

    expect(rendered).to have_content("Admin Area")
    expect(rendered).to have_content("Create new user")
    expect(rendered).to have_css(email_selector)
    expect(rendered).to have_css(name_selector)
    expect(rendered).to have_css(password_selector)
    expect(rendered).to have_css(password_confirmation_selector)
    expect(rendered).to have_css(submit_selector)
    expect(rendered).to have_link("Cancel", href: admin_users_path.to_s)
  end
end
