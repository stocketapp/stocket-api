class User < ApplicationRecord
  has_one :user_info

  def user(user)
    User.find_by uid: user.uid
  end
end
