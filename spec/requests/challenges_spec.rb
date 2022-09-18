require 'rails_helper'

RSpec.describe "Challenges", type: :request do
  before :each  do
    host! "localhost:3000"
    @user = User.create(:id => 1, :email => "creator@c.it", :password => "12345678", :password_confirmation => "12345678", :role => "creator") 
    @challenge = Challenge.create(id: 1, nome: "Challenge 1", testo: "testo", flag: "flag", category: "Web", hint: "Scrivi flag", score: 100, user_id: 1)
  end

  describe "GET /challenges" do

    it "can't render challenge page without login" do
      get "/challenges"
      expect(response.status).to_not eq(200)
      expect(response).to_not render_template("index")
    end

    it "can render challenge page with login" do
      post "/users/sign_in", :params => {:user =>{:email => @user.email, :password => @user.password}}
      get "/challenges"
      expect(response.status).to eq(200)
      expect(response).to render_template("index")
    end

  end

  describe "try use flag or hint" do
    
    it "can solve a challenge" do
      post "/users/sign_in", :params => {:user =>{:email => @user.email, :password => @user.password}}
      get "/challenges"
      post "/challenges/check_flag", :params => {:flag => "flag", :id => 1, format: :js}
      expect(response).to render_template("check_flag")
      expect(response.status).to eq(200)
    end

    it "can solve ask for a hint" do
      post "/users/sign_in", :params => {:user =>{:email => @user.email, :password => @user.password}}
      get "/challenges"
      post "/challenges/confirm_hint", :params => { :id => 1, format: :js}
      expect(response).to render_template("confirm_hint")
      expect(response.status).to eq(200)
    end
    
  end
end
 