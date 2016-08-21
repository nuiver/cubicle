class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # Can READ anything
    can :read, :all

    if user.persisted? # in db, so logged in
      # Can MANAGE (create, read, update, destroy, etc.) own Post
      can :manage, Piece, :user_id => user.id


    end
  end
end
