module Types
  class IexNewsType < Types::BaseObject
    field :date_time, String, null: false
    field :headline, String, null: false
    field :source, String, null: false
    field :url, String, null: false
    field :summary, String, null: false
    field :related, String, null: false
    field :image, String, null: false
    field :lang, String, null: false
    field :hasPaywall, String, null: false
  end
end