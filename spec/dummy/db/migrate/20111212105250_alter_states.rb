# -*- encoding : utf-8 -*-
class AlterStates < ActiveRecord::Migration
  def up
    change_table :states do |t|
      t.float  :shipping_cost, :default => 0
      t.string :shipping_deps
    end
  end

  def down
    remove_column :states, :shipping_cost
    remove_column :states, :shipping_deps
  end
end
