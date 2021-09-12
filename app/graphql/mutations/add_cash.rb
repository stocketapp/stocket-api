module Mutations
  # AddCash
  class AddCash < BaseMutation
    argument :sku, String, 'Product SKU', required: true
    argument :purchase_id, String, 'Purchase ID', required: true

    field :cash, Float, 'New cash amount', null: false

    def resolve(sku:, purchase_id:)
      purchase(sku, purchase_id)
      new_cash
    end

    private

    def purchase(sku, purchase_id)
      case sku
      when 'com.corasan.stocket.5k_cash'
        create_purchase(sku, purchase_id, 0.99, 5_000)
      when 'com.corasan.stocket.10k_cash'
        create_purchase(sku, purchase_id, 3.99, 10_000)
      when 'com.corasan.stocket.40k_cash'
        create_purchase(sku, purchase_id, 6.99, 40_000)
      when 'com.corasan.stocket.75k_cash'
        create_purchase(sku, purchase_id, 9.99, 75_000)
      end
    end

    def create_purchase(sku, purchase_id, price, amount)
      Purchase.create!(user_id: user.id, sku: sku, purchase_id: purchase_id, price: price)
      update_cash(amount)
    end

    def update_cash(amount)
      user.update(cash: user.cash + amount)
    end

    def new_cash
      { cash: user.cash }
    end

    def user
      User.find_by id: context[:current_user][:id]
    end
  end
end
