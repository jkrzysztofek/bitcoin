# frozen_string_literal: true

class ExchangeRate < ApplicationRecord
  scope :checked_time, ->(date_from, date_to) { where('rate_date > ? AND rate_date < ?', date_from, date_to) }
  scope :sort_rate_asc, -> { order(rate: :asc) }
  scope :sort_rate_desc, -> { order(rate: :desc) }

  def minimum_rate; end

  def maximum_rate; end

  def self.date_from
    @date_from = Date.new
  end

  def self.date_to
    @date_to = Date.new
  end

  def self.rate_date(_rate_date = nil)
    @rate_date = Date.new
  end

  def loss; end

  def profit; end

  def calculation
    # najmniejszy kurs pomiedzy data_od a data_do podanymi przez uzytkownika
    maximum_rate = ExchangeRate.where('rate_date > ? AND rate_date < ?', date_from, date_to).minimum(:rate)
    # najwiekszy kurs pomiedzy data_od a data_do podanymi przez uzytkownika
    minimum_rate = ExchangeRate.where('rate_date > ? AND rate_date < ?', date_from, date_to).maximum(:rate)

    if rate_date(:minimum_rate) < rate_date(:maximum_rate) # sprawdza czy min kurs wypada czesniej niz max kurs
      profit = (maximum_rate - minimum_rate).to_i # jesli tak roznica jest najwiekszym zyskiem w tym czasie
      minimum_rate_after_maximum = ExchangeRate.minimum(:rate).where('rate_date > ? AND rate_date < ?', rate_date(:maximum_rate), date_to)
      # najwieksza strata w tym czasie bedzie roznica miedzy maximum, a minimum ktore moze pojawic sie pozniej do czasu drugiej daty
      # podanej przez uzytkownika
      loss = (maximum_rate - minimum_rate_after_maximum).to_i

    else
      loss = (maximum_rate - minimum_rate).to_i # jesli max wypada pozniej niz min, uztkownik traci -> najwieksza strata
      maximum_rate_after_minimum = ExchangeRate.where('rate_date > ? AND rate_date < ?', rate_date(:minimum_rate), date_to).maximum(:rate)
      # najwiekszym zyskiem bedzie roznica miedzy maximum ktore pojawi sie pozniej a minimum
      profit = (maximum_rate_after_minimum - minimum_rate).to_i
    end
  end

  def output
    "Pomiędzy #{date_from} a #{date_to} mogłeś najwięcej zyskać #{profit} i stracić #{loss}"
  end
end
