#encoding: utf-8
namespace :whenever do

  desc "Find those HOLD orders"
  task :delete_hold_orders => :environment do
    Order.delete_hold_orders
  end
  desc "Add member the basic role to user"
  task :add_member_role => :environment do
    User.all.each do |usr|
      usr.add_role :member
      puts usr.email
    end
    puts 'All done'
  end
  # desc "for gem whenever to find expired deals"
  # task :check_deals_new => :environment do
  #   @expired_deals = Deal.expired_new.all

  #   set_expired_deals(@expired_deals, "expired_new", "未在 1 小時內完成更新收件人資訊，訂單已過期")   
  # end

  # task :check_deals_waitpay => :environment do
  #   @expired_deals = Deal.expired_waitpay.all

  #   set_expired_deals(@expired_deals, "expired_wait", "未在 48 小時內更新匯款資訊，訂單已過期")
  # end

  # def set_expired_deals(expired_deals, expired_type, expired_msg)
  #   @expired_deals = expired_deals
  #   @expired_type = expired_type
  #   @expired_msg = expired_msg

  #   @givers = User.where(["id in (?)", @expired_deals.map{ |deal| deal.giver_id }]).all
  #   @accepters = User.where(["id in (?)", @expired_deals.map{ |deal| deal.accepter_id }]).all

  #   @gives = Give.where(["id in (?)", @expired_deals.map{ |deal| deal.give_id }]).all
    
  #   @expired_deals.each do |deal|
  #     @give = @gives.select { |give| give.id == deal.give_id }.first
  #     @give.update_attributes({ :status => "enable", :enable_date => DateTime.now })
      
  #     deal.update_attributes({ :status => "cancelled_expired", :expire_date => nil })
  #     Deallog.create({ :modify_user => "系統", :deal_id => deal.id, :message => "訂單狀態變更為已過期" })

  #     @giver = @givers.select { |user|  user.id == deal.giver_id }.first
  #     @accepter = @accepters.select { |user|  user.id == deal.accepter_id }.first

  #     @warninglog = @accepter.userwarninglogs.new({:message => "#{@expired_msg}，（編號：#{deal.serialnum} goods：#{deal.give_name}）", :user_id => @accepter.id}) if @accepter
  #     if(@warninglog && @warninglog.save)
  #       @accepter.warning

  #       case @expired_type
  #       when "expired_new"
  #         Gffmailer.delay.deal_cancelled_expired_new_accepter({:receiver => @accepter, :deal => deal})

  #         Usermessage.generate({ :receiver_id => deal.giver_id, :msg_type => "deal_expired_new_giver", :trigger => deal })
  #         Usermessage.generate({ :receiver_id => deal.accepter_id, :msg_type => "deal_expired_new_accepter", :trigger => deal })
  #       when "expired_wait"
  #         Gffmailer.delay.deal_cancelled_expired_wait_accepter({:receiver => @accepter, :deal => deal})
          
  #         Usermessage.generate({ :receiver_id => deal.giver_id, :msg_type => "deal_expired_wait_giver", :trigger => deal })
  #         Usermessage.generate({ :receiver_id => deal.accepter_id, :msg_type => "deal_expired_wait_accepter", :trigger => deal })
  #       end

  #       Gffmailer.delay.deal_cancelled_expired_giver({:receiver => @giver, :deal => deal})
  #     end
  #   end

  #   Give.where(["id in (?)", @expired_deals.map{ |deal| deal.give_id }]).update_all({ :status => "enable" })    
  # end

end