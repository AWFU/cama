class User < ActiveRecord::Base
  has_many :orders
  has_many :addressbooks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.update_info_on_order_create(current_user, params)
    if(params[:update_member_info] || params[:set_as_default_address])
      if(params[:update_member_info])
        current_user.username = params[:order][:buyer_name]
        current_user.tel = params[:order][:buyer_tel]
      end

      if(params[:set_as_default_address])
        current_user.address_to_receive = params[:order][:receiveraddress]
      end
      current_user.save
    end

    if(params[:add_to_addressbook])
      @addressbook = current_user.addressbooks.create({:address => params[:order][:receiver_address]})
    end
  end
end
