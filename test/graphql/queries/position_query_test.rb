require 'test_helper'

module Mutations
  class PositionQueryTest < ActionDispatch::IntegrationTest
    query_string = <<-GRAPHQL
      query GetPosition($symbol: String) {
        position(symbol: $symbol) {
          symbol
          pctChange
        }
      }
    GRAPHQL
    context = { current_user: { id: 1 }}

    test 'Something in Position' do
      query = StocketApiSchema.execute(query_string, variables: { symbol: 'AMZN' }, context: context)
      puts query['data']
    end
  end
end