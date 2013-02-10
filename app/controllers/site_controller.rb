class SiteController < ApplicationController

  respond_to :json

  def login
	@model = User.new()	

	errCode = @model.login(params[:user], params[:password])
	if errCode <= 0
	  resp = { errCode: errCode }
	else #success!
	  resp = { errCode: SUCCESS, count: errCode }
	end
	render json: resp

  end

  def add
	@model = User.new()

	errCode = @model.add(params[:user], params[:password])
	if errCode == SUCCESS
	  resp = { errCode: SUCCESS, count: 1 }
	else
	  resp = { errCode: errCode }
	end
	render json: resp

  end

  def resetFixture
	@model = User.new()
	errCode = @model.TESTAPI_resetFixture
	resp = { errCode: errCode }
	render json: resp
  end

  def unitTests

	# Erase this file it already exists
	system("rm output.txt")
	# Run the tests, write to output file
	system("rake test:units > output.txt")
	# Read in the file, capture what you need
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
		output += content + "\n"
	  end
	end

	resp = { totalTests: totalTests, nrFailed: nrFailed, output: output }
	render json: resp

  end

end
