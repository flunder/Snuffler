class AddCollection < ActiveRecord::Migration
  def self.up
    create_table :collections do |t|
      t.string :user_id
      t.string :item_id
      t.timestamps
    end
  end

  def self.down
    drop_table :collections
  end
end
