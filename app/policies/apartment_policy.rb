class ApartmentPolicy < ApplicationPolicy
  def create?
    user&.has_any_role? :user, :admin, :host
  end

  def update?
    record.user == user if user&.has_role?(:host)
  end

  def destroy?
    (record.user == user and user.has_role?(:host)) || user.has_role?(:admin) if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
