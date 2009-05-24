class CreateWordTypes < ActiveRecord::Migration
  def self.up
    create_table :word_types do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :word_types
  end
end
