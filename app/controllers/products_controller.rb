class ProductsController < ApplicationController
  before_action :authenticate_user!, except: :index
  
  def index
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :category_id, :status_id, :delivery_fee_id, :shipment_prefecture_id, :date_of_shipment_id, :price, :image).merge(user_id: current_user.id)
  end
end
