# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/users/index", type: :view do
  it "renders users index page" do
    user = create(:user)
    assign(:users, [user])

    render

    expect(rendered).to have_content("Admin Area")
    expect(rendered).to have_content("Users")

    expect(rendered).to have_link("Create new user", href: new_admin_user_path.to_s)

    expect(rendered).to have_css("tr th", text: "Email")
    expect(rendered).to have_css("tr td", text: user.email.to_s)

    expect(rendered).to have_css("tr th", text: "Name")
    expect(rendered).to have_css("tr td", text: user.name.to_s)

    expect(rendered).to have_css("tr th", text: "Created at")
    expect(rendered).to have_css("tr td", text: user.created_at.strftime("%d %b %H:%M").to_s)
    expect(rendered).to have_css("[data-react-component=Link]", count: 2)
    expect(rendered).to match(admin_user_path(user).to_s)
    expect(rendered).to match(edit_admin_user_path(user).to_s)
  end
end
