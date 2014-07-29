require 'rails_helper'

RSpec.describe QuestsController, :type => :controller do

  describe "GET main" do
    it "returns http success" do
      get :main
      expect(response).to be_success
    end
  end

  describe 'POST #all' do
    it 'assigns a new user quest to @user_quest' do
      get :all
      expect(assigns(:user_quest)).to be_a_new(UserQuest)
    end

    # it 'should be successful' do
    #   get user_accepted_quests_loc(@)



    # end
  end
  
end
