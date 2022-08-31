class ProfileController < ApplicationController
    def index
        @user = User.all
    end
end
