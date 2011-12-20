require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe Admin::StatesController do  
  
  before(:each) do
    admin = Factory.create(:admin_user)
    sign_in admin
    @country = Factory.create(:country)
	end
  
  it "should render admin new view" do
    get :new, :country_id => @country.id
    response.status.should == 200
  end
  
  it "should render admin edit view" do
    put :create, :country_id => @country.id, :state => {:name => 'state_test', :abbr => 'ST', :shipping_cost => 300, :shipping_deps => "06 13"}
    @country.reload
    @country.states.count.should == 1
    @country.states.first.abbr.should == 'ST'    
    @country.states.first.shipping_cost.should == 300
    @country.states.first.shipping_deps.should == "06 13"
  end
  
end