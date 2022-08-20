class ContactMailer < ApplicationMailer
    default from: 'flagify@outlook.it'
    layout 'mailer'
    def contact(email,subject,message)
        @message=message
        @email=email
        mail(to: 'flagify@outlook.it',:subject =>"#{subject}")
    end

end
