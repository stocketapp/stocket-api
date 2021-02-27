module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def self.handle_error(data)
      raise GraphQL::ExecutionError, data.errors.full_messages.join(", ")
    end
  end
end
