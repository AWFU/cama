#encoding: utf-8
class User < ActiveRecord::Base
  rolify :role_cname => 'UserRole'
  
  after_create :assign_member_role

  # resourcify
  # rolify
  has_many :orders
  has_many :addressbooks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :email, :uniqueness => true,
                    :format => { :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, :message => 'E-Mail 格式不符'  }
  
  validates_uniqueness_of :email, :message => 'E-Mail 已有人使用。'
  #scope :useradmin, -> { where(id: current_user.id)}
  scope :for_export, -> { order(:email).select(:id, :email, :username) }

  paginates_per 20
  
  def self.update_info_on_order_create(current_user, params)
    if(params[:update_member_info] || params[:set_as_default_address])
      if(params[:update_member_info])
        current_user.username = params[:order][:buyer_name]
        current_user.tel = params[:order][:buyer_tel]
        current_user.address = params["current_user_address"]#params[:order][:buyer_tel]
      end

      if(params[:set_as_default_address])
        current_user.address_to_receive = params[:order][:receiver_address]
      end
      current_user.save
    end

    if(params[:add_to_addressbook])
      @addressbook = current_user.addressbooks.create({:address => params[:order][:receiver_address]})
    end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv <<  ["ID", "Name", "Email"] #column_names
      all.each do |user|
        csv << [user.id, user.username, user.email]#user.attributes.values_at(*column_names)
      end
    end
  end

  private
  
  def assign_member_role
    self.add_role :member
  end

end
