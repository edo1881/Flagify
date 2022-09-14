require 'rails_helper'

RSpec.describe "Users", type: :request do
  before :each  do
    host! "localhost:3000"
    @user = User.create(:id => 1, :email => "creator@c.it", :password => "12345678", :password_confirmation => "12345678", :role => "creator") 
    @user = User.create(:id => 2, :email => "admin@c.it", :password => "12345678", :password_confirmation => "12345678", :role => "creator") 
    @challenge = Challenge.create(id: 1, nome: "Challenge 1", testo: "testo", flag: "flag", category: "Web", hint: "Scrivi flag", score: 100, user_id: 2)
    @challenge = Challenge.create(id: 2, nome: "Challenge 2", testo: "testo", flag: "flag", category: "Web", hint: "Scrivi flag", score: 100, user_id: 1)
    @user_challenge = UserChallenge.create(:id => 1, :flag_timestamp => nil, :hint_timestamp  => "2022/09/09 16:30:27", :user_id => 2, :challenge_id => 1)
    post "/users/sign_in", :params => {:user =>{:email => @user.email, :password => @user.password}}
  end

  describe "GET /show" do
    it "can render User page" do
      get "/users/1"
      expect(response.status).to eq(200)
    end

    it "can render User page" do
      get "/users/1"
      expect(response.body).to include("Role: creator")
    end

    it "can become a player" do
      get "/users/become_player/1"
      expect(response.body).to include("redirected")
      get "/users/1"
      expect(response.body).to include("Role: player")
    end

    it "can delete a user" do
      get "/users/delete_user/2"
      expect(response.body).to include("redirected")
      get "/users/2"
      expect(response.body).to include("http://localhost:3000/users/sign_in")
      expect(response.body).to_not include("Role")
    end

  end
end
