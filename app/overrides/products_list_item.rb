Deface::Override.new(
  :virtual_path => "shared/_products",
  :insert_after => "[data-hook='products_list_item'] span.price",
  :partial  => '../views/overrides/product_list_item',  
  :name => "products_list_item",
  :disabled => false
)