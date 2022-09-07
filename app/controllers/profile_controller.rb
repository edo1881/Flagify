class ProfileController < ApplicationController
    before_action :authenticate_user!
    def index
        @user = User.all
        @done_challenges = UserChallenge.all.where(:user_id => current_user.id).where.not(:flag_timestamp => nil)
        @hint_challenges = UserChallenge.all.where(:user_id => current_user.id).where.not(:hint_timestamp => nil)

        @n_challenge_done = @done_challenges.count
        @n_hint_used = @hint_challenges.count

        @score = 0
        @done_challenges.each do |a|
            @score += Challenge.find(a.challenge_id).score
        end
            
    end
end
