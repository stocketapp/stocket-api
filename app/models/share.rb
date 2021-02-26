class Share < ApplicationRecord
  belongs_to :user

  def self.position(symbol)
  end
end