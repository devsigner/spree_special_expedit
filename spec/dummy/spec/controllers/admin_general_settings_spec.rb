# -*- encoding : utf-8 -*-
require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe Admin::GeneralSettingsController do
  
  login_user
  
  before(:each) do
	end
  
  it "should render show" do
    get :show
    response.status.should be 200
  end
  
  it "should render show" do
    get :edit
    response.status.should be 200
  end
  
end
