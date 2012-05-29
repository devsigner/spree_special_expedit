# -*- encoding : utf-8 -*-
require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe Admin::ConfigurationsController do
  
  login_user
  
  before(:each) do
    #login_user() était ici avant de passer à méthode factory girl
	end
  
  it "should deface and render admin configurations index" do
    get :index
    response.status.should be 200
  end  
  
end
