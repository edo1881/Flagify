require 'rails_helper'

RSpec.describe User, :type => :model do
  before(:each) {@user = User.new(:id => 1, :email => "test0@test.it", :password => "12345678", :password_confirmation => "12345678")}
  before(:each) {@user_admin = User.new(:id => 2, :email => "admin@admin.it", :password => "12345678", :password_confirmation => "12345678")}
  before(:each) {@user_creator = User.new(:id => 3, :email => "test1@test.it", :password => "12345678", :password_confirmation => "12345678", :role => "creator")}
  
  it "can create an account" do
    expect(@user).to be_valid
  end

  it "can create an admin account if in amin_list" do
    expect(@user_admin.role).to eq "admin"
  end

  it "can create a creator account" do
    expect(@user_creator.role).to eq "creator"
  end

  it "admin can create official challenge" do
    @challenge = Challenge.create(:nome => "nome", :testo => "testo", :flag => "flag", :category => "category", :hint => "Scrivi flag", :score => 100, :user_id => 1)
    expect(@challenge.user_id).to eq @user.id
  end   
end
