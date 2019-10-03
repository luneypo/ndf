class AddValiderToDeplacements < ActiveRecord::Migration[5.0]
  def change
    add_column :deplacements, :valider, :boolean
  end
end
