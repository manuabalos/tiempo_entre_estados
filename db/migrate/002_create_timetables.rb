class CreateTimetables < ActiveRecord::Migration
  def self.up
    create_table :tee_timetables do |t|
    	t.column :project_id, :integer, :null => false
    	t.column :start_date, :datetime, :null => false
    	t.column :end_date, :datetime, :null => false
    end

    create_table :tee_timetable_journals do |t|
      t.column :tee_timetable_id, :integer
      t.column :week_day, :integer
      t.column :start_time, :datetime
      t.column :end_time, :datetime
      t.column :workable, :boolean
    end

    create_table :roles_tee_timetables do |t|
      t.column :tee_timetable_id, :integer
      t.column :role_id, :integer
    end
  end

  def self.down
    drop_table :tee_timetables
    drop_table :tee_timetable_journals
    drop_table :roles_tee_timetables
  end
end