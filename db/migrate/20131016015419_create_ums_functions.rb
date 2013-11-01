class CreateUmsFunctions < ActiveRecord::Migration
  def change
    create_table :ums_functions do |t|
      t.string :name
      t.string :controller
      t.string :action

      t.timestamps
    end
  end
end
