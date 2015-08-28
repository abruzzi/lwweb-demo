require './app'

StaticApp = Rack::File.new("static")
MyApp = App.new

run Rack::Cascade.new [StaticApp, MyApp]