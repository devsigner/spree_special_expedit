require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe Admin::ProductsController do
  
  login_user
  
  before(:each) do
    @product = create_product()
	end
  
  it "should render admin edit view" do
    get :edit, :id => @product.permalink
    response.status.should == 200
  end
  
end