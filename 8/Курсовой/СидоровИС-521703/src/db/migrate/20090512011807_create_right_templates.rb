class CreateRightTemplates < ActiveRecord::Migration
  def self.up
    create_table :right_templates do |t|
      t.string :title
      t.text :description
      t.string :controller
      t.string :actions
      t.string :write_ids
      t.string :read_ids
      t.integer :role_template_id

      t.timestamps
    end
  end

  def self.down
    drop_table :right_templates
  end
end
