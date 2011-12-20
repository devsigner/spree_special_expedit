Deface::Override.new(
  :virtual_path => "admin/products/_form",
  :insert_bottom => "[data-hook='admin_product_form_right']",
  :partial  => '../views/overrides/admin_product_form',
  :name => "admin_product_form",
  :disabled => false
)