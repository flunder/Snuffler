class RemoveFeedentries < ActiveRecord::Migration
  def self.up
    drop_table :feed_entries
  end

  def self.down
    create_table :feed_entries do |t|
      t.string :name
      t.text :summary
      t.string :url
      t.datetime :published_at
      t.string :guid

      t.timestamps
    end
  end
end
