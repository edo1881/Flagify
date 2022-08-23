class ContactForm < ApplicationRecord
    validates :email,:body, presence:true
    validates :body, length: {maximum: 200}
end
