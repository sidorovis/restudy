class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
	  t.string	:title
	  t.text	:description
      t.integer :project_id
      t.integer :user_id
	  t.integer :role_template_id

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
