class ProductsController < ApplicationController
    before_action :check_if_current_api_user
    before_action :set_product, only: [:show, :update, :destroy]
    skip_before_action :verify_authenticity_token

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def index
    @products = Product.all
    render json: @products
  end

  def show
    render json: @product
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.permit(:name, :category_id, :description, :price, :make)
    end
end

