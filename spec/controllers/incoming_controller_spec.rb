require 'rails_helper'

# use expect instead of should

describe IncomingController do

  context "create" do
    it "creates valid attributes" do
      expect{
        post :create
      }.to change {Category.count}.by(1)
      expect(response).to be_redirect
    end
  end


end