class Challenge < ApplicationRecord
    has_many :user_challenge
    has_many :user, :through => :user_challenge 
end
