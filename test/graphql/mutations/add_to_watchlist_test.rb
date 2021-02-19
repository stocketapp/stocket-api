require 'test_helper'

module Mutations
  class WatchlistMutationsTest < ActionDispatch::IntegrationTest
    addToWatchlistMutation = <<-GRAPHQL
      mutation AddToWatchlist($input: AddToWatchlistInput!) {
        addToWatchlist(input: $input) {
          symbol
          id
        }
      }
    GRAPHQL
    test 'Add symbol to watchlist' do
      input = { symbol: 'MSFT' }
      context = { current_user: { id: 1 }}
      addedSymbol = StocketApiSchema.execute(addToWatchlistMutation, variables: { input: input }, context: context)

      assert !addedSymbol['data']['addToWatchlist'].nil?
    end

    test 'Error when input is of wrong type' do
      input = { symbol: 1 }
      context = { current_user: { id: 2 }}
      addedSymbol = StocketApiSchema.execute(addToWatchlistMutation, variables: { input: input }, context: context)

      assert !addedSymbol['errors'].nil?
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
      removedSymbol = StocketApiSchema.execute(mutation, variables: { input: input }, context: context)

      assert !removedSymbol['data']['removeFromWatchlist'].nil?
    end
  end
end
