class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    record.topic.user == user
  end
end