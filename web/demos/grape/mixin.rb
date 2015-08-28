require 'grape'
require 'json'

require './models/product'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'db/development.sqlite3'
)

module MySys
    class API < Grape::API
        format :json

        resource :products do

            desc "get all prodcuts information"
            get do
                Product.limit(20)
            end

        end
    end
end