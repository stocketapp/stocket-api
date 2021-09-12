module Mutations
  # AddCash
  class AddCash < BaseMutation
    argument :amount, Float, 'Amount to be added to user balance', required: true

    field :cash, Float, 'New cash amount', null: false

    def resolve(amount:)
      user.update(cash: user.cash + amount)
      new_cash
    end

    private

    def new_cash
      { cash: user.cash }
    end

    def user
      User.find_by id: context[:current_user][:id]
    end
  end
end
