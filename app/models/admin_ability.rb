class AdminAbility
  include CanCan::Ability

  def initialize(user)
    
    user ||= Admin.new

    if user.blank?  
      # not logged in 如果user沒登入
      cannot :manage, :all  #設置無法管理任何資源
      cannot :read, :all
      can :read, Error

    elsif user.has_role?(:moderator)
      
      can :manage, Order
      can :manage, Orderask

    elsif user.has_role?(:admin)
      
      can :manage, Announcement
      can :manage, Talk
      can :manage, ProductCate
      can :manage, Product
      can :manage, ProductStock
      can :manage, Order
      can :manage, Orderask
      #can :manage, Banner
      #can :manage, Store
      #can :manage, Service

      #can :read, :all
      #can :read, Order
      #can :read, Error
    elsif user.has_role?(:superadmin) #如果role 為 admin

      can :manage, :all #管理所有資源

    else

      cannot :manage, :all  #設置無法管理任何資源
      cannot :read, :all
      #can :read, Error
    end

    # Define abilities for the passed in user here. For example:
    #Lv.2：商品管理、最新消息管理、談咖啡文章管理、訂單管理、客服管理
    #Lv.3：訂單管理、客服管理
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end

  private

  # def basic_read_only
  #   can :read,    Wrkrec
  # end


end
