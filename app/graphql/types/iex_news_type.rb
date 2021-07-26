module Types
  class IexNewsType < Types::BaseObject
    field :datetime, String, null: true
    field :headline, String, null: true
    field :source, String, null: true
    field :url, String, null: true
    field :summary, String, null: true
    field :related, String, null: true
    field :image, String, null: true
    field :lang, String, null: true
    field :hasPaywall, String, null: true
  end
end
