require './products'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'development.sqlite3'
)

ActiveRecord::Migration.verbose = true
ActiveRecord::Base.logger = Logger.new STDOUT


ActiveRecord::Migrator.migrate "./", nil

prod = Product.new(:name => "Mac Book Pro", :price => 12345.67)
prod.new_record?
prod.save

prod = Product.create(:name => "iPhone 5s", :price => 4567.89, :detail => "iPhone 5s")
