# -*- encoding : utf-8 -*-
class UpdateOrderState < ActiveRecord::Migration
  def self.up
    Order.all.map(&:update!)
  end

  def self.down
  end
end
