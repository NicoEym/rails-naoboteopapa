class BasketsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @food = Food.find(params[:food_id])
    @basket = Basket.new
  end

  def create
    @basket = Basket.new(basket_params)
    @food = Restaurant.find(params[:restaurant_id])
    if @basket.save
      redirect_to restaurant_path(@food.restaurant)
    else
      render :new
    end
  end

  private

  def basket_params
    params.require(:basket).permit(:food_id, :user_id)
  end
end
