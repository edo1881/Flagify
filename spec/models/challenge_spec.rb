require 'rails_helper'

RSpec.describe Challenge, type: :model do
  before(:each) {
    @user = User.create(id: 1, email: "admin@admin.it", password: "12345678", password_confirmation: "12345678")
    @challenge = Challenge.create(id: 1, nome: "Challenge 1", testo: "testo", flag: "flag", category: "Web", hint: "Scrivi flag", score: 100, user_id: 1)
    @user_challenge = UserChallenge.create(:id => 1, :flag_timestamp => "2022/09/08 16:30:27", :user_id => 1, :challenge_id => 1)
  }


  it "should create a challenge" do
    expect(@challenge).to be_valid
  end

  describe "Validation" do

    it "should have a valid name" do
      @challenge.nome = nil
      expect(@challenge).to_not be_valid
    end

    it "should have a valid text" do
      @challenge.testo = nil
      expect(@challenge).to_not be_valid
    end
    
    it "should have a valid flag" do
      @challenge.flag = nil
      expect(@challenge).to_not be_valid
    end

    it "should have a valid score" do
      @challenge.score = nil
      expect(@challenge).to_not be_valid
    end    

    it "should have a valid creator" do
      @challenge.user_id = nil
      expect(@challenge).to_not be_valid
    end

  end

  describe "Associations" do
    it "belongs to a User" do
      var = described_class.reflect_on_association(:user)
      expect(var.macro).to eq :belongs_to
    end

    it "has many UserChallenge" do 
      var = described_class.reflect_on_association(:user_challenges)
      expect(var.macro).to eq :has_many
    end 

  end

end
