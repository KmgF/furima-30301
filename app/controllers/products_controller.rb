class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :this_is_not_saller ,only: [:edit,:destroy]
  before_action :set_product, only:[:show,:edit,:update,:destroy]
  before_action :sold_out, only:[:edit]


  def index
    @products = Product.order('created_at DESC')
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

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product.id)
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :category_id, :status_id, :delivery_fee_id, :shipment_prefecture_id, :date_of_shipment_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def this_is_not_saller
    set_product
    unless @product.user_id == current_user.id
      redirect_to root_path
    end 
  end

  def sold_out
    set_product
    if Buyer.find_by(product_id: @product.id)
      redirect_to root_path
    end
  end

end
