#encoding: utf-8
class CamaMailer < ActionMailer::Base
  include OrdersHelper

  #require this lib when sending email by MailGun API
  #require 'multimap'

  #default from
  #default from: "Cama Cafe Postmaster <postmaster@sandbox6bfc02b6428d419186e8f7fa102fb7a1.mailgun.org>"
  #default from: "Cama Cafe <postmaster@sandbox6bfc02b6428d419186e8f7fa102fb7a1.mailgun.org>"
  #default 'X-Mailgun-Campaign-Id' => 'camptest'
  default from: "cama cafe <shopping@camacafe.com>"
  # through api: set basic params
  #before_action :set_basic_data

  # send to user
  def welcome(user)
    ActiveRecord::Base.connection_pool.with_connection do
      attachments.inline['camalogo.png'] = with_logo_image

      @user = user
      mail(:to => [ user.email ], :subject => "cama咖啡 會員註冊通知")
    end
  end

  def atm_checkout_completed_successfully(order)
    # @order = order
    # @ordersum = sum_order_items(order.orderitems) + get_shipping_fee_from_order(order)

    # through api: set params
    # @data[:to] = [ order.user.email, "adam29@livemail.tw" ]
    # @data[:subject] = "cama咖啡 訂購單(#{order.ordernum})" # 主旨
    # @data[:html] = render 'atm_checkout_completed_successfully', locals: {order: @order, ordersum: @ordersum} # 內容
    # @data[:inline] = File.new(File.join("public","images","email", "camalogo.png")) # inline img

    #p data.to_hash
    # back to use mailer
    #mail(@data.to_hash)
    # direct rest post
    #deliver_by_api(@data)
    
    # origin
    attachments.inline['camalogo.png'] = with_logo_image
    ActiveRecord::Base.connection_pool.with_connection do
      user = order.user.email
      @order = order
      @ordersum = sum_order_items(order.orderitems) + get_shipping_fee_from_order(order)
      #headers['X-Mailgun-Campaign-Id'] = '{"o:campaign": "camptest"}'
      #attachments.inline['camalogo.png'] = File.new(File.join("public","images","email", "camalogo.png"))
      mail(:to => [ order.user.email ], :subject => "cama咖啡 訂購單(#{order.ordernum})")
    end
    #mail(:to => [ 'adam@summers.com.tw' ], :subject => "cama咖啡 訂購單(#{order.ordernum})")
  end

  def vaccount_checkout_completed_successfully(order)
    attachments.inline['camalogo.png'] = with_logo_image
    ActiveRecord::Base.connection_pool.with_connection do
      user = order.user.email
      @order = order
      @payment_window = 3 #繳款期限
      mail(:to => [ order.user.email ], :subject => "cama咖啡 訂購單(#{order.ordernum})")
    end
  end

  def cod_checkout_completed_successfully(order)
    attachments.inline['camalogo.png'] = with_logo_image
    ActiveRecord::Base.connection_pool.with_connection do
      user = order.user.email
      @order = order
      mail(:to => [ order.user.email ], :subject => "cama咖啡 訂購單(#{order.ordernum})")
    end
  end

  def general_checkout_completed_successfully(order)
    attachments.inline['camalogo.png'] = with_logo_image
    ActiveRecord::Base.connection_pool.with_connection do
      user = order.user.email
      @order = order
      mail(:to => [ order.user.email ], :subject => "cama咖啡 訂購單(#{order.ordernum})")
    end
  end

  def ship(order)
    attachments.inline['camalogo.png'] = with_logo_image
    ActiveRecord::Base.connection_pool.with_connection do
      user = order.user.email
      @order = order
      mail(:to => [ order.user.email ], :subject => "cama咖啡 出貨通知(#{order.ordernum})")
    end
  end

  def ship_cod(order)
    attachments.inline['camalogo.png'] = with_logo_image
    ActiveRecord::Base.connection_pool.with_connection do
      user = order.user.email
      @order = order
      mail(:to => [ order.user.email ], :subject => "cama咖啡 出貨通知(#{order.ordernum})")
    end
  end

  def cancel_deal(order)
    attachments.inline['camalogo.png'] = with_logo_image
    ActiveRecord::Base.connection_pool.with_connection do
      user = order.user.email
      @order = order
      mail(:to => [ order.user.email ], :subject => "cama咖啡 訂單取消(#{order.ordernum})")
    end
  end
  # send to user end

  # send to admin
  # 訂單成立
  def order_placed(order)
    ActiveRecord::Base.connection_pool.with_connection do
      @order = order
      unless gather_moderator_mailto_address.length == 0
        mail(:to => gather_moderator_mailto_address, :subject => "cama咖啡 新訂單成立(#{order.ordernum})")
        #mail(:to => gather_moderator_mailto_address, bcc: gather_admin_cc_address, :subject => "cama咖啡 新訂單成立")
      end
    end
  end

  #已匯後五碼
  def atm_money_placed(order)
    ActiveRecord::Base.connection_pool.with_connection do
      @order = order
      unless gather_moderator_mailto_address.length == 0
        mail(:to => gather_moderator_mailto_address, :subject => "cama咖啡 ATM填寫後五碼(#{order.ordernum})")
      end
    end
  end

  #新詢問
  def new_order_ask(order)
    ActiveRecord::Base.connection_pool.with_connection do
      @order = order
      unless gather_moderator_mailto_address.length == 0
        mail(:to => gather_moderator_mailto_address, :subject => "cama咖啡 客服信件(#{order.ordernum})")
      end
    end
  end
  # send to admin end

  private 

  # MAILGUN
  # def set_basic_data
  #   @data = Multimap.new
  #   @data[:from] = "Cama Cafe <postmaster@sandbox6bfc02b6428d419186e8f7fa102fb7a1.mailgun.org>"
  # end

  def deliver_by_api(data)
    RestClient.post "https://api:#{ Rails.application.config.action_mailer.mailgun_settings[:api_key]}@api.mailgun.net/v2/#{ Rails.application.config.action_mailer.mailgun_settings[:domain]}/messages", data.to_hash
  end

  def gather_moderator_mailto_address
    Admin.with_any_role(:moderator).collect{|admin| admin['email']} 
  end

  def gather_admin_cc_address
    Admin.with_any_role(:admin).collect{|admin| admin['email']} 
  end

  def with_logo_image
    File.read(File.join("public","images","email", "camalogo.png")) # inline img
  end

end
