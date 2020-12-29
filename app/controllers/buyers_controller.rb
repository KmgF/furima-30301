class BuyersController < ApplicationController
  before_action :authenticate_user!
  before_action :sold_out ,only:[:index]
  before_action :this_is_saller

  def index
    @product = Product.find(params[:product_id])
    @buyer_address = BuyerAddress.new
  end

  def create
    @product = Product.find(params[:product_id])
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
def buyer_params
  params.require(:buyer_address).permit(:post_number,:prefecture_id,:city,:house_number,:building_name,:tel).merge(user_id: current_user.id, product_id: params[:product_id],token: params[:token])
end

def pay_item
  Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  Payjp::Charge.create(
    amount: @product.price,
    card: buyer_params[:token],
    currency:'jpy'
  )
end


def sold_out
  @product = Product.find(params[:product_id])
  if Buyer.find_by(product_id: @product.id )
  redirect_to root_path 
  end
end

def this_is_saller
  @product = Product.find(params[:product_id])
  if @product.user_id == current_user.id
    redirect_to product_path(@product.id)
  end
end

end
