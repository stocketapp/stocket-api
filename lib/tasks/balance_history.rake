namespace :balance_history do
  desc "Update user's balances"
  task update_users: :environment do
    User.all.map do |u|
      portfolio_val = u.calculate_portfolio_value
      hist = BalanceHistory.where(user_id: u.id).map(&:value).last
      change = (portfolio_val - hist).abs
      BalanceHistory.create!(
        user_id: u.id,
        value: portfolio_val,
        change: change,
        change_pct: (format '%.2f', (change / portfolio_val) * 100).to_f
      )
    end
  end
end