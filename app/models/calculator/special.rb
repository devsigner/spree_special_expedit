class SpecialShippingError < Exception

end

class Calculator::Special < Calculator
  preference :weight_per_palet, :integer, :default => 750
  preference :maximum_postal_weight, :integer, :default => 30
  preference :postal_base_cost, :float, :default => 7
  preference :postal_weight_cost, :float, :default => 1

  attr_accessor :total_weight, :total_cost, :states, :order

  def self.description
    "Envoi colis ou palette"
  end

  def compute(object)
    self.order = object.is_a?(Shipment) ? object.order : object

    self.states = order.ship_address.country.states
    raise SpecialShippingError.new("ADMIN -> Vous devez définir un ou plusieurs states pour le pays #{self.order.ship_address.country.name}") if self.states.size == 0

    self.calcul_total_weight( self.order )

    self.total_cost = 0

    if self.total_weight <= self.preferred_maximum_postal_weight
      self.total_cost = self.preferred_postal_base_cost + self.total_weight * self.preferred_postal_weight_cost
    else
      self.calcul_palets_shipping_total_cost
    end
    self.total_cost
  end

  def calcul_palets_shipping_total_cost
      dep = self.order.ship_address.zipcode[0..1]
      palet_shipping_cost = nil
      states.each do |st|
        palet_shipping_cost = st.shipping_cost if (st.shipping_deps != nil && st.shipping_deps.split(' ').include?(dep))
      end

      raise SpecialShippingError.new("Les coûts d'envoi par palette vers ce département n'ont pas été définis") if palet_shipping_cost == nil
      palet_number = self.calcul_palet_number( total_weight, preferred_weight_per_palet )

      self.total_cost = self.calcul_palets_shipping_cost_with_shed( palet_shipping_cost, palet_number )
  end

  def calcul_palets_shipping_cost_with_shed( palet_shipping_cost, palet_number )
    if palet_number > 1
      palet_shipping_cost + ( ( palet_shipping_cost * 0.6) * (palet_number - 1) )
    else
      palet_shipping_cost
    end
  end

  def calcul_palet_number(weight, palet_weight)
    ( weight / palet_weight ).ceil
  end

  def calcul_total_weight(order)
    self.total_weight = 0
    order.line_items.each do |line_item|
      weight = line_item.variant.weight == nil ? 0 : line_item.variant.weight
      self.total_weight += weight * line_item.quantity
    end
    self.total_weight
  end

end
