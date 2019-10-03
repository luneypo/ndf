# == Schema Information
#
# Table name: deplacements
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  date        :date
#  title       :string(255)
#  vehicule_id :integer
#  tauxkm      :float(24)
#  nombrekm    :integer
#  gasoil      :float(24)
#  peage       :float(24)
#  parking     :float(24)
#  infos       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  Valider     :boolean
#  diver_id    :integer
#

class Deplacement < ApplicationRecord
  belongs_to :user
  belongs_to :vehicule
  has_one :diver
  accepts_nested_attributes_for :diver

  validates :title, presence: true
  validates :date, presence: true

  def total
    if tauxkm?
      @total=tauxkm*nombrekm
    else
      @total=gasoil
    end
    unless diver.nil?
      @total=@total+diver.montant
    end
    @total=@total+peage+parking
  end
end
