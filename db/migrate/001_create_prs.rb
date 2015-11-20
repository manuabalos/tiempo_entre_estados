class CreatePrs < ActiveRecord::Migration
  def self.up
    create_table :tee_prs do |t|
    	t.column :project_id, :integer, :null => false
    	t.column :role_id, :integer, :null => false
    	t.column :status_id, :integer, :null => false
    	t.column :status_type, :string
    end
  end

  def self.down
    drop_table :tee_prs
  end
end