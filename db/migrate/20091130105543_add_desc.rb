class AddDesc < ActiveRecord::Migration
  def self.up
      add_column :items, :blurber, :text 
  end

  def self.down
      remove_column :items, :blurber
  end
end
