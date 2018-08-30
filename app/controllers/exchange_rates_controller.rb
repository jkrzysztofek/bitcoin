class ExchangeRatesController < ApplicationController
  def index
    @minimum_rate = ExchangeRate.minimum(:rate) / 100.00
    @maximum_rate = ExchangeRate.maximum(:rate) / 100.00 
  end
end
