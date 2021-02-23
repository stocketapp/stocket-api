require 'test_helper'

class ShareTest < ActiveSupport::TestCase
  test 'Can create a share' do
    share = Share.create!(user_id: 1, symbol: 'AMZN', price: 134.89, trade_reference_id: '123')

    assert !share.nil?
  end

  test 'Can delete (A.K.A sell shares)' do
    share = Share.create!(user_id: 1, symbol: 'AMZN', price: 134.89, trade_reference_id: '123')
    share.destroy!

    assert share['data'].nil?
  end
end