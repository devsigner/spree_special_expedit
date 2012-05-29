# -*- encoding : utf-8 -*-
Deface::Override.new(
  :name => "product_ask_sample_button",
  :virtual_path => "products/show",
  :insert_after => "div#thumbnails",
  :partial  => '../views/overrides/product_ask_sample_button',
  :disabled => false
)

Deface::Override.new(
  :name => "product_show_sell_mode",
  :virtual_path => "products/_cart_form",
  :insert_after => "span.price",
  :partial  => '../views/overrides/product_show_sell_mode',
  :disabled => false
)

Deface::Override.new(
  :name => "product_show_sell_mode_replace_sell_mode",
  :virtual_path => "products/_cart_form",
  :replace => "span.sell_mode",
  :partial  => '../views/overrides/product_show_sell_mode',
  :disabled => false
)
