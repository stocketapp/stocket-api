module Types
  class CurrentUserInput < BaseInputObject
    argument :uid, String, required: true
    argument :email, String, required: true
    argument :display_name, String, required: true
  end
end
