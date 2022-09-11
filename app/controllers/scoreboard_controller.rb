class ScoreboardController < ApplicationController
    before_action :authenticate_user!
    def index
        #@users = User.all.where.not(:role => "admin")
        @ranking=""
        @category="All Categories"
        if params[:categories]
            @category = params[:categories]
            puts="SONO DENTRO CATEGORY: #{@category}"
        end 
        if !(@category=="All Categories")
            @ranking = UserChallenge.select("user_id","sum(CASE WHEN category is not null and flag_timestamp is not null THEN challenges.score ELSE 0 END)-50*count(CASE WHEN category is not null THEN hint_timestamp END) as tot_score").joins("INNER JOIN challenges ON challenges.id = user_challenges.challenge_id").where("category=? ", @category).group(:user_id).order("tot_score desc")
        else
            @ranking = UserChallenge.select("user_id","sum(CASE WHEN flag_timestamp is not null THEN challenges.score ELSE 0 END)-50*count(hint_timestamp) as tot_score").joins("INNER JOIN challenges ON challenges.id = user_challenges.challenge_id ").group(:user_id).order("tot_score desc")
        end
    end
end
