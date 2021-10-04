class ApartmentAmenityPolicy < ApplicationPolicy
  def create?
    record.user == user and user.has_role? :host if user
  end

  def destroy?
    record.apartment.user == user and user.has_role? :host if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
