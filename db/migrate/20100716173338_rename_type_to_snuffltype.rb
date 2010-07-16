class RenameTypeToSnuffltype < ActiveRecord::Migration
  def self.up
    rename_column :items, :type, :snuffltype
  end

  def self.down
    rename_column :items, :snuffltype, :type
  end
end
