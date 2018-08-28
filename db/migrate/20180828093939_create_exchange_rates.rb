class CreateExchangeRates < ActiveRecord::Migration[5.2]
  def change
    create_table :exchange_rates do |t|
      t.integer :rate
      t.datetime :rate_date

      t.timestamps
    end
  end
end
