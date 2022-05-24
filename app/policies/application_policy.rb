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

  delegate :admin?, to: :user

  def index?
    admin?
  end

  def show?
    admin?
  end

  def create?
    admin?
  end

  def new?
    admin?
  end

  def update?
    admin?
  end

  def edit?
    admin?
  end

  def destroy?
    admin?
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
