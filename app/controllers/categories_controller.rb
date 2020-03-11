class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :update, :destroy]
    before_action :check_if_current_api_user
    skip_before_action :verify_authenticity_token

    def create
        @category = Category.new(category_params)
        if @category.save
            render json: @category, status: :created
        else
            render json: @category.errors, status: :unprocessable_entity
        end
    end

    def index
        @categories = Category.all
        render json: @categories
    end

    def show
      @cat = Category.includes(:products).where('id = ?', @category.id).take
      render json: {category: @cat , products: @cat.products}, status: :ok
    end
    
    def update
      if @category.update(category_params)
        render json: @category
      else
        render json: @category.errors, status: :unprocessable_entity
      end
    end
    
    def destroy
        @category.destroy
    end

    private
    def category_params
        params.permit(:name, :category_type, :model)
    end

    def set_category
        @category = Category.find(params[:id])
    end
end
