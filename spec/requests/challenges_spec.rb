require 'rails_helper'

RSpec.describe "Challenges", type: :request do
  before { host! "localhost:3000" }
  describe "GET /index" do
    it "can not render challenge page without login" do
      get "/challenges"
      expect(response.status).to_not eq(200)
    end
  end
end   
 