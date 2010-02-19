class AddPrivateField < ActiveRecord::Migration
  def self.up
    add_column :items, :private, :text 
  end

  def self.down
    remove_column :items, :private
  end
end