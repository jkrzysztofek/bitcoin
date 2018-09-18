# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@date_rate = Time.now

26_280.times do
  @date_rate -= 1.hour
  rate = rand(1..3_000_000)
  ExchangeRate.create(rate_date: @date_rate, rate: rate)
end

date_from = Time.new(2017, 10, 15)
date_to = Time.new(2018, 3, 16)
scope :checked_time, -> { where('rate_date > ? AND rate_date < ?', date_from, date_to) }
