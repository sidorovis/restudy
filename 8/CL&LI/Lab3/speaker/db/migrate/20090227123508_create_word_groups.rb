class CreateWordGroups < ActiveRecord::Migration
  def self.up
    create_table :word_groups do |t|
      t.string :template
      t.integer :word_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :word_groups
  end
end
