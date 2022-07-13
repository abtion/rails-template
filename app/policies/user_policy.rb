# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    super || user == record
  end

  def update?
    super || user == record
  end

  def destroy?
    super || user == record
  end

  def permitted_attributes
    [
      :email,
      :name,
      :password,
      :password_confirmation
    ]
  end
end
