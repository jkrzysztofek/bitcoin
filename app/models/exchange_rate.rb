class ExchangeRate < ApplicationRecord
    scope :checked_time, ->(time_from, time_to) { where("rate_date > ? AND rate_date < ?", time_from, time_to) }
    scope :sort_rate_asc, -> { order(rate: :asc) }
    scope :sort_rate_desc, -> { order(rate: :desc) }


    def date_from
        @date_from = Date.new #czy rate_date.new ?
    end
    
    def date_to
        @date_to = Date.new # czy rate_date.new ?
    end
      
end
