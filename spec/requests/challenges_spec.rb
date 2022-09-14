require 'rails_helper'

RSpec.describe "Challenges", type: :request do
  before :each  do
    host! "localhost:3000"
    @user = User.create(:id => 3, :email => "creator@c.it", :password => "12345678", :password_confirmation => "12345678") 
  end

  describe "GET /challenges/check_flag" do
    it "can not render challenge page without login" do
      double("user")
      get "/challenges"
      # expect(response).to render_template('challenges')
    end
  end
end
 