#encoding: utf-8
class Admin < ActiveRecord::Base
  #resourcify
  rolify :role_cname => 'Role'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :timeoutable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email,     :uniqueness => true,
                                  :format => { :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, :message => 'E-Mail 格式不符'  }
  
  validates_uniqueness_of :email, :message => 'E-Mail 已有人使用。'

end
