class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
     mail to: "oriri75@gmail.com", subject: "お問い合わせの確認メール"
  end
end
