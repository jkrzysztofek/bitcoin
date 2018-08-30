class ExchangeRate < ApplicationRecord
    scope :checked_time, ->(time_from, time_to) { where("rate_date > ? AND rate_date < ?", time_from, time_to) }
    scope :sort_rate_asc, -> { order(rate: :asc) }
    scope :sort_rate_desc, -> { order(rate: :desc) }



    def self.najwiekszy_zysk
        najwiekszy = ExchangeRate.sort_rate_desc.first.rate
        ExchangeRate.checked_time.sort_rate_asc.first.rate
    end

    def self.najwieksza_strata

    end

  
end
