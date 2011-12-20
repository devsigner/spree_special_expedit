Deface::Override.new(
  :virtual_path => "admin/states/edit",
  :insert_after => "h1",
  :partial  => '../views/overrides/admin_state',
  :name => "admin_state_form",
  :disabled => true
)