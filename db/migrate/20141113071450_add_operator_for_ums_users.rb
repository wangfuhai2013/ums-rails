class AddOperatorForUmsUsers < ActiveRecord::Migration
  def change
  	 add_column :ums_users , :created_by_id, :integer
  	 add_column :ums_users , :updated_by_id, :integer
  	 add_column :ums_functions , :created_by_id, :integer
  	 add_column :ums_functions , :updated_by_id, :integer
  	 add_column :ums_roles , :created_by_id, :integer
  	 add_column :ums_roles , :updated_by_id, :integer  	   	 
  end
end
