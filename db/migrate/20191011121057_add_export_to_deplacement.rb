class AddExportToDeplacement < ActiveRecord::Migration[5.0]
  def change
    add_column :deplacements, :export, :string
  end
end
