require "rails_helper"

RSpec.describe "login" do
  let!(:user) { User.create(email: "test@test.com", password: "password") }

  context "success" do
    it "allows users to login" do
      visit(login_path)
      fill_in("Email", with: "test@test.com")
      fill_in("Password", with: "password")
      click_button("Login")
      expect(current_path).to eq(user_path(user))
    end
  end

  context "failure" do
    it "redirects back to login page on failed login" do
      visit(login_path)
      fill_in("Email", with: "nonexistinguser@test.com")
      fill_in("Password", with: "password")
      click_button("Login")
      expect(page).to have_content("Email or password is invalid.")
    end
  end
end
