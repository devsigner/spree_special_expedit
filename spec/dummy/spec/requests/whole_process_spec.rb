require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe "Whole process" do

  before(:each) do
    @product_heavy = create_product(:with_sample => false)
    @product_heavy.update_attributes(:weight => 800, :tax_category => nil)

    @product_heavy_with_sample = create_product(:with_sample => true)
    @product_heavy_with_sample.update_attributes(:weight => 800, :tax_category => nil)

    @product_light = create_product(:with_sample => false)
    @product_light.update_attributes(:weight => 6, :tax_category => nil)

    @product_light_with_sample = create_product(:with_sample => true)
    @product_light_with_sample.update_attributes(:weight => 6, :tax_category => nil)

    Country.all
    @country = Factory(:country)
    @zone = Zone.first
    ZoneMember.create!({:zoneable => @country, :zone => @zone})

    @sm = Factory(:shipping_method)
    @calc = Calculator::Special.create!(:calculable => @sm)
    @sm.update_attributes!(:name => 'Colis Palette', :calculator => @calc)

    @pm = Factory(:payment_method)
    @pm.update_attributes(:environment => 'test')

    @state1 = @country.states.create!(:name => 'state1', :abbr => 'ST1', :shipping_cost => 210, :shipping_deps => '33 40')
    @state2 = @country.states.create!(:name => 'state2', :abbr => 'ST2', :shipping_cost => 330, :shipping_deps => '06 83')
	end

  it "should process an order with heavy products" do
    add_to_cart(@product_heavy.permalink)
    process_order()
    order = Order.last
    order.total.to_s.should == (@product_heavy.price + @state1.shipping_cost + (@state1.shipping_cost * 0.6 ) ).to_s
  end

  it "should process an order with light products" do
    add_to_cart(@product_light.permalink)
    process_order()
    order = Order.last
    order.total.to_s.should == (@product_light.price + @calc.preferred_postal_base_cost + @product_light.weight * @calc.preferred_postal_weight_cost).to_s
  end

  it "should process an order with only samples" do
    add_to_cart(@product_light_with_sample.permalink, true)
    add_to_cart(@product_heavy_with_sample.permalink, true)
    process_order()
    order = Order.last
    order.total.to_s.should == (@calc.preferred_postal_base_cost + Spree::Config['sample_default_weight'] * 2 * @calc.preferred_postal_weight_cost).to_s
  end

  def add_to_cart(permalink, sample = false)
    visit "/products/#{permalink}"
    response.status.should == 200
    click_button sample ? "add-sample-to-cart-button" : "add-to-cart-button"
  end

  def process_order
    # === CART

    current_uri.path.should == '/cart'
    click_link "Checkout"

    # === REGISTRATION

    current_uri.path.should == '/checkout/registration'

    # === CHECKOUT AS GUEST

    fill_in "order_email", :with => 'guest@test.com'
    click_button "Continue"

    # === CHECKOUT

    current_uri.path.should == '/checkout'
    fill_in "order_bill_address_attributes_firstname", :with => 'john'
    fill_in "order_bill_address_attributes_lastname", :with => 'deer'
    fill_in "order_bill_address_attributes_address1", :with => '9812, street foo'
    fill_in "order_bill_address_attributes_city", :with => '9812, street foo'
    fill_in "order_bill_address_attributes_zipcode", :with => '33000'
    fill_in "order_bill_address_attributes_phone", :with => '0505050505'

    check "order_use_billing"
    select @country.name, :from => 'order_bill_address_attributes_country_id'

    click_button "Save and Continue"

    # === DELIVERY

    current_uri.path.should == '/checkout/delivery'
    choose /order_shipping_method_id_.*/
    click_button "Save and Continue"

    # === PAYMENT

    current_uri.path.should == '/checkout/payment'
    choose "order_payments_attributes__payment_method_id_#{@pm.id}"
    click_button "Save and Continue"

    # === CONFIRM [is skipped because there's no payment profile]

#    current_uri.path.should == '/checkout/confirm'
#    click_button "Place Order"

    # === COMPLETE

    current_uri.path.should match /\/orders\/#{Order.last.number}\/token\/*./
  end

  def current_uri()
    URI.parse(current_url)
  end

end
