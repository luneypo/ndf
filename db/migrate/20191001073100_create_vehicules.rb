class CreateVehicules < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicules do |t|
      t.string :immatriculation
      t.float :tauxkm

      t.timestamps
    end
  end
end
