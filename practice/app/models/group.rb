class Group < ActiveRecord::Base
  belongs_to :user
  has_many :joins, dependent: :destroy
  has_many :users_joined, through: :joins, source: :user

  validates :name, presence: true, length: {minimum: 5}
  validates :description, presence: true, length: {minimum: 10}

  def self.with_user group_id
    self.joins(:user).where("group_id = ?", group_id).select(:id, :first_name, :last_name, :email, :user_id, :created_at).first
  end
end
