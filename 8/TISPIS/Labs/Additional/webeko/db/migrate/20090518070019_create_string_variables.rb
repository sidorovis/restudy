class CreateStringVariables < ActiveRecord::Migration
  def self.up
    create_table :string_variables do |t|
      t.string :title
      t.text :description
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :string_variables
  end
end
