class ScoreboardController < ApplicationController
    before_action :authenticate_user!
    def index
        @users = User.all.where.not(:role => "admin")
    end
end
