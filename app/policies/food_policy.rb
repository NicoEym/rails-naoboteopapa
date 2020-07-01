class FoodPolicy < ApplicationPolicy
  class Scope < Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if @user.profile.name == "Owner"
        # this_user_foods = []
        this_user_restaurant = Restaurant.find_by(user: @user)
        # this_user_restaurants.each do |this_user_restaurant|
        @scope.where(restaurant: this_user_restaurant)
        # end
        # this_user_foods
      else
        @scope.all
      end
    end
  end

  def create?
    user == record.restaurant.user
  end

  def show?
    true
  end

  def update?
    user == record.restaurant.user
    # - record: the restaurant passed to the `authorize` method in controller
    # - user:   the `current_user` signed in with Devise.
  end

  def destroy?
    user == record.restaurant.user
  end

  def my_foods?
    user == record.restaurant.user
  end


end
