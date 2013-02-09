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

class User < ActiveRecord::Base
  attr_accessible :count, :password, :user

  SUCCESS =              1     # : a success
  ERR_BAD_CREDENTIALS = -1     # : (for login only) cannot find the user/password pair in the database
  ERR_USER_EXISTS     = -2     #: (for add only) trying to add a user that already exists
  ERR_BAD_USERNAME    = -3     #: (for add, or login) invalid user name (only empty string is invalid)
  ERR_BAD_PASSWORD    = -4
  MAX_USERNAME_LENGTH = 128
  MAX_PASSWORD_LENGTH = 128

  def login(name, password)
	
	user = User.find_by_user(name)
	if user.nil?
	  return ERR_BAD_CREDENTIALS
	elsif user.password != password
	  return ERR_BAD_CREDENTIALS
	end

	# User has been authenticated
	user.count += 1
	user.save!
	return user.count
  end

  def add(name, password)
	
	# Checks to see if user is in db
	user = User.find_by_user(name)
	if not user.nil?
	  return ERR_USER_EXISTS
	end

	# Name constraints	
	if name.blank? or name.length > MAX_USERNAME_LENGTH
	  return ERR_BAD_USERNAME
	end

	# Password constraints
	if password.length > MAX_PASSWORD_LENGTH
	  return ERR_BAD_PASSWORD
	end

	# Success!
	User.create( user: name, password: password, count: 1 )
	return 1 # One login, including this one
  end

  def TESTAPI_resetFixture
	User.delete_all
	return SUCCESS
  end

end
