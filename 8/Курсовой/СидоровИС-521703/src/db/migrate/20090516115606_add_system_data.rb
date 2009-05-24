require 'active_record/fixtures'
class AddSystemData < ActiveRecord::Migration
  def self.up
	load_fixtures_from_data()
  end

  def self.down
  end
  
  private
  def self.load_fixtures_from_data()
	Fixtures.create_fixtures(File.join(File.dirname(__FILE__), "data"), "role_templates" )
	Fixtures.create_fixtures(File.join(File.dirname(__FILE__), "data"), "right_templates" )
	Fixtures.create_fixtures(File.join(File.dirname(__FILE__), "data"), "project_statuses" )
	Fixtures.create_fixtures(File.join(File.dirname(__FILE__), "data"), "build_statuses" )
	Fixtures.create_fixtures(File.join(File.dirname(__FILE__), "data"), "bug_statuses" )
	Fixtures.create_fixtures(File.join(File.dirname(__FILE__), "data"), "issue_statuses" )
	Fixtures.create_fixtures(File.join(File.dirname(__FILE__), "data"), "task_statuses" )
  end
end
