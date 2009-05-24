class CreateProjectStatuses < ActiveRecord::Migration
  def self.up
    create_table :project_statuses do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :project_statuses
  end
end
