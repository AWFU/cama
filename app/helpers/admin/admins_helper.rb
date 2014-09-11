#encoding: utf-8
module Admin::AdminsHelper
  # role name
  def role_name(admin) 
    if admin.has_role?(:superadmin)
      "總管理"
    elsif admin.has_role?(:admin)
      "線上購物區管理"
    elsif admin.has_role?(:moderator)
      "線上購物區管理(部分)"
    else
      "Invalid Account"
    end
      
  end

  def is_role(admin, role)
    if admin.has_role?(role)
      true
    else
      false
    end
  end
end
