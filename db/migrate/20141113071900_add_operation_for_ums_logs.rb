class AddOperationForUmsLogs < ActiveRecord::Migration
  def change
  	add_column :ums_logs , :operator, :string
  	add_column :ums_logs , :model_name, :string  	
  	add_column :ums_logs , :model_id, :integer
  end
end
