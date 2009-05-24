class CreateTaskStatuses < ActiveRecord::Migration
  def self.up
    create_table :task_statuses do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :task_statuses
  end
end
