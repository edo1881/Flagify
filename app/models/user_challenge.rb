class UserChallenge < ApplicationRecord
    belongs_to :user
    belongs_to  :solved_challenge, :class_name => 'Challenge', :foreign_key => :id
end
