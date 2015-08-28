require './mysys'
require './myapp'

run Rack::Cascade.new [MyModule::MyApplication, MySys::API]
