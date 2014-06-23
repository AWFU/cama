#encoding: utf-8
class Orderlog < ActiveRecord::Base
  belongs_to :order

  def self.generate_orderlog(order)
    order.orderlogs.create({ content: "訂單變更狀態為：#{self.get_payment_status}" })
  end
end
