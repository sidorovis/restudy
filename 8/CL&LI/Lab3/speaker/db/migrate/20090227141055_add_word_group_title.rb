class AddWordGroupTitle < ActiveRecord::Migration
  def self.up
    add_column :word_groups, :title, :string
    
  end

  def self.down
    remove_column :word_groups, :title
  end
end
