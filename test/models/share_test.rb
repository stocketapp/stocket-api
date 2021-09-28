require 'test_helper'

class ShareTest < ActiveSupport::TestCase
  test 'Can create a share (BUY)' do
    share = Share.create!(
      user_id: 1,
      symbol: 'AMZN',
      price: 134.69,
      trade_reference_id: '321',
      size: 3,
      purchase_value: 404.07
    )

    assert !share.nil?
  end

  test 'Can delete (SELL)' do
    share = Share.create!(
      user_id: 1,
      symbol: 'AMZN',
      price: 134.69,
      trade_reference_id: '654',
      size: 3,
      purchase_value: 404.07
    )
    share.destroy!

    assert share['data'].nil?
  end
end
