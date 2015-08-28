require 'sinatra'
require './lib/user'

get '/' do
    juntao = User.new("juntao", "qiu")
    juntao.greeting
end

post '/' do
    user = User.new(params[:first], params[:last])
    user.greeting
end
