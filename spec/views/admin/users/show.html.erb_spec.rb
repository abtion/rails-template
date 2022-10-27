# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/users/show" do
  it "renders user show page" do
    enable_pundit(view, build(:user, :admin))

    user = create(:user)
    assign(:user, user)

    render

    expect(rendered).to have_content(user.email)

    expect(rendered).to have_link("Back", href: admin_users_path.to_s)
    expect(rendered).to have_link("Edit", href: edit_admin_user_path(user).to_s)
    expect(rendered).to have_css(
      "a[href='#{admin_user_path(user)}'][data-method='delete'][data-confirm='Are you sure?']",
      text: "Delete"
    )

    expect(rendered).to have_css("tr th", text: "Email")
    expect(rendered).to have_css("tr td", text: user.email.to_s)

    expect(rendered).to have_css("tr th", text: "Name")
    expect(rendered).to have_css("tr td", text: user.name.to_s)

    expect(rendered).to have_css("tr th", text: "Created at")
    expect(rendered).to have_css("tr td", text: user.created_at.strftime("%d %b %H:%M").to_s)
  end
end
