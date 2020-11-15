module Types
  class TradesType < Types::BaseObject
    field :id, ID, null: false
    field :action, String, null: false
  end
end
