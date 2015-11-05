class AddOperatorForUmsLogs < ActiveRecord::Migration
  def change
  	add_column :ums_logs , :operator, :string
  	add_column :ums_logs , :model_class, :string  	
  	add_column :ums_logs , :model_id, :integer
  end
end
