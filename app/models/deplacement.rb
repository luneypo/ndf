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
  has_one :diver, dependent: :destroy
  accepts_nested_attributes_for :diver

  validates :title, presence: true
  validates :date, presence: true
  validates :vehicule, presence: true
  validates :nombrekm,numericality: { greater_than_or_equal_to: 0 }
  validates :gasoil,numericality: { greater_than_or_equal_to: 0 }
  validates :peage,numericality: { greater_than_or_equal_to: 0 }
  validates :parking,numericality: { greater_than_or_equal_to: 0 }


  def total
    @total=0
    if tauxkm?
      @total+=tauxkm*nombrekm
    else
      @total+=gasoil
    end
    unless diver.nil?
      @total+=diver.montant
    end
    @total+=peage+parking
  end

  def self.to_csv
    CSV.generate do |csv|
      columns = %w(name gasoil peage parking montantkm)
      csv << columns.map(&:humanize)
      all.each do |deplacement|
        csv << deplacement.attributes.values_at(*columns)
      end
    end
  end

  def montantkm
    tauxkm*nombrekm
  end
end
