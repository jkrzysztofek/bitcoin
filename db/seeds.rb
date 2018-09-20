# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

26_280.times do
  @date_rate -= 1.hour
  rate = rand(1..3_000_000)
  ExchangeRate.create(rate_date: @date_rate, rate: rate)
end
