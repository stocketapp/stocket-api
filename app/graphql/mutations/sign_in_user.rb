

module Mutations
  class SignInUser < BaseMutation
    null true

    argument :token, String, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(token: nil)
      result = FirebaseIdToken::Signature.verify(token)
      uid = result['sub']
      user = User.find_by uid: uid
      
      # ensures we have the correct user
      return unless user
      
      current_user = { user: user, token: token }
      redis = Redis.new(host: 'localhost', port: 6379, db: 0)
      redis.set('@current_user', current_user)
      redis.set('@session_token', token)

      { user: user, token: token }
    end
  end
end