require 'rails_helper'

RSpec.describe "Scoreboards", type: :request do
  before { host! "localhost:3000" }

  describe "GET /index" do
    # before :each do 
    #   @user = User.new(:id => 3, :email => "creator@c.it", :password => "12345678", :password_confirmation => "12345678")
    #   sign_in(@user)
    # end
    it "can not render scoreboard page without login" do
      get "/scoreboard"
      expect(response.status).to_not eq(200)
    end
  end
end
