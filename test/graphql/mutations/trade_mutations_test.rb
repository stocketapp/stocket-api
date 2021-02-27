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
      price: 124.95,
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
      trade = StocketApiSchema.execute(mutation_string, variables: { input: wrong_input }, context: user_one)

      assert !trade['errors'].nil?
    end

    test 'Add shares when order type is "BUY"' do
      trade = StocketApiSchema.execute(mutation_string, variables: { input: buy_input }, context: user_one)
      reference_id = trade['data']['createTrade']['referenceId']
      user_id = user_one[:current_user][:id]

      share = Share.find_by trade_reference_id: reference_id, user_id: user_id

      assert_equal share.size, 4
    end

    test 'Decrease cash when buying' do
      trade = StocketApiSchema.execute(mutation_string, variables: { input: buy_input }, context: user_one)
      user = User.find_by id: 1

      assert_equal user[:cash], 20_000 - trade['data']['createTrade']['total']
    end

    test 'Sell shares when order type is "SELL"' do
      buy_trade = StocketApiSchema.execute(mutation_string, variables: { input: buy_input }, context: user_one)
      reference_id = buy_trade['data']['createTrade']['referenceId']
      sell_trade = StocketApiSchema.execute(mutation_string, variables: { input: sell_input }, context: user_one)
      user_id = user_one[:current_user][:id]
      shares_size = Share.find_by(trade_reference_id: reference_id, user_id: user_id)[:size]

      assert_equal shares_size, 2
    end

    test 'Increase cash when selling' do
      StocketApiSchema.execute(mutation_string, variables: { input: buy_input }, context: user_one)
      old_cash = User.find_by(id: 1)[:cash]
      trade = StocketApiSchema.execute(mutation_string, variables: { input: sell_input }, context: user_one)
      total = trade['data']['createTrade']['total']
      cash = User.find_by(id: 1)[:cash]

      assert_equal cash, old_cash + total
    end
  end
end