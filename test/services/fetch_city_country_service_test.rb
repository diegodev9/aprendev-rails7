require 'test_helper'

class FetchCityCountryServiceTest < ActiveSupport::TestCase
  test 'it should return CANADA with a valid ip' do
    stub_request(:get, "http://ip-api.com/json/24.48.0.1").
      to_return(status: 200, body: {
        status: 'success',
        country: 'Canada'
      }.to_json, headers: {})
    assert_equal(FetchCityCountryService.new('24.48.0.1').perform('country'), 'Canada')
  end

  test 'it should return nil with an invalid ip' do
    stub_request(:get, "http://ip-api.com/json/fakeip").
      to_return(status: 200, body: {
        status: 'fail'
      }.to_json, headers: {})
    assert_nil(FetchCityCountryService.new('fakeip').perform('country'))
  end
end