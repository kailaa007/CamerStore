class User < ApplicationRecord
    has_secure_password
    
    has_one :cart
    after_create :add_cart

    def add_cart
      create_cart()
    end
end
