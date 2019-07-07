require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome_email" do
    let(:user) { User.create(email: "abc@def.com", password: "password") }

    it "should send email" do
      expect { described_class.with(user: user).welcome_email.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  describe "password reset email" do
    let(:user) { User.create(reset_token: SecureRandom.hex(10), email: "abc@def.com", password: "password") }

    subject { described_class.with(user: user).password_reset_email.deliver_now }

    it "should send email" do
      expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "should contain link to reset password" do
      expect(subject.body.encoded).to include(user.reset_token)
    end
  end
end
