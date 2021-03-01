require 'test_helper'

module Queries
  class PositionQueryTest < ActionDispatch::IntegrationTest
    query_string = <<-GRAPHQL
      query {
        position(symbol: "AMZN") {
          symbol
          totalValue
          change
          changePct
          avgPrice
          positionSize
        }
      }
    GRAPHQL
    context = { current_user: { id: 1 }}
    position_query = StocketApiSchema.execute(query_string, variables: nil, context: context)

    test 'Can query a position' do
      symbol = position_query['data']['position']['symbol']
      assert_equal symbol, 'AMZN'
    end

    test 'Calculate the total value of the position' do
      value = position_query['data']['position']['totalValue']

      assert value
    end

    test 'Calculate the change of the position' do
      value = position_query['data']['position']['change']

      assert value
    end

    test 'Calculate the change percentage of the position' do
      value = position_query['data']['position']['changePct']

      assert value
    end

    test 'Calculate the average price of the position' do
      value = position_query['data']['position']['avgPrice']

      assert value
    end

    test 'Get the amount of shares owned' do
      value = position_query['data']['position']['positionSize']

      assert value
    end
  end
end
