require 'sinatra'
require 'json'
require 'haml'

module MyModule
	class MyApplication < Sinatra::Base

		use Rack::Auth::Basic do |username, password|
  			username == 'admin' && password == 'admin'
		end

		get '/index' do
			@user = {
				:name => "Juntao",
				:address => "Xi'an, China"
			}
			haml :index
		end

		post '/' do
			data = JSON.parse request.body.read
			data.to_json
		end
	end
end
