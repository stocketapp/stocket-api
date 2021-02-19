require 'test_helper'

module Mutations
  class CreateTradeTest < ActionDispatch::IntegrationTest
    mutation_string = <<-GRAPHQL
      mutation CreateTrade($input: CreateTradeInput!) {
        createTrade(input: $input) {
          symbol
          total
          orderDate
        }
      }
    GRAPHQL
    input = {
      symbol: 'AAPL',
      price: 123.95,
      quantity: 2,
      orderType: 'BUY',
      uid: 2,
    }
    context = {
      current_user: {
        id: 2
      }
    }

    test 'create a trade' do
      trade = StocketApiSchema.execute(mutation_string, variables: { input: input }, context: context)
      result = trade['data']['createTrade']
      assert !result.nil?
    end
  end
end