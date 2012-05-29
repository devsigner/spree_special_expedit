# -*- encoding : utf-8 -*-
class AddProductSellMode < ActiveRecord::Migration
  def up
    change_table :products do |t|
      t.string :sell_mode, :limit => 2
    end
  end

  def down
    remove_column :products, :sell_mode
  end
end
