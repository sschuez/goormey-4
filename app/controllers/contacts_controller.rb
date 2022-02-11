class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :create ]

  def new
    @contact = Contact.new
    authorize @contact
  end
  
  def create
    @contact = Contact.new(contact_params)
    authorize @contact

    if @contact.save
      redirect_to root_path, notice: "Thanks for your message. You will receive a confirmation at #{@contact.email} shortly."
      message_customer = ContactMailer.with(contact: @contact).new_contact
      message_customer.deliver_now
      message_admin = ContactMailer.with(contact: @contact).new_contact_admin
      message_admin.deliver_now
    else
      render :new, notice: "There was an error sending your contact form. Please try agian."
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :message)
  end

end
