require 'rails_helper'

RSpec.describe Challenge, type: :model do
  before(:each) {
    @challenge = Challenge.create(id: 1, nome: "Challenge 1", testo: "testo", flag: "flag", category: "Web", hint: "Scrivi flag", score: 100, user_id: 1)
  }

  it "can't create a challenge without a user" do
    expect(@challenge).to_not be_valid
  end
end
