class CreateIssues < ActiveRecord::Migration
  def self.up
    create_table :issues do |t|
      t.string :title
      t.text :description
      t.integer :issue_status_id
	  t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :issues
  end
end
