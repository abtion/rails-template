# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/users/index" do
  it "renders users index page" do
    enable_pundit(view, build(:user, :admin))

    user = create(:user)
    assign(:users, [user])

    render

    expect(rendered).to have_text("Users")

    expect(rendered).to have_link("Create new user", href: new_admin_user_path.to_s)

    expect(rendered).to have_css("tr th", text: "Email")
    expect(rendered).to have_css("tr td", text: user.email.to_s)

    expect(rendered).to have_css("tr th", text: "Name")
    expect(rendered).to have_css("tr td", text: user.name.to_s)

    expect(rendered).to have_css("tr th", text: "Created at")
    expect(rendered).to have_css("tr td", text: user.created_at.strftime("%d %b %H:%M").to_s)
    expect(rendered).to have_link("Edit", href: edit_admin_user_path(user).to_s)
  end
end
