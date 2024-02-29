require 'net/http'

class FetchCityCountryService
  attr_reader :ip

  def initialize(ip)
    @ip = ip
  end

  def perform(obj) # city or country
    uri = URI("http://ip-api.com/json/#{ip}")
    response = Net::HTTP.get(uri)
    parsed_response = JSON.parse(response)
    status = parsed_response.dig('status')

    if status == 'success'
      parsed_response.dig(obj)
    end
  rescue
    nil
  end
end