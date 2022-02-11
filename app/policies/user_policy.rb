class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def show?
    true
  end

  def user_recipes?
    true
  end
  
  def update?
    user_is_owner_or_admin?
  end
  
  def destroy?
    record == user || user.admin if user
  end
  
  def impersonate?
    user.admin
  end
  
  def stop_impersonating?
    true
  end

  private

  def user_is_owner_or_admin?
    record == user || user.admin if user
  end
end
