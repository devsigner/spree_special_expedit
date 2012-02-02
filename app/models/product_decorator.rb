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
    variants.any? && !!variants.find{|v| not v.is_sample} # On ne considère pas l'échantillon comme une variante - Ainsi dans la fiche pas de variantes parasites
  end

  def sell_mode_to_s
    {'M' => "/ #{I18n.t(:sell_mode_square)}", 'U' => "/ #{I18n.t(:sell_mode_unit)}" }[self.sell_mode] if self.sell_mode.present?
  end

end
