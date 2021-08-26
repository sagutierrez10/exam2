class User < ActiveRecord::Base
  has_secure_password
  has_many :groups, dependent: :destroy
  has_many :groups_joined, through: :joins, source: :group

  validates :first_name, :last_name, presence: true
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  before_validation :downcase_fields
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

  private
  def downcase_fields
    self.email.downcase!
  end
end
