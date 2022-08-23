class ContactformController < ApplicationController
  def new
    @contact=ContactForm.new
  end

  def create
    @contact=ContactForm.new(contact_params)
    send_email(@contact) if @contact.valid?
  end
  def send_email(contact) 
    @message=contact.body
    @subject=contact.subject
    @email=contact.email
    @mail=ContactMailer.contact(@email,@subject,@message).deliver_later
    flash[:success]= "Your email has been successfully sent ;)"  if @mail
    render "home/index"    
end
  private
  def contact_params
      params.permit(:email,:subject,:body)
  end
end
