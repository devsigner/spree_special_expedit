Deface::Override.new(
  :virtual_path => "products/show",
  :insert_after => "div#main-image",
  :partial  => '../views/overrides/product_ask_sample_button',
  :name => "product_show1",
  :disabled => false
)

Deface::Override.new(
  :virtual_path => "products/_cart_form",
  :insert_after => "span.price",
  :partial  => '../views/overrides/product_show_sell_mode',
  :name => "product_show2",
  :disabled => false
)

#Deface::Override.new(
#  :virtual_path => "products/_cart_form",
#  :replace => "code[erb-silent]:contains('@product.has_variants?')",
#  :text => '&& !@product.has_sample',
#  :name => "product_show3",
#  :disabled => false
#)