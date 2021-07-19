module Types
  # BaseObject
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField

    # Return the difference between two values
    # @param [Float] val1
    # @param [Float] val2
    def diff(val1, val2)
      val1 - val2.abs
    end

    # Returns number formatted with two digits after decimal point
    def print_f(value:)
      (format '%.2f', value).to_f
    end
  end
end
