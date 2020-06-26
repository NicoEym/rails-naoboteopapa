class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id
    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end

  def index
    @restaurants = policy_scope(Restaurant)
    @markers = @restaurants.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        infoWindow: render_to_string(partial: "infowindow", locals: { restaurant: restaurant }),
      }
    end
  end

  def show
    @foods = @restaurant.foods
    @markers =
      [{
        lat: @restaurant.latitude,
        lng: @restaurant.longitude,
        infoWindow: render_to_string(partial: "infowindow", locals: { restaurant: @restaurant }),
      }]
  end

  def my_restaurants
    @restaurants = policy_scope(Restaurant)
    Restaurant.where(user_id: current_user.id)
  end

  def edit
  end

  def update
    @restaurant.update(restaurant_params)
    # redirect_to edit_swim_race_swim_event_path(@restaurant)
  end

  def destroy
    @restaurant.destroy
    # redirect_to swim_races_my_races_path
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :description, :photo)
  end

end
