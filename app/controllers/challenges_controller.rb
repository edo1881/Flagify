class ChallengesController < ApplicationController
   before_action :authenticate_user!
   before_action :set_challenge, only: %i[ edit update destroy ]
   def index
      @categories = Challenge.select(:category).distinct 
      @challenge = Challenge.first
   end
   def show
      @challenge = Challenge.find(params[:id])
      @current_challenge = @challenge
      respond_to do |format|
         format.js
      end
   end
   def check_flag
      puts "Check flag function"
      @flag = params[:flag]
      @alert = 3
      if @flag == Challenge.find(params[:id]).flag
         @alert = 1 
      else
         @alert = 2
      end
      respond_to do |format|
         format.js
      end
   end
   def new
      @challenge=Challenge.new
   end
   def upload(uploaded_file)
      @filename= uploaded_file.original_filename
      File.open(Rails.root.join('public', 'uploads', @filename), 'wb') do |file|
        file.write(uploaded_file.read)
      end
      GoogledriveController.new.googledrive if !$session
      $session.upload_from_file("./public/uploads/#{@filename}", "#{@filename}", convert: false)
   end

   def create
      filename=""
      if params[:challenge][:upfile]
         upfile=params[:challenge][:upfile][0]
         puts "ecco upfile #{upfile}"
         upload(upfile)
         filename=upfile.original_filename
      end
      @challenge=Challenge.new(challenge_params.merge(:url_image => "#{filename}", :user_id => current_user.id))
      respond_to do |format|
         if @challenge.save
           current_user.role="creator" if current_user.role=="player" 
           format.html { redirect_to challenges_url, notice: "Challenge was successfully created." }
         else
           format.html { render :new, status: :unprocessable_entity }
         end
      end
   end

   def edit

   end

   def update
      respond_to do |format|
         if @challenge.update(challenge_params)
           format.html { redirect_to challenge_url, notice: "Challenge was successfully updated." }
         else 
           format.html { render :edit, status: :unprocessable_entity }
         end
      end
   end

   def destroy
      @challenge.destroy
      UserChallenge.where(:challenge_id => @challenge.id).delete_all
      respond_to do |format|
        format.html { redirect_to profile_url, notice: "Challenge was successfully destroyed." }
        format.json { head :no_content }
      end
   end

   private
   def set_challenge
      @challenge = Challenge.find(params[:id])
    end
   def challenge_params
      params.require(:challenge).permit(:flag,:testo,:nome,:category,:score,:hint,:upfile,:url_image)
   end
   
end
