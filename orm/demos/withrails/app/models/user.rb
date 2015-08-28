class User < ActiveRecord::Base
    has_many :products
end
