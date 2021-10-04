class ConversationPolicy < ApplicationPolicy
  def show?
    user&.has_any_role? :admin, :user, :host
  end

  def create?
    user&.has_any_role? :admin, :user, :host
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
