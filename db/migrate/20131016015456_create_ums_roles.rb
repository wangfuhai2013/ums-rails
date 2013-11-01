class CreateUmsRoles < ActiveRecord::Migration
  def change
    create_table :ums_roles do |t|
      t.string :name

      t.timestamps
    end
  end
end
