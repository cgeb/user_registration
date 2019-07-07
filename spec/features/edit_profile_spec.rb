require "rails_helper"

RSpec.describe "edit profile" do
  let(:user) { User.create(email: "test@test.com", password: "password") }

  context "success" do
    it "allows user to edit profile" do
      visit(edit_user_path(user))
      fill_in("Username", with: "ckg61386")
      fill_in("Password", with: "password2")
      fill_in("Password confirmation", with: "password2")
      click_button("Update")
      expect(current_path).to eq(user_path(user))
      expect(page).to have_content("ckg61386")
    end
  end

  context "failure" do
    it "does not edit profile if invalid" do
      visit(edit_user_path(user))
      fill_in("Username", with: "aaa")
      click_button("Update")
      expect(page).to have_content("Username is too short")
    end
  end
end
