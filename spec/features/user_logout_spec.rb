require "rails_helper"

RSpec.describe "logout" do
  let(:user) { User.create(email: "test@test.com", password: "password") }

  it "allows users to logout" do
    visit(user_path(user))
    click_on("Logout")
    expect(current_path).to eq(login_path)
  end
end

