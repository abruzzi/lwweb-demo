require File.dirname(__FILE__) + '/../app.rb'
require 'rack/test'

set :environment, :test

def app
    Sinatra::Application
end

describe "User service" do
    # include Rack::Test::Methods

    it "should load the user page" do
        get '/'
        expect(last_response).to be_ok
    end

    it "should create new user" do
        post '/', params = {:first => "Mansi", :last => "Sun"}
        expect(last_response).to be_ok
        expect(last_response.body).to eq "Hello, My name is SUN Mansi"
    end
end
