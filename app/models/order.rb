#encoding: utf-8
class Order < ActiveRecord::Base
  belongs_to :user
  has_many :orderitems, :dependent => :destroy
  has_many :orderasks, :dependent => :destroy
  has_many :orderlogs, :dependent => :destroy

  before_validation :check_attrs
  after_update :deliver_order_notice

  def check_attrs
    self.ordernum = self.generate_ordernum if self.ordernum.blank?
    self.payment_type = "credit_card" if self.payment_type.blank?
    self.payment_status = self.order_progress.first if self.payment_status.blank?
  end

  def generate_ordernum
    Date.today.strftime("%Y%m%d").to_s + ("%04d" % (Order.where("created_at >= ?", Time.zone.now.beginning_of_day).count + 1))
  end

  def get_payment_type
    case(self.payment_type)
    when "atm_transfer"
      "atm 轉帳匯款"
    when "credit_card"
      "線上信用卡轉帳"
    end
  end

  def get_payment_status
    case(self.payment_status)
    when "new"
      "新訂單"
    when "check_paid"
      "待確認收款"
    when "wait_to_deliver"
      "待寄送"
    when "finished"
      "已完成"
    end
  end

  def order_progress
    case(self.payment_type)
    when "atm_transfer" #匯款
      ["check_paid", "wait_to_deliver", "finished"]
    when "credit_card" #信用卡轉帳
      ["new", "wait_to_deliver", "finished"]
    when "third_part" #第三方支付
      ["new", "wait_to_deliver", "check_paid", "finished"]
    when "pay_while_received" #郵局貨到付款
      ["wait_to_deliver", "check_paid", "finished"]
    when "virtual_account" #虛擬帳號
      ["check_paid", "wait_to_deliver", "finished"]
    end
  end

  def deliver_order_notice
  end
end
