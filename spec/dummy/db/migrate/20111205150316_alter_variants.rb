class AlterVariants < ActiveRecord::Migration
  def up
    change_table :variants do |t|
      t.boolean :is_sample, :default => false
    end
  end

  def down
    remove_column :variants, :is_sample
  end
end
