# frozen_string_literal: true

class ExchangeRatesController < ApplicationController
  def index
    if date_from.nil? && date_to.nil?
      nil
    elsif date_from < date_to
      @exchange = ExchangeRate.calculation(date_from, date_to)
    else
      @error = "'Data do' musi występować później niz 'data od'."
    end

    @minimum_rate = ExchangeRate.minimum(:rate)
    @maximum_rate = ExchangeRate.maximum(:rate)
  end

  private

  def date_from
    return unless params.dig('rate_date', 'date_from') && params.dig('rate_date', 'date_from') != ''
    Date.parse(params[:rate_date][:date_from])
  end

  def date_to
    return unless params.dig('rate_date', 'date_to') && params.dig('rate_date', 'date_to') != ''
    Date.parse(params[:rate_date][:date_to])
  end
end
