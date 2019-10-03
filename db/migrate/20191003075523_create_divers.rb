class CreateDivers < ActiveRecord::Migration[5.0]
  def change
    create_table :divers do |t|
      t.string :info
      t.float :montant
      t.references :deplacement, foreign_key: true

      t.timestamps
    end
  end
end
