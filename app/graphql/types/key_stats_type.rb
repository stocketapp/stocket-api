module Types
  class KeyStatsType < Types::BaseObject
    field :company_name, String, null: true
    field :market_cap, Integer, null: true
    field :week_52_high, Integer, null: true
    field :week_52_low, Integer, null: true
    field :week_52_change, Integer, null: true
    field :dividend_yield, Integer, null: true
    field :ex_dividend_date, String, null: true
    field :shares_outstanding, String, null: true
    field :ttm_eps, Integer, null: true
    field :day_200_moving_avg, Integer, null: true
    field :day_50_moving_avg, Integer, null: true
    field :year_5_change_percent, Integer, null: true
    field :year_2_change_percent, Integer, null: true
    field :year_1_change_percent, Integer, null: true
    field :ytd_change_percent, Integer, null: true
    field :month_6_change_percent, Integer, null: true
    field :month_3_change_percent, Integer, null: true
    field :month_1_change_percent, Integer, null: true
    field :day_5_change_percent, Integer, null: true
    field :avg_10_volume, Integer, null: true
    field :avg_30_volume, Integer, null: true
    field :ttm_dividend_rate, Integer, null: true
    field :max_change_percent, Integer, null: true
    field :day_30_change_percent, Integer, null: true
    field :next_dividend_date, String, null: true
    field :next_earnings_date, String, null: true
    field :pe_ratio, Integer, null: true
  end
end
