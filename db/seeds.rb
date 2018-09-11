# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@date_rate = Time.now

26280.times do
    @date_rate = @date_rate - 1.hour
    rate = rand(1..3000000)
    ExchangeRate.create(:rate_date => @date_rate, :rate => rate)
end

def najwiekszy_zysk
    ExchangeRate.maximum(:rate) - ExchangeRate.minimum(:rate) if rate_date(ExchangeRate.maximum(:rate)) > rate_date(ExchangeRate.minimum(:rate))
end


def najwieksza_strata
    ExchangeRate.maximum(:rate) - ExchangeRate.minimum(:rate) if rate_date(ExchangeRate.maximum(:rate)) < rate_date(ExchangeRate.minimum(:rate))
end



date_from = Time.new(2017,10,15)
date_to = Time.new(2018,3,16)
scope :checked_time, -> {where("rate_date > ? AND rate_date < ?", time_from, time_to)}



def self.profit
    profit = ExchangeRate.sort_rate_desc.first.rate
    ExchangeRate.checked_time.sort_rate_asc.first.rate
  end

  def self.loss
    loss = ExchangeRate.sort_rate_desc.last.rate
    ExchangeRate.checked_time.sort_rate_asc.last.rate

  end
  
  ***********************


  maximum_rate = ExchangeRate.minimum.where("rate_date > ? AND rate_date < ?", time_from, time_to) #najmniejszy kurs pomiedzy data_od a data_do podanymi przez uzytkownika
  minimum_rate = ExchangeRate.maximum.where("rate_date > ? AND rate_date < ?", time_from, time_to) #najwiekszy kurs pomiedzy data_od a data_do podanymi przez uzytkownika

    if rate_date(:minimum_rate) < rate_date(:maximum_rate)
      maximum_rate - minimum_rate = profit
      minimum_rate_after_maximum = ExchangeRate.minimum.where("rate_date > ? AND rate_date < ?", rate_date(:maximum_rate), date_to)
      maximum_rate -  minimum_rate_after_maximum = loss
      
    else 
      maximum_rate - minimum_rate = loss
      maximum_rate_after_minimum = ExchangeRate.maximum.where("rate_date > ? AND rate_date < ?", rate_date(:minimum_rate), date_to)
      maximum_rate_after_minimum - minimum_rate = profit
    end

  *****************************




    
  biggest_rate = ExchangeRate.order(rate: :desc).first
  lowest_rate = ExchangeRate.order(rate: :asc).first

  exchange_rate_with_lowest_price_before_biggest = ExchangeRate.where('rate_date > ?' AND).order(rate: :asc).first
  exchange_rate_with_biggest_price_after_the_lowest = >

  difference_between_lowest_to_biggest = 
  difference_between_biggest_to_lowest = 

  Compare which contains the greater difference and return it