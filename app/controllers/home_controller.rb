class HomeController < ApplicationController
  def index
  end
  def send_email 
    @message=params[:message]
    @subject=params[:name]
    @email=params[:email]
    ContactMailer.contact(@email,@subject,@message).deliver_later
  end
end
