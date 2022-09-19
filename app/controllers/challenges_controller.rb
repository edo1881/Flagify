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

      if ENV["CUCUMBER"]
         respond_to do |format|
            format.html {render '_challenge_modal', challenge: @current_challenge, remote: true}
         end
      else

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
         format.js {}
      end
      end
   end
   def check_flag
      puts "Check flag function !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
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
               @id = 0
               if UserChallenge.count > 0
                  @id = UserChallenge.last.id+1
               end
               UserChallenge.create(:id => @id, :user_id =>current_user.id, :challenge_id => params[:id], :flag_timestamp => Time.now.utc.strftime("%Y/%m/%d %H:%M:%S"))
               
                  puts "UserChallenge creata con flag"
            end
            @alert = 1 
         end
      else
         @alert = 2
      end
      if ENV["CUCUMBER"]
         respond_to do |format|
            format.html {render '_check_flag', message: @alert, remote: true}
         end
      else
         respond_to do |format|
            format.js
         end
      end
   end
   def show_hint
      @current_challenge = Challenge.find(params[:id])
      respond_to do |format|
         format.js
      end
   end

   def confirm_hint
      puts "CONFIRM HINT"
      @current_challenge = Challenge.find(params[:id])
      if UserChallenge.where(:user_id => current_user.id, :challenge_id => @current_challenge.id).exists?
         UserChallenge.where(:user_id => current_user.id, :challenge_id => @current_challenge.id).update(:hint_timestamp => Time.now.utc.strftime("%Y/%m/%d %H:%M:%S"))
      else
         @id = 0
         if UserChallenge.count > 0
            @id = UserChallenge.last.id+1
         end
         UserChallenge.create(:id => @id, :user_id => current_user.id, :challenge_id => @current_challenge.id, :hint_timestamp => Time.now.utc.strftime("%Y/%m/%d %H:%M:%S"))
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
      @multipart=true
      @multiple=true
      if ENV['CUCUMBER']
         @multipart=false
         @multiple=''
      end 
      if current_user.role=="player" 
         current_user.role="creator" 
         User.find(current_user.id).update(:role => "creator")
      end
      puts "IN CREATE !!!!!!!!!!!!!!!!!!!!!!!!!"
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
      puts current_user
      puts current_user.id
      @challenge=Challenge.new(challenge_params.merge(:url_image => @names, :user_id => current_user.id))
      respond_to do |format|
         if @challenge.save 
            format.html { redirect_to challenges_url, notice: "Challenge was successfully created." }
         else
            format.html { render :new, status: :unprocessable_entity }
         end
      end
   end

   def edit

   end


   def update
      if current_user.role=="player" 
         :message => "BEWARE: you are not authorized to update challenges." 
         redirect_to root_path
      elsif !current_user.challenges.include? @challenge 
         :message => "BEWARE: you are not authorized to update challenge #{@challenge.title}." 
         redirect_to root_path
      end
      @names=""
      @file_list=params[:challenge][:upfile]
      if !@file_list.nil? && @file_list.length() > 1
         @file_list.each do |f|
            @names.concat(f.original_filename)
            @names.concat('+')
         end
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
      if current_user.role=="player" 
         :message => "BEWARE: you are not authorized to delete challenges." 
         redirect_to root_path
      elsif !current_user.challenges.include? @challenge 
         :message => "BEWARE: you are not authorized to delete challenge #{@challenge.title}." 
         redirect_to root_path
      end
      GoogledriveController.new.googledrive if !$session
      if !@challenge.url_image.nil?
         @names=@challenge.url_image.split('+')
         @names.each do |f|
            @file=$session.file_by_title(f)
            @file.delete(permanent=false)
         end
      end
      @challenge.destroy
      UserChallenge.where(:challenge_id => @challenge.id).delete_all
      respond_to do |format|
        format.html { redirect_to "/users/#{current_user.id}", notice: "Challenge was successfully destroyed." }
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
