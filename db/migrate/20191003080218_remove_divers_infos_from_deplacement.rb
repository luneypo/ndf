class RemoveDiversInfosFromDeplacement < ActiveRecord::Migration[5.0]
  def change
    remove_column :deplacements, :divers, :integer
  end
end
