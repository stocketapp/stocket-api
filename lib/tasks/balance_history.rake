namespace :balance_history do
  desc "Update user's balances"
  task update_users: :environment do
    User.all.map do |u|
      portfolio_val = u.calculate_portfolio_value
      hist = BalanceHistory.where(user_id: u.id).order('id desc').limit(1)[0]&.[](:value)
      change = (portfolio_val - (hist.nil? ? 0.00 : hist) ).abs
      change_pct = ((format '%.2f', ((change / portfolio_val) || 0.0) * 100)).to_f
      BalanceHistory.create!(
        user_id: u.id,
        value: portfolio_val,
        change: change,
        change_pct: change_pct
      )
    end
  end
end
