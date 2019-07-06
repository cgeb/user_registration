require "rails_helper"

RSpec.describe "signup" do
  context "success" do
    it "create a new user" do
      visit(new_user_path)
      fill_in("Email", with: "ckg61386@gmail.com")
      fill_in("Password", with: "password")
      fill_in("Password confirmation", with: "password")
      click_button("Sign Up")
      created_user = User.last
      expect(current_path).to eq(user_path(created_user))
      expect(page).to have_content("Profile for ckg61386")
    end
  end
end
