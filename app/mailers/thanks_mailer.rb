class ThanksMailer < ApplicationMailer
  default from: "r.m.c.f.789@gmail.com"

  def thanks_to_user
    #@user = user
    mail(
      subject: "新規登録が完了しました。", #メールのタイトル
      to: "r.m.c.f.789@gmail.com" #@user.email #宛先
    ) do |format|
      format.text
    end
  end
end
