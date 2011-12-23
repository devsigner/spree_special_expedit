class SpecialShippingError < Exception
  
end

class Calculator::Special < Calculator
  preference :weight_per_palet, :integer, :default => 750
  preference :maximum_postal_weight, :integer, :default => 30
  preference :postal_base_cost, :float, :default => 7
  preference :postal_weight_cost, :float, :default => 1
  
  def self.description
    "Envoi colis ou palette"
  end

  def compute(object)    
    order = object.is_a?(Shipment) ? object.order : object
    total_cost = 0
    total_weight = 0
    
    states = order.ship_address.country.states
    raise SpecialShippingError.new("ADMIN -> Vous devez définir un ou plusieurs states pour le pays #{order.ship_address.country.name}") if states.size == 0
        
    order.line_items.each do |line_item|
      w = line_item.variant.weight == nil ? 0 : line_item.variant.weight
      total_weight += w * line_item.quantity   
    end
    
    if total_weight <= self.preferred_maximum_postal_weight
      total_cost = self.preferred_postal_base_cost + total_weight * self.preferred_postal_weight_cost
    else
      dep = order.ship_address.zipcode[0..1] 
      palet_shipping_cost = nil    
      states.each do |st| 
        palet_shipping_cost = st.shipping_cost if (st.shipping_deps != nil && st.shipping_deps.split(' ').include?(dep))
      end
      raise SpecialShippingError.new("Les coûts d'envoi par palette vers ce département n'ont pas été définis") if palet_shipping_cost == nil
      total_cost = (total_weight / self.preferred_weight_per_palet).ceil * palet_shipping_cost
    end
    total_cost
  end
end