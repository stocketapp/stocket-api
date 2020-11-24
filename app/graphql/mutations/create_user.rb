module Mutations
  class CreateUser < BaseMutation
    argument :user, Types::CurrentUserInput, required: true

    field :success, Boolean, null: false
    field :message, String, null: false
    field :user, Types::UserType, null: false

    def resolve(user: nil)
      return { success: false, message: 'User already exists' } if user_exists?(user)

      created_user = create_user(user)
      user_info = create_user_info(created_user)

      return { success: false, message: 'Could not create user' } unless user && user_info

      { success: true, message: 'User created', user: created_user }
    end

    private

    def create_user(user)
      User.create!(
        uid: user&.[](:uid),
        email: user&.[](:email),
        displayName: user&.[](:display_name)
      )
    end

    def create_user_info(created_user)
      UserInfo.create!(
        cash: 20_000,
        portfolio_change: 0.0,
        portfolio_change_pct: 0.0,
        portfolio_value: '$0.00',
        user_id: created_user.id
      )
    end

    def user_exists?(user)
      res = User.where uid: user&.[](:uid)
      res.exists?
    end
  end
end
