class FoodPolicy < ApplicationPolicy
  class Scope < Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      case @user.profile.name
        when "Owner" then
          restaurant = Restaurant.find_by(user: @user)

            @scope.where(restaurant: restaurant)


        when "Client" then
          @scope.all
      end
      # @scope.where.not(latitude: nil, longitude: nil)
    end
  end

  def create?
    user == record.restaurant.user
  end

  def show?
    true
  end

  def update?
    record.user == user
    # - record: the restaurant passed to the `authorize` method in controller
    # - user:   the `current_user` signed in with Devise.
  end

  def destroy?
    record.user == user
  end
end
