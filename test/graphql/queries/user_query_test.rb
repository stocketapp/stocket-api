require 'test_helper'

module Queries
  class UserQueryTest < ActionDispatch::IntegrationTest
    query_string = <<-GRAPHQL
      query {
        user {
          portfolio
        }
      }
    GRAPHQL
    context = { current_user: { uid: '123', id: 1 } }

    test 'Can get the portfolio value' do
      context = { current_user: { uid: '123' } }
      query = StocketApiSchema.execute(query_string, variables: nil, context: context)

      assert_not query['data']['user']['portfolio'].nil?
    end
  end
end
