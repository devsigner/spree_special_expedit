require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe "Add to cart" do
    
  before(:each) do
    @product = create_product(:with_sample => true)    
    @product2 = create_product(:with_sample => false)
	end
  
  it "should add a sample to cart" do
    post '/orders/populate', :products => {@product.id => @product.sample.id}, :quantity => 1
    follow_redirect!    
    response.body.should include(@product.name)
  end
  
  it "should not allow to add a sample to cart more than once" do
    post '/orders/populate', :products => {@product.id => @product.sample.id}, :quantity => 1
    follow_redirect!    
    post '/orders/populate', :products => {@product.id => @product.sample.id}, :quantity => 1
    follow_redirect!    
    @controller.current_order.line_items.size.should == 1
  end
  
  it "should display add to cart sample button" do
    post '/orders/populate', :products => {@product2.id => @product2.master.id}, :quantity => 1
    follow_redirect!   
    get "/products/#{@product.permalink}"
    response.should have_selector("button", :id => "add-sample-to-cart-button")
  end
  
  it "should not display add to cart sample button" do
    post '/orders/populate', :products => {@product.id => @product.sample.id}, :quantity => 1
    follow_redirect!    
    get "/products/#{@product.permalink}"
    response.should_not have_selector("button", :id => "add-sample-to-cart-button")    
  end
  
end