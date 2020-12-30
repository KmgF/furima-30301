class BuyersController < ApplicationController
  before_action :authenticate_user!
  before_action :sold_out
  before_action :this_is_saller
  before_action :set_product

  def index
    set_product
    @buyer_address = BuyerAddress.new
  end

  def create
    set_product
    @buyer_address = BuyerAddress.new(buyer_params)
    if @buyer_address.valid?
      pay_item
      @buyer_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def buyer_params
    params.require(:buyer_address).permit(:post_number, :prefecture_id, :city, :house_number, :building_name, :tel).merge(user_id: current_user.id, product_id: params[:product_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @product.price,
      card: buyer_params[:token],
      currency: 'jpy'
    )
  end

  def sold_out
    set_product
    redirect_to root_path if Buyer.find_by(product_id: @product.id)
  end

  def this_is_saller
    set_product
    redirect_to product_path(@product.id) if @product.user_id == current_user.id
  end


end
