class ExchangeRatesController < ApplicationController
  
  def index
    @exchange_rate =  ExchangeRate.new
    @exchange_rates = ExchangeRate.all

    @minimum_rate = ExchangeRate.minimum(:rate) / 100.00
    @maximum_rate = ExchangeRate.maximum(:rate) / 100.00  
  end

  def biggest_profit
    #najmniejszy kurs pomiedzy data_od a data_do podanymi przez uzytkownika
    maximum_rate = exchange_rate.minimum.where("rate_date > ? AND rate_date < ?", time_from, time_to) 
    #najwiekszy kurs pomiedzy data_od a data_do podanymi przez uzytkownika
    minimum_rate = exchange_rate.maximum.where("rate_date > ? AND rate_date < ?", time_from, time_to) 
  end
end
