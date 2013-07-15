class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def new
    @deal = Deal.find params[:deal_id]
    if @deal.can_buy_coupons?(current_user)
      @order = Order.create  user_id: 1, deal_id: @deal.id, sum: @deal.price
      redirect_to @order
    else
      redirect_to deals_path, notice: "Can't buy coupons for this deal"
    end
  end

  def show
    @order = Order.find params[:id]
  end

  def paid
    @order = Order.find params[:id]
    @order.paid
    redirect_to @order.coupon
  end

  def fail_paid

  end


end
