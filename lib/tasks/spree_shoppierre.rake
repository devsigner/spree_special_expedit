namespace :spree_shoppierre do
  desc "Initialise les valeurs par défaut"
  task :set_defaults => :environment do
    Spree::Config.set(:sample_default_weight => 1.0)
  end
  
  desc "Vérifie la cohérence des départements de livraison"
  task :verify_france_shipping_deps => :environment do
    states = Country.find_by_iso('FR').states
    deps = (1..95).to_a.map{|v| v < 10 ? "0#{v}" : v.to_s}
    states.each {|st| st.shipping_deps.split(' ').each{|sd| deps.delete(sd)} unless st.shipping_deps == nil }
    puts "Départements non affectés :"
    if deps.size == 0
      puts 'aucun'
    else
      puts deps.join(',')
    end
  end
end