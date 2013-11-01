class CreateUmsLogs < ActiveRecord::Migration
  def change
    create_table :ums_logs do |t|
      t.string :log_type
      t.string :level
      t.text :data
      t.string :ip

      t.timestamps
    end
  end
end
