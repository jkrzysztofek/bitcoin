# frozen_string_literal: true

class ExchangeRatesController < ApplicationController
  def index 
    if date_from < date_to
      @exchange = ExchangeRate.calculation(date_from, date_to)
    else
      @error = "'Data do' musi występować później niz 'data od'."
    end 

    @minimum_rate = ExchangeRate.minimum(:rate) / 100.00
    @maximum_rate = ExchangeRate.maximum(:rate) / 100.00
  end

  private

  def date_from
    if params.dig("rate_date", "date_from") && params.dig("rate_date", "date_from") != ""
      Date.parse(params[:rate_date][:date_from])
    else
      Date.new(2018, 8, 30)
    end
  end

  def date_to
    if params.dig("rate_date", "date_to") && params.dig("rate_date", "date_to") != ""
      Date.parse(params[:rate_date][:date_to])
     else
      Date.new(2018, 8, 31)
     end
  end

end
