class RenameUrlToFrom < ActiveRecord::Migration
  def self.up
    rename_column :items, :url, :from
  end

  def self.down
    rename_column :items, :from, :url
  end
end
