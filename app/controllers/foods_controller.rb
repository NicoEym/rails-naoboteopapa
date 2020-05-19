class FoodsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.restaurant = Restaurant.find(params[:restaurant_id])
    @food.save
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    restaurant_id = @restaurant.id
    @foods = Food.where(restaurant_id: restaurant_id)
  end

  def update
    @food = Food.find(params[:id])
    @food.update(food_params) if @food.name != params[:name] || @food.price != params[:price] || @food.photo != params[:photo]
    # redirect_to edit_swim_race_swim_event_path(@swim_race)
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to restaurant_path(@restaurant)
  end

  private

  def food_params
    params.require(:food).permit(:restaurant_id, :name, :price, :photo)
  end
end

