class AddingCardPolicy < ApplicationPolicy
  def create?
    user&.has_any_role? :user, :admin, :host
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
