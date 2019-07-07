class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :username, length: { minimum: 5 }, on: :update
  validates :password, length: { minimum: 8 }

  before_create :set_username

  def generate_reset_token
    self.reset_token = SecureRandom.hex(10)
    self.reset_sent_at = Time.zone.now
    save!(validate: false)
  end

  private

  def set_username
    self.username = email.split("@")[0]
  end
end
