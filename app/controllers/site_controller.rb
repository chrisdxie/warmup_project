class SiteController < ApplicationController

  respond_to :json

  def new
	# Just render login.html.erb
	render :login
  end

  def login
	# Create an instance of the User model, and call the login method
	@model = User.new()	

	@errCode = @model.login(params[:user], params[:password])
	if @errCode <= 0 # Not successful
	  resp = { errCode: @errCode }
	else # Success!
	  resp = { errCode: SUCCESS, count: @errCode }
	end
	render json: resp

  end

  def add
	# Create an instance of the User model and call the add method
	@model = User.new()

	@errCode = @model.add(params[:user], params[:password])
	if @errCode == SUCCESS
	  resp = { errCode: SUCCESS, count: 1 }
	else
	  resp = { errCode: @errCode }
	end
	render json: resp

  end

  def resetFixture
	# Create an instance of the User model, and reset the db by calling the resetFixture method
	@model = User.new()
	@errCode = @model.TESTAPI_resetFixture
	resp = { errCode: @errCode }
	render json: resp
  end

  def unitTests

	# Erase this file it already exists
	system("rm output.txt")
	# Run the tests, write to output file
	x = system("ruby -Itest test/unit/user_test.rb > output.txt")
	# If it fails, throw an Exception
	if not x
	  raise Exception
	end
	# Parse the file for it's contents
	totalTests = 0
	nrFailed = 0
	output = ""

	contents = File.read('output.txt').split("\n")
	contents.each do |content|
	  if content.include?("Total tests")
		totalTests = Integer(content.split(":")[1])
	  elsif content.include?("Number failed")
		nrFailed = Integer(content.split(":")[1])
	  elsif content.include?("Success!") or content.include?("Failure...")
		output += "\n" + content
	  end
	end

	resp = { totalTests: totalTests, nrFailed: nrFailed, output: output }
	render json: resp

  end

end
