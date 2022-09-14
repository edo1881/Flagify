class UserChallenge < ApplicationRecord
    belongs_to  :user
    belongs_to  :solved_challenge, :class_name => 'Challenge', :foreign_key => :id
    validates :flag_timestamp, :presence => true, :if => :hint?
    validates :hint_timestamp, :presence => true, :if => :flag?

    def hint?
        :hint_timestamp == nil
    end

    def flag?
        :flag_timestamp == nil
    end
end
