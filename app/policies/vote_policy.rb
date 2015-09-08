class VotePolicy < ApplicationPolicy
  def up_vote?
    user.present?
  end

  def down_vote?
    up_vote?
  end
end