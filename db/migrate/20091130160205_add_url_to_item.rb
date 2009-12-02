class AddUrlToItem < ActiveRecord::Migration
  def self.up
      add_column :items, :url, :text 
  end

  def self.down
      remove_column :items, :url
  end
end

