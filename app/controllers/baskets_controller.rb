class BasketsController < ApplicationController

  # def new
  #   @basket = Basket.new
  #   @basket.user_id = params[:user]
  #   @basket.food_id = params[:food]

  # end

  def create
    @basket = Basket.new(basket_params)
    authorize @basket
    if @basket.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def basket_params
    params.require(:basket).permit(:food_id, :user_id)
  end
end
