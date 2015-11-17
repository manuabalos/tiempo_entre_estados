class CreatePrs < ActiveRecord::Migration
  def self.up
    create_table :prs do |t|
    	t.column :project_id, :integer, :null => false
    	t.column :role_id, :integer, :null => false
    	t.column :status_id, :integer, :null => false
    	t.column :type, :boolean
    end
  end

  def self.down
    drop_table :prs
  end
end