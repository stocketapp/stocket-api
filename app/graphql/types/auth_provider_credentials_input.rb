module Types
  class AuthProviderCredentialsInput < BaseInputObject
    # the name is usually inferred by class name but can be overwritten
    graphql_name 'AUTH_PROVIDER_CREDENTIALS'

    argument :uid, String, required: true
    argument :name, String, required: true
    argument :email, String, required: true
  end
end