require 'grape'
require 'json'
require 'grape-swagger'

require './models/product'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'db/development.sqlite3'
)

module MySys
    class API < Grape::API
        format :json
		version 'v1', :using => :header, :vendor => "mysys", :strict => true
		
		before do
	  		header['Access-Control-Allow-Origin'] = '*'
	  		header['Access-Control-Request-Method'] = '*'
		end

		add_swagger_documentation
        resource :products do

            desc "get all prodcuts information"
            get do
                Product.limit(20)
            end
		
			desc "return a product"
			params do
			    requires :pid, :type => Integer, :desc => "product id"
			end
			route_param :pid do
			    get do
			        Product.find(params[:pid])
			    end
			end

			desc "create a product"
			params do
			    requires :name, :type => String, :desc => "Product name"
			    requires :price, :type => Float, :desc => "Product price"
			end
			post do
			    product = Product.new(:name => params[:name], :price => params[:price])
			    
			    if product.save
			    	product
			    else
			    	error! product.errors, 500
			    end
			end

        end
    end
end