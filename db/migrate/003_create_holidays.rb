class CreateHolidays < ActiveRecord::Migration
  def self.up
    create_table :tee_holidays do |t|
      t.column :name, :string, :null => false
	    t.column :project_id, :integer, :null => false
      t.column :date, :text
    end

    create_table :roles_tee_holidays do |t|
      t.column :tee_holiday_id, :integer
      t.column :role_id, :integer
    end
  end

  def self.down
    drop_table :tee_holidays
    drop_table :roles_tee_holidays
  end
end