class Challenge < ApplicationRecord
    belongs_to :user
    has_many   :user_challenges, foreign_key: "challenge_id",dependent: :delete_all
    validates :nome, :presence => true
    validates :testo, :presence => true
    validates :flag, :presence => true
    validates :score, :presence => true
end
