require 'test_helper'

module Mutations
  class TradeMutationsTest < ActionDispatch::IntegrationTest
    fixtures :all
    mutation_string = <<-GRAPHQL
      mutation CreateTrade($input: CreateTradeInput!) {
        createTrade(input: $input) {
          symbol
          total
          userId
        }
      }
    GRAPHQL

    test 'Create a trade' do
      input = {
        symbol: 'AAPL',
        price: 123.95,
        quantity: 2,
        orderType: 'BUY'
      }
      context = { current_user: { id: 1 }}
      trade = StocketApiSchema.execute(mutation_string, variables: { input: input }, context: context)
      assert !trade['data']['createTrade'].nil?
    end

    test 'Error when input is wrong' do
      input = {
        symbol: 'AAPL',
        price: '123.95',
        quantity: 2,
        orderType: 'BUY'
      }
      context = { current_user: { id: 2 }}
      trade = StocketApiSchema.execute(mutation_string, variables: { input: input }, context: context)

      assert !trade['errors'].nil?
    end
  end
end