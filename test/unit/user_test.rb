# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user       :string(255)
#  password   :string(255)
#  count      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

#include SiteHelper
require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # Run before each test
  def setup
	@model = User.new()
	@model.add('foo', 'baz')
  end

  # Login tests (2)
  def login_1
	errCode = @model.login('me', 'foobar') # hasn't been added to db
	#assert_equal(ERR_BAD_CREDENTIALS, errCode)
	if ERR_BAD_CREDENTIALS == errCode
	  return "Success!"
	end
	return "Failure..."
  end

  def login_2
	errCode = @model.login('foo', 'baz') # Already loaded
	#assert_equal(2, errCode)
	if 2 == errCode
	  return "Success!"
	end
	return "Failure..."
  end

  # Adding tests (6)
  def add_1
	errCode = @model.add('foo', 'nopassword') # Already in the test db
	#assert_equal(ERR_USER_EXISTS, errCode)
	if ERR_USER_EXISTS == errCode
	  return "Success!"
	end
	return "Failure..."
  end

  def add_2
	errCode = @model.add('  ', 'password') # Blank username
	#assert_equal(ERR_BAD_USERNAME, errCode)
	if ERR_BAD_USERNAME == errCode
	  return "Success!"
	end
	return "Failure..."
  end

  def add_3
	errCode = @model.add('a'*129, 'password') # Username too long
	#assert_equal(ERR_BAD_USERNAME, errCode)
	if ERR_BAD_USERNAME == errCode
	  return "Success!"
	end
	return "Failure..."
  end

  def add_4
	errCode = @model.add('asdf', 'd'*129) # Password too long
	#assert_equal(ERR_BAD_PASSWORD, errCode)
	if ERR_BAD_PASSWORD == errCode
	  return "Success!"
	end
	return "Failure..."
  end

  def add_5
	errCode = @model.add('', '') # Both blank, should return ERR_BAD_USERNAME (for my app)
	#assert_equal(ERR_BAD_USERNAME, errCode)
	if ERR_BAD_USERNAME == errCode
	  return "Success!"
	end
	return "Failure..."
  end

  def add_6
	errCode = @model.add('user2', 'pass2') # Should return success
	#assert_equal(SUCCESS, errCode)
	if SUCCESS == errCode
	  return "Success!"
	end
	return "Failure..."
  end

  # resetFixture tests (2)
  def resetFixture_1
	errCode = @model.TESTAPI_resetFixture
	#assert_equal(SUCCESS, errCode)
	if SUCCESS == errCode
	  return "Success!"
	end
	return "Failure..."
  end

  def resetFixture_2
	@model.TESTAPI_resetFixture
	#assert_equal(User.count, 0) # Number of db rows should be 0
	if User.count == 0
	  return "Success!"
	end
	return "Failure..."
  end

  def test_run_all_tests
	# Run all 10 tests, return answers to controller.
	totalTests = 0
	nrFailed = 0
	# Run tests and evaluate them to this list
	output = [login_1,login_2,add_1,add_2,add_3,add_4,add_5,add_6,resetFixture_1,resetFixture_2]
	output.each do |out|
	  totalTests += 1
	  if out == "Failure..."
		nrFailed += 1
	  end
	end
	puts ["Total tests: #{totalTests}", "Number failed: #{nrFailed}", output]
  end

end
