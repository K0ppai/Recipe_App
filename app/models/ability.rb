class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :read, :all
    cannot :read, Recipe
    can :manage, Recipe, user_id: user.id
  end
end
