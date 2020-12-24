class BuyersController < ApplicationController
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

end
