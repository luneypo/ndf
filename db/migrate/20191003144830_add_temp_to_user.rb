class AddTempToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :temp, :string
  end
end
