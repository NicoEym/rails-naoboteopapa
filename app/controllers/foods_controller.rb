class FoodsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  before_action :set_food, only: [:show, :edit, :update, :destroy]

  def new
    @food = Food.new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @food.restaurant = @restaurant
    authorize @food
  end

  def create
    @food = Food.new(food_params)
    @food.restaurant = Restaurant.find(params[:restaurant_id])
    authorize @food
    if @food.save
      redirect_to restaurant_path(@food.restaurant)
    else
      render :new
    end
  end

  def index
    @foods = policy_scope(Food)
    restaurants = []

    @foods.each do |food|
      restaurants << food.restaurant if !food.restaurant.latitude.nil? && !food.restaurant.longitude.nil?
    end

    @restaurants = restaurants.uniq
     @markers = @restaurants.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        infoWindow: render_to_string(partial: "infowindow", locals: { restaurant: restaurant }),
      }
    end
  end

  def my_foods
    this_user_restaurant = Restaurant.find_by(user: current_user)
    @foods = policy_scope(Food).where(restaurant: this_user_restaurant)
    authorize @foods
  end

  def show
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    restaurant_id = @restaurant.id
    @foods = Food.where(restaurant_id: restaurant_id)
  end

  def update
    authorize @food
    @food.update(food_params) if @food.name != params[:name] || @food.price != params[:price] || @food.photo != params[:photo]
    redirect_to restaurant_path(@food.restaurant)
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @food.destroy
    redirect_to restaurant_path(@restaurant)
  end

  private

  def set_food
    @food = Food.find(params[:id])
    authorize @food
  end

  def food_params
    params.require(:food).permit(:restaurant_id, :name, :price, :photo)
  end
end

