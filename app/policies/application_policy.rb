# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    unless user
      raise Pundit::NotAuthorizedError,
            I18n.t("policies.application.you_are_not_logged_in")
    end

    @user = user
    @record = record
  end

  def index?
    user.admin?
  end

  def show?
    user.admin?
  end

  def create?
    user.admin?
  end

  def new?
    create?
  end

  def update?
    user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    user.admin?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      unless user
        raise Pundit::NotAuthorizedError,
              I18n.t("policies.application.you_are_not_logged_in")
      end

      @user = user
      @scope = scope
    end

    def resolve
      user.admin? ? scope.all : scope.none
    end
  end
end
