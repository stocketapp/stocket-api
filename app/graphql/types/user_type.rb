module Types
  # UserType
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :uid, String, null: false
    field :email, String, null: false
    field :displayName, String, null: false
    field :portfolio_value, Float, null: false

    def portfolio_value
      positions = Share.where user_id: context[:current_user][:id]
      portfolio = create_portfolio(positions)
      calculate_portfolio_value(portfolio)
    end

    private

    # @param [ActiveRecord::Relation<Share>] positions
    # @return [Hash]
    def create_portfolio(positions)
      new_obj = {}
      positions.each do |p|
        p.each_pair { |_, v| new_obj.key?(v) ? new_obj[v] += p.size : new_obj[p.symbol] = p.size }
      end
      new_obj
    end

    # @param [Hash] portfolio
    # @return [Array]
    def calculate_portfolio_value(portfolio)
      new_arr = []
      portfolio.each_pair do |k, v|
        share = Share.iex_price(k)
        new_arr.push(share * v)
      end
      new_arr
    end
  end
end
