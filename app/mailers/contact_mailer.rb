class ContactMailer < ApplicationMailer
    default from: 'flagify@outlook.it'
    layout 'mailer'
    rescue_from Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError,
         Net::SMTPFatalError, Net::SMTPUnknownError do |exception|
        #handle it here
        flash[:error]= "Problem sending email #{exception}"
        render :index 

    end
    
    def contact(email,subject,message)
        @message=message
        @email=email
        mail(to: 'flagify@outlook.it',:subject =>"#{subject}")
    end

end
