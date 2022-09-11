class ChallengesController < ApplicationController
   before_action :authenticate_user!
   before_action :set_challenge, only: %i[ edit update destroy ]
   def index
      @categories_admin = Challenge.where(:user_id => User.where(:role => "admin")).select("category").distinct
      @challenges_creator = Challenge.where.not(:user_id => User.where(:role => "admin")).all
      @n_per_car = 4
      @n_creator_chall = @challenges_creator.count/@n_per_car +1
      @challenge = Challenge.first
      @done_challenges = UserChallenge.all.where(:user_id => current_user.id).where.not(:flag_timestamp => nil)
      @admin_list = User.where(:role => "admin")
   end
   def show
      @challenge = Challenge.find(params[:id])
      @current_challenge = @challenge
      if @current_challenge.url_image
         GoogledriveController.new.googledrive if !$session
         @names=@current_challenge.url_image.split('+')
         @file_list=[]
         @names.each do |f|
            puts "FILENAME:  #{f} "
            @file = $session.file_by_title(f)
            @file_list.push(@file)
            @file.acl.push({type: "anyone", allow_file_discovery: false, role: "reader"})
         end
      end 
      respond_to do |format|
         format.js
      end
   end
   def check_flag
      puts "Check flag function"
      @flag = params[:flag]
      @alert = 3
      puts Time.now.utc.strftime("%Y/%m/%d %H:%M:%S")
      if @flag == Challenge.find(params[:id]).flag
         if UserChallenge.where(:user_id =>current_user.id, :challenge_id => params[:id]).where.not(:flag_timestamp => nil).count == 1
            @alert = 3
         else
            if UserChallenge.where(:user_id =>current_user.id, :challenge_id => params[:id]).count == 1
               UserChallenge.where(:user_id =>current_user.id, :challenge_id => params[:id]).update(:flag_timestamp => Time.now.utc.strftime("%Y/%m/%d %H:%M:%S"))
               puts "UserChallenge aggiornata con flag"
            else
               UserChallenge.create(:id => UserChallenge.last.id+1, :user_id =>current_user.id, :challenge_id => params[:id], :flag_timestamp => Time.now.utc.strftime("%Y/%m/%d %H:%M:%S"))
               puts "UserChallenge creata con flag"
            end
            @alert = 1 

         end
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
   def upload(file_list)
      GoogledriveController.new.googledrive if !$session
      file_list.each do |f|
         @filename= f.original_filename
         File.open(Rails.root.join('public', 'uploads', @filename), 'wb') do |file|
           file.write(f.read)
         end
         $session.upload_from_file("./public/uploads/#{@filename}", @filename, convert: false)
         puts "FILE UPLOADED: #{@filename}"
         File.delete("./public/uploads/#{@filename}")
      end     
   end

   def create
      @names=""
      @file_list=params[:challenge][:upfile]
      puts "FILE LIST : #{@file_list}"
      if @file_list
         upload(@file_list)
         @file_list.each do |f|
            @names.concat(f.original_filename)
            @names.concat('+')
         end
      end
      @challenge=Challenge.new(challenge_params.merge(:url_image => @names, :user_id => current_user.id))
      respond_to do |format|
         if @challenge.save 
            if current_user.role=="player" 
               current_user.role="creator" 
               User.find(current_user.id).update(:role => "creator")
            end
            format.html { redirect_to challenges_url, notice: "Challenge was successfully created." }
         else
            format.html { render :new, status: :unprocessable_entity }
         end
      end
   end

   def edit

   end


   def update
      @names=""
      @file_list=params[:challenge][:upfile]
      @file_list.each do |f|
         @names.concat(f.original_filename)
         @names.concat('+')
      end
      respond_to do |format|
         if @challenge.update(challenge_params.merge(:url_image => @names))
           format.html { redirect_to challenges_url, notice: "Challenge was successfully updated." }
         else 
           format.html { render :edit, status: :unprocessable_entity }
         end
      end
   end

   def destroy
      GoogledriveController.new.googledrive if !$session
      @names=@challenge.url_image.split('+')
      @names.each do |f|
         @file=$session.file_by_title(f)
         @file.delete(permanent=false)
      end
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
