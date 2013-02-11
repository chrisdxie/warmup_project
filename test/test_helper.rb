ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
  SUCCESS =              1     # : a success
  ERR_BAD_CREDENTIALS = -1     # : (for login only) cannot find the user/password pair in the database
  ERR_USER_EXISTS     = -2     #: (for add only) trying to add a user that already exists
  ERR_BAD_USERNAME    = -3     #: (for add, or login) invalid user name (only empty string is invalid for now)
  ERR_BAD_PASSWORD    = -4
  # Add more helper methods to be used by all tests here...
end
