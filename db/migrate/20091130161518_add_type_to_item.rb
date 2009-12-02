class AddTypeToItem < ActiveRecord::Migration
  def self.up
      add_column :items, :type, :text 
  end

  def self.down
      remove_column :items, :type
  end
end
