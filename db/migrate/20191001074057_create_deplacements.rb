class CreateDeplacements < ActiveRecord::Migration[5.0]
  def change
    create_table :deplacements do |t|
      t.references :user, foreign_key: true
      t.date :date
      t.string :title
      t.references :vehicule, foreign_key: true
      t.float :tauxkm
      t.integer :nombrekm
      t.float :gasoil
      t.float :peage
      t.float :parking
      t.integer :divers
      t.string :infos

      t.timestamps
    end
  end
end
