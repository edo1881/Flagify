class ChallengesController < ApplicationController
   before_action :authenticate_user!
   def index
      @categories = Challenge.select(:category).distinct
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
