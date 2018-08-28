require 'test_helper'

class ExchangeRatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get exchange_rates_index_url
    assert_response :success
  end

  test "should get show" do
    get exchange_rates_show_url
    assert_response :success
  end

end
