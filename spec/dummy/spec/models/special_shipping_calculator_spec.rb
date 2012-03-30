require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe Calculator::Special do

  before(:each) do
    @order = Factory(:order_with_totals)
    @order.update_attributes(:ship_address => @order.bill_address)
    @order.ship_address.update_attributes(:zipcode => '33800')
    #Spree::Config.set(:sample_default_weight => 1.0)
	end

  it "should raise if no state have been provided for this country" do
    @order.ship_address.country.states.destroy_all
    expect {
      Calculator::Special.new().compute(@order)
    }.to raise_error SpecialShippingError
  end

  it "should raise if no dep is ok for this shipping address and shipping is palet" do
    @order.line_items.first.variant.update_attributes(:weight => 1200)
    expect {
      Calculator::Special.new().compute(@order)
    }.to raise_error SpecialShippingError
  end

  it "should compute 1 palet shipping" do
    sp = 100
    @order.line_items.first.variant.update_attributes(:weight => 100)
    total_w = @order.line_items.inject(0) {|result, element| result += element.variant.weight}
    @order.ship_address.country.states.create!(:abbr => 'TS', :name => 'Test', :shipping_cost => sp, :shipping_deps => "06 33 99")
    calc = Calculator::Special.new()
    cost = calc.compute(@order).to_f
    max_pal = calc.preferred_weight_per_palet
    cost.should == ((total_w.to_f / max_pal).ceil * sp).to_f
  end

  it "should compute 2 palet shipping" do
    sp = 100
    @order.line_items.first.variant.update_attributes(:weight => 1000)
    total_w = @order.line_items.inject(0) {|result, element| result += element.variant.weight}
    @order.ship_address.country.states.create!(:abbr => 'TS', :name => 'Test', :shipping_cost => sp, :shipping_deps => "06 33 99")
    calc = Calculator::Special.new()
    cost = calc.compute(@order).to_f

    calc.calcul_palet_number( total_w, 600).should == 2
    calc.calcul_palets_shipping_cost_with_shed( sp, 2).should == 160.0

    max_pal = calc.preferred_weight_per_palet

    cost.should == (sp + ((((total_w.to_f / max_pal) - 1).ceil * sp) * 0.6)).to_f
  end

  it "should compute postal shipping" do
    sp = 150
    @order.line_items.first.variant.update_attributes(:weight => 5)
    total_w = @order.line_items.inject(0) {|result, element| result += element.variant.weight}
    calc = Calculator::Special.new()
    cost = calc.compute(@order).to_f
    cost.should == (total_w.to_f * calc.preferred_postal_weight_cost + calc.preferred_postal_base_cost).to_f
  end

end
