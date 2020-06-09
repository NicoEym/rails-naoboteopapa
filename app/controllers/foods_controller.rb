class FoodsController < ApplicationController
  authorize @food

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.restaurant = Restaurant.find(params[:restaurant_id])
    if @food.save
      redirect_to restaurant_path(@food.restaurant)
    else
      render :new
    end
  end

  def index
    @foods = Food.all
    restaurants =[]

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

  def show
    @food = Food.find(params[:id])
  end

  def my_foods
    @restaurants = Restaurant.where(user_id: current_user.id)
    @foods = Food.where(restaurant_id: @restaurants.ids)
  end

  def edit
    @food = Food.find(params[:id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    restaurant_id = @restaurant.id
    @foods = Food.where(restaurant_id: restaurant_id)
  end

  def update
    @food = Food.find(params[:id])
    @food.update(food_params) if @food.name != params[:name] || @food.price != params[:price] || @food.photo != params[:photo]
    redirect_to restaurant_path(@food.restaurant)
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

