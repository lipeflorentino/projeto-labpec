class DropTypesTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :types
  end
end
