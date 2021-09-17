module Mutations
  # CreateUser
  class CreateUser < BaseMutation
    argument :user, Types::CurrentUserInput, required: true

    field :success, Boolean, null: false
    field :message, String, null: false
    field :user, Types::UserType, null: true

    def resolve(user: nil)
      if user_exists?(user)
        return { success: false, message: 'User already exists', user: User.find_by(uid: user[:uid]) }
      end

      created_user = create_user(user)

      return { success: false, message: 'Could not create user', user: null } unless user

      { success: true, message: 'User created', user: created_user }
    end

    private

    def create_user(user)
      User.create!(
        uid: user&.[](:uid),
        email: user&.[](:email),
        displayName: user&.[](:display_name),
        cash: 20_000.00
      )
    end

    def user_exists?(user)
      res = User.where uid: user&.[](:uid)
      res.exists?
    end
  end
end
