# frozen_string_literal: true

class ExchangeRate < ApplicationRecord
  scope :checked_time, ->(date_from, date_to) { where('rate_date > ? AND rate_date < ?', date_from, date_to) }
  scope :sort_rate_asc, -> { order(rate: :asc) }
  scope :sort_rate_desc, -> { order(rate: :desc) }

  def self.calculation(date_from, date_to)
    maximum_rate = ExchangeRate.where('rate_date > ? AND rate_date < ?', date_from, date_to).order(rate: :desc).first # najmniejszy kurs pomiedzy data_od a data_do podanymi przez uzytkownika
    minimum_rate = ExchangeRate.where('rate_date > ? AND rate_date < ?', date_from, date_to).order(rate: :asc).first # najwiekszy kurs pomiedzy data_od a data_do podanymi przez uzytkownika

    resoult = { loss: 0, profit: 0 } # najwieksza strata w tym czasie bedzie roznica miedzy maximum, a minimum ktore moze pojawic sie pozniej do czasu drugiej daty podanej przez uzytkownika

    if minimum_rate.rate_date < maximum_rate.rate_date # sprawdza czy min kurs wypada wczesniej niz max kurs
      resoult[:profit] = maximum_rate.rate - minimum_rate.rate # jesli tak roznica jest najwiekszym zyskiem w tym czasie
      minimum_rate_after_maximum = ExchangeRate.where('rate_date > ? AND rate_date < ?', maximum_rate.rate_date, date_to).order(rate: :asc).first # wyciągasz atrybut z obiektu, nie odwrotnie, czyli maximum_rate.rate_date
      resoult[:loss] = maximum_rate.rate - minimum_rate_after_maximum.rate if minimum_rate_after_maximum # Chcesz odjać od siebie atrybuty rate, nie całe obiekty, czyli mximum_rate.rate - minimum_rate_after_maximum.rate, wtedy to_i nie jest potrzebne
    else
      resoult[:loss] = maximum_rate.rate - minimum_rate.rate # jesli max wypada pozniej niz min, uzytkownik traci -> najwieksza strata
      maximum_rate_after_minimum = ExchangeRate.where('rate_date > ? AND rate_date < ?', minimum_rate.rate_date, date_to).order(rate: :desc).first # najwiekszym zyskiem bedzie roznica miedzy maximum ktore pojawi sie pozniej a minimum
      resoult[:profit] = maximum_rate_after_minimum.rate - minimum_rate.rate if maximum_rate_after_minimum # najwiekszym zyskiem bedzie roznica miedzy maximum ktore pojawi sie pozniej a minimum
    end

    resoult 
  end
end
