require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'Creates user' do
    user = User.new(uid: 1, name: 'Test User', email: 'test@stocket.com')

    assert_equal user.name, 'Test User'
    assert_equal user.email, 'test@stocket.com'
  end
end
