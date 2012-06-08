Variant.class_eval do
  
  def count_on_hand
    return 9000 if is_sample
    super
  end
  
end