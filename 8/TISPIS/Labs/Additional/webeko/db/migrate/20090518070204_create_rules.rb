class CreateRules < ActiveRecord::Migration
  def self.up
    create_table :rules do |t|
      t.string :title
      t.text :description
      t.boolean :is_integer
      t.boolean :is_string
      t.integer :string_variable_id
      t.integer :integer_variable_id

      t.timestamps
    end
  end

  def self.down
    drop_table :rules
  end
end
