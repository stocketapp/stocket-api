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
      trades = query['data']
      puts trades
      assert !trades.nil?
    end
  end
end