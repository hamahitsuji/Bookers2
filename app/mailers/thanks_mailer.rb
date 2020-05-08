class ThanksMailer < ApplicationMailer
  default from: ENV['USER_NAME']

  def thanks_to_user(user)
    @user = user
    mail(
      subject: "新規登録が完了しました。", #メールのタイトル
      to: @user.email #宛先
    ) do |format|
      format.text
    end
  end
end
