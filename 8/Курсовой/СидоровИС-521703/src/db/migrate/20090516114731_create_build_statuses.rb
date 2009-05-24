class CreateBuildStatuses < ActiveRecord::Migration
  def self.up
    create_table :build_statuses do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :build_statuses
  end
end
