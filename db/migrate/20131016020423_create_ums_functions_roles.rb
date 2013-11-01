class CreateUmsFunctionsRoles < ActiveRecord::Migration
  def change
    create_table :ums_functions_roles do |t|
      t.references :function, index: true
      t.references :role, index: true
    end
  end
end
