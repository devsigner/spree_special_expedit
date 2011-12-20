Deface::Override.new(
  :virtual_path => "orders/_line_item",
  :replace => "[data-hook='cart_item_description'] h4",
  :partial  => '../views/overrides/order_show',
  :name => "order_show",
  :disabled => false
)

Deface::Override.new(
  :virtual_path => "orders/_line_item",
  :replace => "[data-hook='cart_item_quantity']",
  :partial  => '../views/overrides/cart_item_quantity',
  :name => "cart_item",
  :disabled => false
)