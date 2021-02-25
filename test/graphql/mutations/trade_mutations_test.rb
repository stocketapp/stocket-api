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
          orderType
        }
      }
    GRAPHQL
    user_one = { current_user: { id: 1 }}
    user_two = { current_user: { id: 2 }}
    buy_input = {
      symbol: 'AAPL',
      price: 123.95,
      quantity: 4,
      orderType: 'BUY'
    }
    wrong_input = {
      symbol: 'AAPL',
      price: '123.95',
      quantity: 2,
      orderType: 'BUY'
    }
    sell_input = {
      symbol: 'AAPL',
      price: 123.95,
      quantity: 2,
      orderType: 'SELL'
    }

    test 'Create a trade' do
      trade = StocketApiSchema.execute(mutation_string, variables: { input: buy_input }, context: user_one)

      assert !trade['data']['createTrade'].nil?
    end

    test 'It calculates total' do
      trade = StocketApiSchema.execute(mutation_string, variables: { input: buy_input }, context: user_one)
      total = trade['data']['createTrade']['total']
      
      assert_equal total, 495.8
    end

    test 'Error when input is wrong' do
      trade = StocketApiSchema.execute(mutation_string, variables: { input: wrong_input }, context: user_two)

      assert !trade['errors'].nil?
    end

    test 'Add shares when order type is "BUY"' do
      trade = StocketApiSchema.execute(mutation_string, variables: { input: buy_input }, context: user_two)
      reference_id = trade['data']['createTrade']['referenceId']
      shares = Share.where trade_reference_id: reference_id

      assert_equal shares.length, 4
    end

    test 'Decrease cash when buying' do
      StocketApiSchema.execute(mutation_string, variables: { input: buy_input }, context: user_two)
      user = User.find_by id: 2

      assert_equal user[:cash], 18016.8
    end

    test 'Sell shares when order type is "SELL"' do
      StocketApiSchema.execute(mutation_string, variables: { input: buy_input }, context: user_two)
      trade = StocketApiSchema.execute(mutation_string, variables: { input: sell_input }, context: user_two)
      shares_length = Share.where(symbol: trade['data']['createTrade']['symbol']).length

      assert_equal shares_length, 2
    end
  end
end