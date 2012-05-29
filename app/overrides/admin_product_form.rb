# -*- encoding : utf-8 -*-
Deface::Override.new(
  :virtual_path => "admin/products/_form",
  :insert_bottom => "[data-hook='admin_product_form_right']",
  :partial  => '../views/overrides/admin_product_form',
  :name => "add_admin_product_form_sample",
  :disabled => false
)
