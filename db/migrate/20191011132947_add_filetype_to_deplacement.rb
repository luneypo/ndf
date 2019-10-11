class AddFiletypeToDeplacement < ActiveRecord::Migration[5.0]
  def change
    add_column :deplacements, :filetype, :string
  end
end
