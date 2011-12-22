Deface::Override.new(
  :name => "product_show1",
  :virtual_path => "products/show",
  :insert_after => "div#cart-form",
  :partial  => '../views/overrides/product_ask_sample_button',
  :disabled => false
)

Deface::Override.new(
  :name => "product_show2",
  :virtual_path => "products/_cart_form",
  :insert_after => "span.price",
  :partial  => '../views/overrides/product_show_sell_mode',
  :disabled => false
)

Deface::Override.new(
  :name => "product_show3",
  :virtual_path => "products/_cart_form",
  :replace => "span.sell_mode",
  :partial  => '../views/overrides/product_show_sell_mode',
  :disabled => false
)
