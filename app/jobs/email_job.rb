class EmailJob < ApplicationJob
  queue_as :default

  def perform(email)
    WelcomeMailMailer.create_mail(email).deliver_now
  end

  def perform(email_update)
    WelcomeMailMailer.with(user2: email_update).update_mail.deliver
  end
end
