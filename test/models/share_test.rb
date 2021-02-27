require 'test_helper'

class ShareTest < ActiveSupport::TestCase
  test 'Can create a share' do
    share = Share.create!(user_id: 1, symbol: 'AMZN', price: 134.69, trade_reference_id: '123', size: 3, purchase_value: 404.07)

    assert !share.nil?
  end

  test 'Can delete (A.K.A sell shares)' do
    share = Share.create!(user_id: 1, symbol: 'AMZN', price: 134.69, trade_reference_id: '123', size: 3, purchase_value: 404.07)
    share.destroy!

    assert share['data'].nil?
  end
end