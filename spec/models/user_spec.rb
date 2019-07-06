require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(email: "abc@def.com", password: "password") }

  describe ".username" do
    it "sets username as email name on create" do
      expect(user.username).to eq("abc")
    end
  end
end
