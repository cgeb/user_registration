require "rails_helper"

RSpec.describe "reset password" do
  let!(:user) { User.create(email: "ckg61386@gmail.com", password: "password") }

  context "success" do
    it "allows users reset their password" do
      visit(new_password_reset_path)
      fill_in("Email", with: "ckg61386@gmail.com")
      click_button("Send Reset Password Instructions")
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Check your Email for further instructions")

      visit(edit_password_reset_path(user.reload.reset_token, email: user.email))
      fill_in("New Password", with: "password2")
      fill_in("New Password Confirmation", with: "password2")
      click_button("Update Password")
      expect(current_path).to eq(user_path(user))
    end
  end

  context "failure" do
    it "handles trying to request password reset for non-existing user" do
      visit(new_password_reset_path)
      fill_in("Email", with: "nonexistinguser@test.com")
      click_button("Send Reset Password Instructions")
      expect(page).to have_content("Email address not found")
    end

    it "handles incorrect tokens" do
      visit(new_password_reset_path)
      fill_in("Email", with: "ckg61386@gmail.com")
      click_button("Send Reset Password Instructions")
      visit(edit_password_reset_path("xxxxxxx", email: user.email))
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Email or reset token is invalid")
    end

    it "handles expired tokens" do
      visit(new_password_reset_path)
      fill_in("Email", with: "ckg61386@gmail.com")
      click_button("Send Reset Password Instructions")
      user.update_column(:reset_sent_at, 7.hours.ago)
      visit(edit_password_reset_path(user.reload.reset_token, email: user.email))
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Token is expired")
    end
  end
end
