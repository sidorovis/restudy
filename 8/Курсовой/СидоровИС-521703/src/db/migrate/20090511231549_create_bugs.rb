class CreateBugs < ActiveRecord::Migration
  def self.up
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.text :steps_to_reproduce
      t.integer :bug_status_id
	  t.integer :build_id

      t.timestamps
    end
  end

  def self.down
    drop_table :bugs
  end
end
