class PostPolicy < ApplicationPolicy
  def create?
    record.topic.user == user
  end
end