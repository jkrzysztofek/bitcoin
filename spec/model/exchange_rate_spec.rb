describe 'ExchangeRate' do
    it '.calculation' do
        ExchangeRate.create(rate_date: Time.new(2018,8,1), rate: 20000)
        ExchangeRate.create(rate_date: Time.new(2018,8,2), rate: 5000)
        ExchangeRate.create(rate_date: Time.new(2018,8,3), rate: 55000)
        ExchangeRate.create(rate_date: Time.new(2018,8,4), rate: 6000)
        ExchangeRate.create(rate_date: Time.new(2018,8,5), rate: 30000)

        results = ExchangeRate.calculation(Time.new(2018, 8, 1), Time.new(2018, 8, 6))

        expect(result[:loss]).to eq(14000)
        expect(result[:profit]) .to eq(25000)
    end
end