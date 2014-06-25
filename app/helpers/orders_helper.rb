#encoding: utf-8
module OrdersHelper
  def sum_order_items(order_items)
    return order_items.inject(0) { | sum, i | sum += i.item_price * i.amount }
  end

  def get_shipping_fee
    return 120
  end

  def is_order_paid(order)
    case order.payment_type
    when "atm_transfer" #匯款
      case order.payment_status
      when "wait_to_deliver", "finished"
        "是"
      when "new", "check_paid"
        "否"
      end
    when "credit_card" #信用卡轉帳
      case order.payment_status
      when "wait_to_deliver", "finished"
        "是"
      when "new"
        "否"
      end
    when "third_part" #第三方支付
      case order.payment_status
      when "finished"
        "是"
      when "new", "wait_to_deliver", "check_paid"
        "否"
      end
    when "pay_while_received" #郵局貨到付款
      case order.payment_status
      when "finished"
        "是"
      when "wait_to_deliver", "check_paid"
        "否"
      end
    when "virtual_account" #虛擬帳號
      case order.payment_status
      when "wait_to_deliver", "finished"
        "是"
      when "check_paid"
        "否"
      end
    end
  end

  def is_order_delivered(order)
    case order.payment_type
    when "atm_transfer" #匯款
      case order.payment_status
      when "finished"
        "是"
      when "new", "check_paid", "wait_to_deliver"
        "否"
      end
    when "credit_card" #信用卡轉帳
      case order.payment_status
      when "finished"
        "是"
      when "new", "wait_to_deliver"
        "否"
      end
    when "third_part" #第三方支付
      case order.payment_status
      when "check_paid", "finished"
        "是"
      when "new", "wait_to_deliver"
        "否"
      end
    when "pay_while_received" #郵局貨到付款
      case order.payment_status
      when "check_paid", "finished"
        "是"
      when "wait_to_deliver"
        "否"
      end
    when "virtual_account" #虛擬帳號
      case order.payment_status
      when "finished"
        "是"
      when "check_paid", "wait_to_deliver"
        "否"
      end
    end
  end
end