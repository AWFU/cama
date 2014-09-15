class CamamailerJob
  include SuckerPunch::Job

  # The perform method is in charge of our code execution when enqueued.
  def perform(mailer, method, *args)
    mailer.send(method, *args).deliver
    #ex: CamaMailer.atm_checkout_completed_successfully(order).deliver
  end

end