require 'rails_helper'

RSpec.describe UserChallenge, type: :model do
  before(:each) {
    @user = User.create(id: 1, email: "admin@admin.it", password: "12345678", password_confirmation: "12345678")
    @challenge = Challenge.create(id: 1, nome: "Challenge 1", testo: "testo", flag: "flag", category: "Web", hint: "Scrivi flag", score: 100, user_id: 1)
    @user_challenge = UserChallenge.create(:id => 1, :flag_timestamp => "2022/09/08 16:30:27", :hint_timestamp  => "2022/09/09 16:30:27", :user_id => 1, :challenge_id => 1)
  }

  it "should create a user_challenge" do
    expect(@user_challenge).to be_valid
  end

  describe "Validation" do

    # it "should have a flag_timestamp or a hint_timestamp" do
    #   @user_challenge.flag_timestamp = nil
    #   @user_challenge.hint_timestamp = nil
    #   expect(@user_challenge).to_not be_valid
    # end

    it "should have a flag_timestamp or a hint_timestamp" do
      @user_challenge.hint_timestamp = nil
      expect(@user_challenge).to be_valid
    end

    it "should have a flag_timestamp or a hint_timestamp" do
      @user_challenge.flag_timestamp = nil
      expect(@user_challenge).to be_valid
    end

  end

  describe "Associations" do
    it "belongs to a User" do
      var = described_class.reflect_on_association(:user)
      expect(var.macro).to eq :belongs_to
    end

    it "belongs to a Challegne" do
      var = described_class.reflect_on_association(:solved_challenge)
      expect(var.macro).to eq :belongs_to
    end

  end

end
