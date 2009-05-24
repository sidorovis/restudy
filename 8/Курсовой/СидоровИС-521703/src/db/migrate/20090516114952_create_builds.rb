class CreateBuilds < ActiveRecord::Migration
  def self.up
    create_table :builds do |t|
      t.string :title
      t.text :description
      t.integer :build_status_id
	  t.integer :project_id
      t.timestamps
    end
  end

  def self.down
    drop_table :builds
  end
end
