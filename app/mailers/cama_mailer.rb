class CamaMailer < ActionMailer::Base
  default from: "from@example.com"

  def order_create(params_hash)
    @params = params_hash
    mail(:to => [ @params[:receiver].email, "kobanae@summers.com.tw" ], :subject => "[cama] 有新訂單")
  end

  def order_status_change(params_hash)
    @params = params_hash
    mail(:to => [ @params[:receiver].email, "kobanae@summers.com.tw" ], :subject => "[cama] 訂單狀態變更")
  end

  def orderask_create(params_hash)
    @params = params_hash
    mail(:to => "kobanae@summers.com.tw", :subject => "[cama] 訂單：#{ @params[:order].ordernum } 有客服詢問")
  end

  def product_ran_out_of_stock(params_hash)
    @params = params_hash
    mail(:to => "kobanae@summers.com.tw", :subject => "[cama] 商品無庫存通知")
  end
end
