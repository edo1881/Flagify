class ChallengesController < ApplicationController
   before_action :authenticate_user!
   def index
      @categories = Challenge.select(:category).distinct
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
      @challenge=Challenge.new(challenge_params.merge(:url_image => "#{filename}"))
      respond_to do |format|
         if @challenge.save
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
