class TopicPolicy < ApplicationPolicy
  def set_posts_order_attribute?
    update?
  end

  def newest_first?
    update?
  end

  def oldest_first?
    update?
  end

  def a_to_z?
    update?
  end

  def z_to_a?
    update?
  end

  def highest_rank?
    update?
  end

  def lowest_rank?
    update?
  end
end