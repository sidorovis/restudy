class CreateBugStatuses < ActiveRecord::Migration
  def self.up
    create_table :bug_statuses do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :bug_statuses
  end
end
