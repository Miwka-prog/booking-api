class BookingApartmentPolicy < ApplicationPolicy
  def create?
    user&.has_any_role? :user, :admin, :host
  end

  def update?
    record.user == user if user
  end

  def destroy?
    record.user == user if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
