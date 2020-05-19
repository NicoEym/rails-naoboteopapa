class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    # @restaurant.user_id = current_user.id
    if @restaurant.save
      # redirect_to new_swim_race_swim_event_path(@restaurant)
    else
      render :new
    end
  end

  def index
    @restaurants = Restaurant.where.not(latitude: nil, longitude: nil)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    # redirect_to edit_swim_race_swim_event_path(@restaurant)
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    # redirect_to swim_races_my_races_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :description, :photo)
  end

end
