class CreateRoleTemplates < ActiveRecord::Migration
  def self.up
    create_table :role_templates do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :role_templates
  end
end
