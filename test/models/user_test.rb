require "rails_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  RSpec.describe User, :type => :model do
    it "can create an account" do
      expect(User.new(:email => "test@test.it", :password => "12345678", :password_confirmation => "12345678")).to be_valid
    end

    it "can create an admin account if in amin_list" do
      expect(User.new(:email => "admin@admin.it", :password => "12345678", :password_confirmation => "12345678").role).to eq "admin"
    end

    
   
  end
end
