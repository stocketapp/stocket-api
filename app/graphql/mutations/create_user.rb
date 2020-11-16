module Mutations
  class CreateUser < BaseMutation
    argument :user, Types::CurrentUserInput, required: true

    field :success, String, null: false
    field :message, String, null: false

    def resolve(user: nil)
      created_user = User.create!(
        uid: user&.[](:uid),
        email: user&.[](:email),
        displayName: user&.[](:display_name)
      )
      puts created_user
      userInfo = UserInfo.create!(
        cash: 20000,
        portfolio_change: 0.0,
        portfolio_change_pct: 0.0,
        portfolio_value: '$0.00',
        user_id: created_user.id
      )

      return { success: false, messsage: 'Could not create user' } unless user && userInfo

      { success: true, messsage: 'User created' }
    end
  end
end