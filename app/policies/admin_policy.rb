class AdminPolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user, _)
    @user = user
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
    user.admin?
  end

  def update?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def add_song?
    user.admin?
  end

  def delete_song?
    user.admin?
  end

end