class Join < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :group, :user, presence: true
end
