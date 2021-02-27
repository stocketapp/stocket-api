require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  test 'Can create a position' do
    position = Position.create!(user_id: 1, symbol: 'AMZN', price: 134.89, quantity: 4, trade_reference_id: '123')

    assert !position.nil?
  end

  test 'Can delete (A.K.A sell a position)' do
    position = Position.create!(user_id: 1, symbol: 'AMZN', price: 134.89, quantity: 4, trade_reference_id: '123')
    position.destroy!

    assert position['data'].nil?
  end
end