require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome_email" do
    let(:user) { User.create(email: "abc@def.com", password: "password") }

    it "should send email" do
      expect { described_class.with(user: user).welcome_email.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
