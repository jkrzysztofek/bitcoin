class ExchangeRatesController < ApplicationController
  def index
    @minimum_rate = ExchangeRate.minimum(:rate) / 100.00
    @maximum_rate = ExchangeRate.maximum(:rate) / 100.00  

    @exchange_rates = ExchangeRate.all
    @exchange_rate =  ExchangeRate.new
  
  end

end
