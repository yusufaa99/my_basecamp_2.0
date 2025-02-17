class ContactMailer < ApplicationMailer
  default from: "no-reply@yourdomain.com"

  def send_contact_email(name, email, message)
    @name = name
    @message = message

    mail(
      to: "mattemmsmartprince@gmail.com", # Replace with your support email
      subject: "New Contact Form Submission from #{name}",
      reply_to: email
    )
  end
end
