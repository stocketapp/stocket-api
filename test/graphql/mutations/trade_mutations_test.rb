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
          referenceId
        }
      }
    GRAPHQL
    user_one = { current_user: { id: 1 }}
    user_two = { current_user: { id: 2 }}
    input = {
      symbol: 'AAPL',
      price: 123.95,
      quantity: 2,
      orderType: 'BUY'
    }
    wrong_input = {
        symbol: 'AAPL',
        price: '123.95',
        quantity: 2,
        orderType: 'BUY'
      }

    test 'Create a trade' do
      trade = StocketApiSchema.execute(mutation_string, variables: { input: input }, context: user_one)

      assert !trade['data']['createTrade'].nil?
    end

    test 'Error when input is wrong' do
      trade = StocketApiSchema.execute(mutation_string, variables: { input: wrong_input }, context: user_two)

      assert !trade['errors'].nil?
    end

    test 'Create position when trade is created' do
      trade = StocketApiSchema.execute(mutation_string, variables: { input: input }, context: user_two)
      reference_id = trade['data']['createTrade']['referenceId']
      pos = Position.find_by trade_reference_id: reference_id

      assert_equal reference_id, pos.trade_reference_id
    end
  end
end