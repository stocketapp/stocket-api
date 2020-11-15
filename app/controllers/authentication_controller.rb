
class AuthenticationController < ApplicationController
  def index
    token = params[:token]
    result = FirebaseIdToken::Signature.verify(token)
    if result != nil
      context[:session][:token] = token
    else
      raise StandardError.new 'Failed to authenticate. Possible fake token.'
    end
  end
end
