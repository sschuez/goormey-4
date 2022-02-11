class LikePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true  # Anyone can create a recipe
  end

  def destroy?
    true
  end
end
