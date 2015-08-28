require 'data_mapper'

require './models/user'
require './models/notes'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/notes.db")
DataMapper.finalize.auto_upgrade!

User.create(:name => "juntao", :email => "juntao.qiu@gmail.com")
p User.all

user = User.new(:name => 'name')
res = user.save
p user.errors[:email]