class CreateIntegerVariables < ActiveRecord::Migration
  def self.up
    create_table :integer_variables do |t|
      t.string :title
      t.text :description
      t.integer :value

      t.timestamps
    end
  end

  def self.down
    drop_table :integer_variables
  end
end
