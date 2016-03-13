module Admin
  class Ability
    include CanCan::Ability

    def initialize(user)
      return unless user.admin?

      classnames = Deposits.constants.select { |cl| not cl.to_s.include? 'able' }

      can :read, Order
      can :read, Trade
      can :read, Proof
      can :update, Proof
      can :manage, Document
      can :manage, Member
      can :manage, Ticket
      can :manage, IdDocument
      can :manage, TwoFactor

      can :menu, Deposit
      can :menu, Withdraw

      can :manage, ::Deposits
      can :manage, ::Withdraws

      classnames.each do |classname|
        can :manage, ::Deposits::const_get(classname)
        can :manage, ::Withdraws::const_get(classname)
      end
    end
  end
end
