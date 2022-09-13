require 'rails_helper'

RSpec.describe UserChallenge, type: :model do
  before(:each){
    @user_challenge = UserChallenge.create(:id => 1, :flag_timestamp => "2022/09/08 16:30:27", :challenge_id => 1)
  }
  it "can't create a user_challenge without a user" do
    expect(@user_challenge).to_not be_valid
  end

  it "can't create a user_challenge without a valid user" do
    @user_challenge.user_id = 200
    expect(@user_challenge).to_not be_valid
  end

  it "can't create a user_challenge without a challenge" do
    @user_challenge.user_id = 200
    @user_challenge.challenge_id = nil
    expect(@user_challenge).to_not be_valid
  end

end
