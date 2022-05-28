class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    user.present?
  end

  def new?
    user.present?
  end

  def create?
    new?
  end

  def show?
    record.user_id == user.id || user.role.admin?
  end

  def edit?
    (record.user_id == user.id && record.created_at + 2.hours > DateTime.now) || user.role.admin?
  end

  def update?
    edit?
  end

  def destroy?
    user.role.admin?
  end
end
