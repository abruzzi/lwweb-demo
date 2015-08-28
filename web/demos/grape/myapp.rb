require 'sinatra'
require 'json'
require 'haml'

module MyModule
	class MyApplication < Sinatra::Base

		get '/index' do
			@user = {
				:name => "Juntao",
				:address => "Xi'an, China"
			}
			haml :index
		end

	end
end
