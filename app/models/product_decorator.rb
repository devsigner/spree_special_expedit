Product.class_eval do
   
  before_save :update_sample
  
  def update_sample
    already = self.has_sample
    if @has_sample == 'true' && !already
      self.variants.create!(:is_sample => true, :price => 0, :cost_price => 0, :weight => Spree::Config['sample_default_weight'])
    elsif @has_sample == 'false' && already
      self.variants.where(:is_sample => true).first.destroy
    end
  end
  
  def has_sample=(value)
    @has_sample = value
  end
  
  def has_sample
    self.sample != nil 
  end
  
  def sample
    self.variants.where(:is_sample => true).first
  end
  
  def has_variants?
    variants.any? && !has_sample # On ne considère pas l'échantillon comme une variante - Ainsi dans la fiche pas de variantes parasites
  end
  
end