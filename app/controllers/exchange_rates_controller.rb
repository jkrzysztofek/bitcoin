class ExchangeRatesController < ApplicationController
  
  def index
    @exchange_rate =  ExchangeRate.new
    @exchange_rates = ExchangeRate.all

    @minimum_rate = ExchangeRate.minimum(:rate) / 100.00
    @maximum_rate = ExchangeRate.maximum(:rate) / 100.00  
  end

  #najmniejszy kurs pomiedzy data_od a data_do podanymi przez uzytkownika
  maximum_rate = ExchangeRate.minimum.where("rate_date > ? AND rate_date < ?", time_from, time_to) 
  #najwiekszy kurs pomiedzy data_od a data_do podanymi przez uzytkownika
  minimum_rate = ExchangeRate.maximum.where("rate_date > ? AND rate_date < ?", time_from, time_to) 
  
  if rate_date(:minimum_rate) < rate_date(:maximum_rate) #sprawdza czy min kurs wypada czesniej niz max kurs
    maximum_rate - minimum_rate = profit #jesli tak roznica jest najwiekszym zyskiem w tym czasie
    minimum_rate_after_maximum = ExchangeRate.minimum.where("rate_date > ? AND rate_date < ?", rate_date(:maximum_rate), date_to) 
    #najwieksza strata w tym czasie bedzie roznica miedzy maximum, a minimum ktore moze pojawic sie pozniej do czasu drugiej daty
    # podanej przez uzytkownika
    maximum_rate -  minimum_rate_after_maximum = loss
  else 
    maximum_rate - minimum_rate = loss #jesli max wypada pozniej niz min, uztkownik traci -> najwieksza strata
    maximum_rate_after_minimum = ExchangeRate.maximum.where("rate_date > ? AND rate_date < ?", rate_date(:minimum_rate), date_to)
    # najwiekszym zyskiem bedzie roznica miedzy maximum ktore pojawi sie pozniej a minimum
    maximum_rate_after_minimum - minimum_rate = profit
  end



end
