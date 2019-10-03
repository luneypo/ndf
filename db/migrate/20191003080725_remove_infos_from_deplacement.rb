class RemoveInfosFromDeplacement < ActiveRecord::Migration[5.0]
  def change
    remove_column :deplacements, :infos, :string
  end
end
