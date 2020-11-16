require 'test_helper'

module Mutations
  class CreateUserTest < ActionDispatch::IntegrationTest
    test 'creates user' do
      mutation_string = <<-GRAPHQL
        mutation CreateUser($input: CreateUserInput!) {
          createUser(input: $input) {
            success
          }
        }
      GRAPHQL
      input = {
        user: {
          uid: 'Uy0YhDXetYWGxLFB2aF4aMdUPyB3',
          email: 'corasan.dev@gmail.com',
          displayName: 'Henry Paulino'
        }
      }
      result = StocketApiSchema.execute(mutation_string, variables: { input: input })
      success = result['data']['createUser']['success']

      assert success
    end
  end
end
