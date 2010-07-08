class AddProjectIdToItems < ActiveRecord::Migration
  def self.up
     add_column :items, :project_id, :integer
   end

   def self.down
     remove_column :items, :project_id
   end
end
