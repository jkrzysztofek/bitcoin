# frozen_string_literal: true

class ExchangeRate < ApplicationRecord
  validates :rate, numericality: { other_than: 0 }

  scope :checked_time, ->(date_from, date_to) { where('rate_date >=? AND rate_date <= ?', date_from, date_to) }

  def self.calculation(date_from, date_to)
    result = { loss: 0, profit: 0 }
    date_max = maximum_rate(date_from, date_to).rate_date

    if minimum_rate(date_from, date_to).rate_date < maximum_rate(date_from, date_to).rate_date
      result[:profit] = profit_after_minimum(date_from, date_to)
      result[:loss] = loss_after_minimum(date_from, date_to, date_max)
    else
      result[:profit] = profit_before_maximum(date_from, date_to, date_max)
      result[:loss] = loss_after_maximum(date_from, date_to)
    end
    result
  end

  def self.maximum_rate(date_from, date_to)
    ExchangeRate.checked_time(date_from, date_to).order(rate: :desc).first
  end

  def self.minimum_rate(date_from, date_to)
    ExchangeRate.checked_time(date_from, date_to).order(rate: :asc).first
  end

  def self.minimum_rate_before_maximum(date_from, date_max)
    ExchangeRate.checked_time(date_from, date_max)
                .order(rate: :asc)
                .first
  end

  def self.minimum_rate_after_maximum(date_max, date_to)
    ExchangeRate.checked_time(date_max, date_to)
                .order(rate: :asc)
                .first
  end

  def self.profit_after_minimum(date_from, date_to)
    maximum_rate(date_from, date_to).rate - minimum_rate(date_from, date_to).rate
  end

  def self.loss_after_minimum(date_from, date_to, date_max)
    min = minimum_rate_after_maximum(date_max, date_to)
    return unless min
    maximum_rate(date_from, date_to).rate - min.rate
  end

  def self.loss_after_maximum(date_from, date_to)
    maximum_rate(date_from, date_to).rate - minimum_rate(date_from, date_to).rate
  end

  def self.profit_before_maximum(date_from, date_to, date_max)
    min = minimum_rate_before_maximum(date_from, date_max)
    return unless min
    maximum_rate(date_from, date_to).rate - min.rate
  end

  def self.import
    @date_rate = Time.new(2018, 9, 28, 8, 0, 0).utc

    1_825.times do
      @date_rate -= 1.day
      @bitcoin_rate = Cryptocompare::PriceHistorical.find('BTC', 'USD', 'ts' => @date_rate.to_time.to_i)
      ExchangeRate.create(rate_date: @date_rate, rate: @bitcoin_rate.dig('BTC', 'USD'))
      sleep 1.second
    end
  end
end
