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

include SiteHelper

class User < ActiveRecord::Base
  attr_accessible :count, :password, :user

  MAX_USERNAME_LENGTH = 128
  MAX_PASSWORD_LENGTH = 128

  def login(name, password)
	
	user = User.find_by_user(name)
	
	# User hasn't been found in db
	if user.nil?
	  return ERR_BAD_CREDENTIALS
	# User has been found, but password doesn't match up
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

	# Username constraints	
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
	# Delete all rows in table, resetting db
	User.delete_all
	return SUCCESS
  end

end
