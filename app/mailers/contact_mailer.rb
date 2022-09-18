class ContactMailer < ApplicationMailer
    default from: 'flagifyteam@gmail.com'
    layout 'mailer'
    rescue_from Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError,
         Net::SMTPFatalError, Net::SMTPUnknownError do |exception|
        #handle it here
        :notice => "Problem sending email #{exception}"
        render :index 

    end
    
    def contact(email,subject,message)
        @message=message
        @email=email
        mail(to: 'flagifyteam@gmail.com',:subject =>"#{subject}")
    end

end
