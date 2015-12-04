class CreateHolydays < ActiveRecord::Migration
  def self.up
    create_table :tee_holydays do |t|
      t.column :name, :string, :null => false
	  t.column :project_id, :integer, :null => false
      t.column :date, :text
    end

    create_table :roles_tee_holydays do |t|
      t.column :tee_holyday_id, :integer
      t.column :role_id, :integer
    end
  end

  def self.down
    drop_table :tee_holydays
    drop_table :roles_tee_holydays
  end
end