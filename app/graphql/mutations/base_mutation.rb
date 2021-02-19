module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject
  end

  def handle_error_arr(data)
    errors = data.errors.map do |attr, msg|
      {
        message: msg,
        path: ["attributes", attribute.to_s.camelize(:lower)]
      }
    end
    {
      data: data,
      errors: errors,
      success: false
    }
  end
end
