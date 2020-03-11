class CartsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :check_if_current_api_user
    def create
        @cart = @current_user.cart
        @product = Product.where(id: params[:product_id]).take
        if (@cart.product = @product) && @cart.save
          render json: @cart.product, status: :ok
        else
          render json: {msg: 'cannot add product to cart.'}, status: :unprocessable_entity
        end
    end
    def cart_check
        @cart = @current_user.cart
        if @cart.product.present?
          render json: @cart.product, status: :ok
        else
          render json: {msg: 'Empty cart!'}, status: :ok
        end
    end
end
