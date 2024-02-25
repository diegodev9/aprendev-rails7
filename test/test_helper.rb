ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...

    def login
      post sessions_path, params: { login: 'paco01', password: 'password' }
      @user = User.find_by(username: 'paco01')
    end

    def logout
      delete session_path(@user)
    end
  end
end
