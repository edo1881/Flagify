require 'rails_helper'

RSpec.describe "Scoreboards", type: :request do
  before :each  do
    host! "localhost:3000"
    @user = User.create(:id => 1, :email => "creator@c.it", :password => "12345678", :password_confirmation => "12345678", :role => "creator") 
    @challenge = Challenge.create(id: 1, nome: "Challenge 1", testo: "testo", flag: "flag", category: "Web", hint: "Scrivi flag", score: 100, user_id: 1)
    @user_challenge = UserChallenge.create(:id => 1, :flag_timestamp => nil, :hint_timestamp  => "2022/09/09 16:30:27", :user_id => 1, :challenge_id => 1)
  end

  describe "show scoreboard " do
    it "can render scoreboard page" do
      post "/users/sign_in", :params => {:user =>{:email => @user.email, :password => @user.password}}
      get "/scoreboard", :params => {:categories => "All Categories"}
      expect(response.status).to eq(200)
    end

    it "can render scoreboard page with specific category" do
      post "/users/sign_in", :params => {:user =>{:email => @user.email, :password => @user.password}}
      get "/scoreboard", :params => {:categories => "Web"}
      expect(response.body).to include("Web")
    end

  end
end
