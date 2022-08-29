class ChallengesController < ApplicationController
   before_action :authenticate_user!
   def index
      @categories = Challenge.select(:category).distinct
   end
   def new
   end
   def create
   end
   def delete
   end
   def update
   end
end
