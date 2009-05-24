class CreateWordForms < ActiveRecord::Migration
  def self.up
    create_table :word_forms do |t|
      t.string :content
      t.integer :word_group_id

      t.timestamps
    end
  end

  def self.down
    drop_table :word_forms
  end
end
