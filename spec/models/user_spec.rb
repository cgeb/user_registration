require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(email: "abc@def.com", password: "password") }

  describe ".username" do
    it "sets username as email name on create" do
      expect(user.username).to eq("abc")
    end
  end

  describe ".generate_reset_token" do
    it "sets the users reset token" do
      user.generate_reset_token
      expect(user.reload.reset_token).not_to be_nil
    end
  end
end
