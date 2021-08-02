module Types
  class CompanyType < Types::BaseObject
    field :symbol, String, null: false
    field :company_name, String, null: false
    field :exchange, String, null: false
    field :industry, String, null: false
    field :description, String, null: false
    field :webstie, String, null: false
    field :ceo, String, null: false
    field :street, String, null: false
    field :state, String, null: false
    field :city, String, null: false
    field :zip, String, null: false
    field :country, String, null: false
    field :phone, String, null: true
  end
end
