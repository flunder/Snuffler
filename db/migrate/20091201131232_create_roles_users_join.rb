class CreateRolesUsersJoin < ActiveRecord::Migration
  
  def self.up
    create_table :roles_users, :id => false do |t|
      t.column :role_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
    end
=begin    
    admin_user = User.create(:username => 'Admin',
                             :email => 'larsf2005@gmail.com',
                             :profile => 'Site Administrator',
                             :password => 'admin',
                             :password_confirmation => 'admin')                            
    admin_role = Role.find_by_name('Admin')
    admin_user.roles << admin_role
=end    
  end

  def self.down
    drop table :roles_users
    #User.find_by_username('Admin').destroy
  end
end