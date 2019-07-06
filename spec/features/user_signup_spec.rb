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

  context "failure" do
    it "does not create a new user" do
      visit(new_user_path)
      fill_in("Password", with: "password")
      fill_in("Password confirmation", with: "password")
      click_button("Sign Up")
      expect(User.count).to eq(0)
      expect(page).to have_content("Email can't be blank")
    end
  end
end
