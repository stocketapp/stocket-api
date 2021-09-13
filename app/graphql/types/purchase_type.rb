module Types
  # PurchaseType
  class PurchaseType < BaseObject
    field :sku, String, null: false
    field :purchase_id, String, null: false
    field :price, Float, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, 'Date the order was placed', null: false
  end
end
