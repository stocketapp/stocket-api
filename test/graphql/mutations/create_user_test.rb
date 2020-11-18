require 'test_helper'

module Mutations
  class CreateUserTest < ActionDispatch::IntegrationTest
    mutation_string = <<-GRAPHQL
        mutation CreateUser($input: CreateUserInput!) {
          createUser(input: $input) {
            success
            message
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
    test 'creates user' do
      result = StocketApiSchema.execute(mutation_string, variables: { input: input })
      success = result['data']['createUser']['success']

      assert success
    end

    test 'if user already exists, return' do
      StocketApiSchema.execute(mutation_string, variables: { input: input })
      result = StocketApiSchema.execute(mutation_string, variables: { input: input })
      success = result['data']['createUser']['success']

      assert_not success
    end
  end
end
