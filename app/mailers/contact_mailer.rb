class ContactMailer < ApplicationMailer
  def new_contact
    @contact = params[:contact]
    mail(
      to: @contact.email,
      bcc: "stephens@hey.com",
      subject: "Thanks for getting in touch!",
      # track_opens: true,
      message_stream: 'outbound'
    )
  end

  def new_contact_admin
    @contact = params[:contact]
    mail(
      # from: @contact.email,
      to: "stephens@hey.com",
      subject: "New Message from Goormey",
      message_stream: 'outbound'
    )
  end
end
