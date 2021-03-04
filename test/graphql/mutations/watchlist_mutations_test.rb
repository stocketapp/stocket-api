require 'test_helper'

module Mutations
  class WatchlistMutationsTest < ActionDispatch::IntegrationTest
    watchlist_mutation = <<-GRAPHQL
      mutation AddToWatchlist($input: AddToWatchlistInput!) {
        addToWatchlist(input: $input) {
          symbol
          changePercent
          id
        }
      }
    GRAPHQL
    test 'Add symbol to watchlist' do
      input = { symbol: 'MSFT' }
      context = { current_user: { id: 1 }}
      added_symbol = StocketApiSchema.execute(watchlist_mutation, variables: { input: input}, context: context)

      assert_not added_symbol['data']['addToWatchlist']['id'].nil?
    end

    test 'Error when input is of wrong type' do
      input = { symbol: 1 }
      context = { current_user: { id: 2 }}
      added_symbol = StocketApiSchema.execute(watchlist_mutation, variables: { input: input }, context: context)

      assert !added_symbol['errors'].nil?
    end

    test 'Successfully remove symbol' do
      input = { symbol: 'FB' }
      context = { current_user: { id: 1 }}
      mutation = <<-GRAPHQL
        mutation RemoveFromWatchlist($input: RemoveFromWatchlistInput!) {
          removeFromWatchlist(input: $input) {
            symbol
          }
        }
      GRAPHQL
      removed_symbol = StocketApiSchema.execute(mutation, variables: { input: input }, context: context)

      assert !removed_symbol['data']['removeFromWatchlist'].nil?
    end
  end
end
