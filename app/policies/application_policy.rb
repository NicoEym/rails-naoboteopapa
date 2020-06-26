class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user   = user
    @record = record
  end

  class Scope
    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, "must be logged in" unless user
      @user = user
      @scope = scope
    end
  end

  def new?
    create?
  end

  def create?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def edit?
    update?
  end

  def update?
    false
  end

  def destroy?
    false
  end
end
