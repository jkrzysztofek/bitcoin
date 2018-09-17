# frozen_string_literal: true

class ExchangeRatesController < ApplicationController
  def index
    @exchange_rate =  ExchangeRate.new
    @exchange_rates = ExchangeRate.all

    @minimum_rate = ExchangeRate.minimum(:rate) / 100.00
    @maximum_rate = ExchangeRate.maximum(:rate) / 100.00
  end
end
