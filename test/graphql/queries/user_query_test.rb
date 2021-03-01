require 'test_helper'

module Mutations
  class UserQueryTest < ActionDispatch::IntegrationTest
    query_string = <<-GRAPHQL
      query {
        user {
          portfolioValue
        }
      }
    GRAPHQL

    test 'Can get the portfolio value' do
      context = { current_user: { uid: '123' } }
      query = StocketApiSchema.execute(query_string, variables: nil, context: context)

      assert_not query['data']['user']['portfolioValue'].nil?
    end
  end
end
