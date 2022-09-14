class UsersController < ApplicationController
    before_action :authenticate_user!
    def def new
        @user = User.new
    end
    
 
    def show
        @user = User.find(params[:id])
        @done_challenges = UserChallenge.all.where(:user_id => @user.id).where.not(:flag_timestamp => nil)
        @hint_challenges = UserChallenge.all.where(:user_id => @user.id).where.not(:hint_timestamp => nil)

        @n_challenge_done = @done_challenges.count
        @n_hint_used = 0
        if @hint_challenges.count 
            @n_hint_used = @hint_challenges.count  
        end
        @score = 0
        @done_challenges.each do |a|
            @score += Challenge.find(a.challenge_id).score
        end 
    end


    def become_player
        current_user = User.find(params[:id])
        if current_user.role == "creator"
            current_user.role="player" 
            User.find(current_user.id).update(:role => "player")
            Challenge.where(:user_id => current_user.id).delete_all
            User.find(current_user.id).challenges.delete_all
        end
        respond_to do |format|
            format.html { redirect_to "/users/#{current_user.id}", notice: "Became player successfully." }
        end
    end

    def delete_user
        user = User.find(params[:id])
        if current_user.id == user.id
            if user.role != "admin"
                UserChallenge.where(:user_id => user.id).delete_all
                Challenge.where(:user => user).delete_all
            end
            User.find(user.id).delete 
        end
        respond_to do |format|
            format.html { redirect_to root_path, notice: "Profile deleted successfully." }
        end
    end
end
