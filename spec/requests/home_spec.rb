require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /index" do
    it "render home page" do
      get "/"
      expect(response).to render_template("index")
    end
  end
end
