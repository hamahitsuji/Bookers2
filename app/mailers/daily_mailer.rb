class DailyMailer < ApplicationMailer
  default from: ENV['USER_NAME']

  def notify_user
    mail(
      subject: "everyday Bookers!yay!",
      to: User.pluck(:email)
    ) do |format|
      format.text
    end
  end
end
