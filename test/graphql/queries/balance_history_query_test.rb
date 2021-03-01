require 'minitest/autorun'

module Queries
  class BalanceHistoryQueryTest < ActionDispatch::IntegrationTest
    query_string = <<-GRAPHQL
        query {
          balanceHistory {
            value
            createdAt
          }
        }
    GRAPHQL
    context = { current_user: { id: 1, uid: '123' } }

    test 'Can get a user balance history' do
      query = StocketApiSchema.execute(query_string, { variables: nil, context: context })

      assert_not query['data']['balanceHistory'].empty?
    end
  end
end

