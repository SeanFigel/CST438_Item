class ChangeNumbericFieldInMyTable < ActiveRecord::Migration
  def self.up
   change_column :items, :price, :decimal, :precision => 15, :scale => 2
  end
end