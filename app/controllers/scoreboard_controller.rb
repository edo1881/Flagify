class ScoreboardController < ApplicationController
    before_action :authenticate_user!
    def index
        #@users = User.all.where.not(:role => "admin")
        @ranking = UserChallenge.select(:user_id,"sum(case when flag_timestamp is not NULL then score else 0 end)-50*count(hint_timestamp) as tot_score").joins(:solved_challenge).group(:user_id).order("tot_score desc")
    end
end
