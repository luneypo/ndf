class AddDiverToDeplacements < ActiveRecord::Migration[5.0]
  def change
    add_reference :deplacements, :diver, foreign_key: true
  end
end
