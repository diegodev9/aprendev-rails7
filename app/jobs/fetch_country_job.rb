class FetchCountryJob < ApplicationJob
  queue_as :default

  def perform(user_id, ip)
    country = FetchCityCountryService.new(ip).perform('country')
    city = FetchCityCountryService.new(ip).perform('city')

    user = User.find(user_id)
    if user
      user.update(city: city, country: country)
    end
  end
end
