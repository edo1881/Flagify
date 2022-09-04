class Challenge < ApplicationRecord
    belongs_to :user
    has_many   :user_challenges
end
