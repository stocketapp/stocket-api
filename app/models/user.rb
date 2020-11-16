class User < ApplicationRecord
  has_one :user_info

  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: true

  def user(user)
    User.find_by uid: user.uid
  end
end
