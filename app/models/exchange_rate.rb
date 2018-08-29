class ExchangeRate < ApplicationRecord
    scope :checked_time, ->(time_from, time_to) { where("rate_date > ? AND rate_date < ?", time_from, time_to) } 
    scope :sort_rate_asc, -> { order(rate: :asc) }
    scope :sort_rate_desc -> { order(rate: :desc) }
end
