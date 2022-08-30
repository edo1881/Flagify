class ChallengesController < ApplicationController
   before_action :authenticate_user!
   def index
      @categories = Challenge.select(:category).distinct 
      @current_challenge = Challenge.first
      # if params.nil?
      #    @current_challenge = Challenge.first
      # else
      #    @current_challenge = Challenge.find(params[:id])
      # end
      puts @current_challenge.to_json
      puts params

   end
   def show

   end
   def new
      @challenge=Challenge.new
   end

   def create
      @challenge=Challenge.new(challenge_params)
      @chall_drive_file=params[:upfile]
      
   end
   def delete
   end
   def update
   end
   private
      def challenge_params
         params.require(:challenge).permit(:flag,:desc,:title,:cat)
      end
end
