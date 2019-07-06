class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  before_create :set_username

  private

  def set_username
    self.username = email.split("@")[0]
  end
end
