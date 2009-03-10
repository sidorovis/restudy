class CreateWfAttributes < ActiveRecord::Migration
  def self.up
    create_table :wf_attributes do |t|
      t.string :content
      
      t.timestamps
    end
    
    create_table :wf_attributes_word_forms, :id => false do |t|
      t.integer :word_form_id
      t.integer :wf_attribute_id  
    end
  end

  def self.down
    drop_table :wf_attributes
    drop_table :wf_attributes_word_forms
  end
end
