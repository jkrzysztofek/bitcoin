# frozen_string_literal: true

class ExchangeRate < ApplicationRecord
  scope :checked_time, ->(date_from, date_to) { where('rate_date > ? AND rate_date < ?', date_from, date_to) }
  scope :sort_rate_asc, -> { order(rate: :asc) }
  scope :sort_rate_desc, -> { order(rate: :desc) }

  def self.calculation(date_from, date_to)
    resoult = { loss: 0, profit: 0 }
    if minimum_rate(date_from, date_to).rate_date < maximum_rate(date_from, date_to).rate_date
      resoult[:profit] = profit_after_minimum(date_from, date_to)
      resoult[:loss] = loss_after_minimum(date_from, date_to)
    else
      resoult[:profit] = profit_after_maximum(date_from, date_to)
      resoult[:loss] = loss_after_maximum(date_from, date_to)
    end
    resoult
  end

  def self.maximum_rate(date_from, date_to)
    ExchangeRate.checked_time(date_from, date_to).order(rate: :desc).first
  end

  def self.minimum_rate(date_from, date_to)
    ExchangeRate.checked_time(date_from, date_to).order(rate: :asc).first
  end

  def self.maximum_rate_after_minimum(date_from, date_to)
    ExchangeRate.checked_time(date_from, date_to)
                .order(rate: :asc)
                .first
  end

  def self.minimum_rate_after_maximum(date_from, date_to)
    ExchangeRate.checked_time(date_from, date_to)
                .order(rate: :desc)
                .first
  end

  def self.profit_after_minimum(date_from, date_to)
    maximum_rate(date_from, date_to).rate - minimum_rate(date_from, date_to).rate
  end

  def self.loss_after_minimum(date_from, date_to)
    min = minimum_rate_after_maximum(date_from, date_to)
    return unless min
    maximum_rate(date_from, date_to).rate - min.rate
  end

  def self.loss_after_maximum(date_from, date_to)
    maximum_rate(date_from, date_to).rate - minimum_rate(date_from, date_to).rate
  end

  def self.profit_after_maximum(date_from, date_to)
    max = maximum_rate_after_minimum(date_from, date_to)
    return unless max
    max.rate - minimum_rate(date_from, date_to).rate
  end
end
