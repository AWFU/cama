class Order < ActiveRecord::Base
  belongs_to :user
  has_many :orderitems, :dependent => :destroy

  before_validation :check_attrs

  def check_attrs
    self.ordernum = self.generate_ordernum if self.ordernum.blank?
    self.payment_type = "credit_card_esun" if self.payment_type.blank?
    self.payment_status = "new" if self.payment_status.blank?
  end

  def generate_ordernum
    Date.today.strftime("%Y%m%d").to_s + ("%04d" % (Order.where("created_at >= ?", Time.zone.now.beginning_of_day).count + 1))
  end
end
