class Ability
    include CanCan::Ability

    def initialize(user)
    	alias_action :create, :update, :destroy, :to => :modify

    	can :manage, :all if user.is_a?(Admin) 
    	cannot :modify, [Event,User] if user.is_a?(User)
    	can :read, :all if user.is_a?(User)
    	can :check, :all if user.is_a?(User)
    	can :checkin, :all if user.is_a?(User)
        can :checkback, :all if user.is_a?(User)
    	can :manage, [Checkin,Student] if user.is_a?(User)
        can :checkin, :all if user.is_a?(Admin)
        can :checkback, :all if user.is_a?(Admin)
        can :manage, [Checkin,Student] if user.is_a?(Admin)
    end
end