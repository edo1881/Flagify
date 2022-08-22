class HomeController < ApplicationController
  def index
  end
  private
    def send_email 
      @message=params[:message]
      @subject=params[:name]
      @email=params[:email]
      @response=ContactMailer.contact(@email,@subject,@message).deliver_later
    if @response
  end
end
