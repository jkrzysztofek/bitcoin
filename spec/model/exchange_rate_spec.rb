# frozen_string_literal: true

describe 'ExchangeRate' do
  def generate_rates(array)
    array.each.with_index do |rate, i|
      ExchangeRate.create(rate_date: Time.zone.new(2018, 8, 1, 8, 0, 0) + i.days, rate: rate)
    end
  end

  describe '.calculation' do
    it 'test dates min before max' do
      generate_rates([20_000, 5000, 55_000, 6000, 30_000])
      results = ExchangeRate.calculation(Time.zone.new(2018, 8, 1), Time.zone.new(2018, 8, 6))

      expect(results[:loss]).to eq(49_000)
      expect(results[:profit]).to eq(50_000)
    end

    it '.calculation max before min' do
      generate_rates([9000, 20_000, 55_000, 5000, 30_000])
      results = ExchangeRate.calculation(Time.zone.new(2018, 8, 1), Time.zone.new(2018, 8, 6))

      expect(results[:loss]).to eq(50_000)
      expect(results[:profit]).to eq(46_000)
    end

    it '.calculation mixed min and max' do
      generate_rates([5000, 6000, 80_000, 9000, 8000])
      results = ExchangeRate.calculation(Time.zone.new(2018, 8, 1), Time.zone.new(2018, 8, 6))

      expect(results[:loss]).to eq(72_000)
      expect(results[:profit]).to eq(75_000)
    end

    it '.calculation ascending rates' do
      generate_rates([10_000, 20_000, 30_000, 40_000, 50_000])
      results = ExchangeRate.calculation(Time.zone.new(2018, 8, 1), Time.zone.new(2018, 8, 6))

      expect(results[:loss]).to eq(0)
      expect(results[:profit]).to eq(40_000)
    end

    it '.calculation ascending rates' do
      generate_rates([50_000, 40_000, 30_000, 20_000, 10_000])
      results = ExchangeRate.calculation(Time.zone.new(2018, 8, 1), Time.zone.new(2018, 8, 6))

      expect(results[:loss]).to eq(40_000)
      expect(results[:profit]).to eq(0)
    end
  end
end
