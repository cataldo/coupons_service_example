class DealsController < ApplicationController

  def index
    @deals = Deal.all
  end

  def new
    @deal = deal_type.new
  end

  def edit
    @deal = deal_type.find params[:id]
  end

  def create
    @deal = deal_type.new(params[params[:type].underscore])
    if @deal.save
      redirect_to deals_path
    else
      render :new
    end
  end

  def update
    @deal = deal_type.find params[:id]
    @deal.update_attributes params[params[:type].underscore]
    redirect_to deals_path
  end

  def destroy
    @deal = Deal.find params[:id]
    @deal.destroy
    redirect_to deals_path
  end

  def publish
    @deal = Deal.find params[:id]
    @deal.publish
    redirect_to deals_path
  end

  def finish_success
    @deal = Deal.find params[:id]
    @deal.finish_success
    redirect_to deals_path
  end

  def finish_fail
    @deal = Deal.find params[:id]
    @deal.finish_fail
    redirect_to deals_path
  end

  private

  def deal_type
    params[:type].constantize
  end

end
