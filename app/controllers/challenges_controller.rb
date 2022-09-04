class ChallengesController < ApplicationController
   before_action :authenticate_user!
   @current_challenge = nil
   def index
      @categories = Challenge.select(:category).distinct 
      @current_challenge = Challenge.first
      puts @current_challenge.to_json
      puts params
   end
   def show
      @current_challenge = Challenge.find(params[:id])
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
           format.html { redirect_to challenges_url, notice: "Movie was successfully created." }
         else
           format.html { render :new, status: :unprocessable_entity }
         end
      end
   end
   def delete
   end
   def update
   end
   private
      def challenge_params
         params.require(:challenge).permit(:flag,:testo,:nome,:category,:score,:hint,:upfile,:url_image)
      end
end
