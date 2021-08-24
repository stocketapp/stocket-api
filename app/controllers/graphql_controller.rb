# GraphqlController
class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute
    vars = prepare_variables(params[:variables])
    op_name = params[:operationName]
    context = { current_user: get_current_user(request.env['HTTP_AUTHORIZATION']) }
    result = StocketApiSchema.execute(params[:query], variables: vars, context: context, operation_name: op_name)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  def get_current_user(token)
    return User.find_by(uid: 'Uy0YhDXetYWGxLFB2aF4aMdUPyB3') if Rails.env.development?

    result = FirebaseIdToken::Signature.verify(token)
    unless result
      raise GraphQL::ExecutionError.new(
        'The token used to authorize this request is invalid.',
        extensions: { 'code' => 'INVALID_TOKEN' }
      )
    end

    uid = result['sub']
    params[:operationName] != 'CreateUser' ? User.find_by(uid: uid) : { uid: uid }
  end

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      variables_param.present? ? JSON.parse(variables_param) || {} : {}
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end
end
