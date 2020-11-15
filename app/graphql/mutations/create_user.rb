module Mutations
  class CreateUser < BaseMutation
    # Credentials wll come from the Firebae authed user
    argument :credentials, Types::AuthProviderCredentialsInput, required: true

    type Types::UserType

    def resolve(credentials: nil)
      User.create!(
        uid: credentials&.[](:uid),
        name: credentials&.[](:name),
        email: credentials&.[](:email),
      )
    end
  end
end