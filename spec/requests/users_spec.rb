require 'rails_helper'

RSpec.describe "Users", type: :request do
  before { host! "localhost:3000" }
  describe "GET /show" do
    it "can not render User page without login" do
      get "/users/1"
      expect(response.status).to_not eq(200)
    end
  end
end
