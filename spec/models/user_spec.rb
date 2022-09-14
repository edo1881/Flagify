require 'rails_helper'

RSpec.describe User, :type => :model do

  before(:each) {
    @user = User.create(id: 1, email: "admin@admin.it", password: "12345678", password_confirmation: "12345678")
    @challenge = Challenge.create(id: 1, nome: "Challenge 1", testo: "testo", flag: "flag", category: "Web", hint: "Scrivi flag", score: 100, user_id: 1)
    @user_challenge = UserChallenge.create(:id => 1, :flag_timestamp => "2022/09/08 16:30:27", :user_id => 1, :challenge_id => 1)
  }


  it "should create a user" do
    expect(@user).to be_valid
  end

  describe "Validation" do

    it "should have a valid name" do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it "should have a valid role" do
      @user.role = nil
      expect(@user).to_not be_valid
    end
  end

  describe "Associations" do
    it "has many Challenges" do
      var = described_class.reflect_on_association(:challenges)
      expect(var.macro).to eq :has_many
    end

    it "has many UserChallenge" do 
      var = described_class.reflect_on_association(:user_challenges)
      expect(var.macro).to eq :has_many
    end 

    it "has many SolvedChallenges" do 
      var = described_class.reflect_on_association(:solved_challenges)
      expect(var.macro).to eq :has_many
    end 

  end
end
