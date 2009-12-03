class AddAdminRole < ActiveRecord::Migration
  def self.up
    Role.create :name => "Admin"
  end

  def self.down
  end
end
