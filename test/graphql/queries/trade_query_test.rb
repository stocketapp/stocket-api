require 'test_helper'

module Mutations
  class TradesQueryTest < ActionDispatch::IntegrationTest
    query_string = <<-GRAPHQL
      query {
        trades {
          symbol
          price
        }
      }
    GRAPHQL
    context = { current_user: { id: 1 }}

    test 'Can query all trades made by user' do
      query = StocketApiSchema.execute(query_string, variables: nil, context: context)
      assert query['data']['trades'].empty?
    end
  end
end