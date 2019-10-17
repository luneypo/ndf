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
  validates :tauxkm, presence: true
  validates :nombrekm, presence: true
  validates :peage, presence: true
  validates :parking, presence: true
  validates :gasoil, presence: true


  def total
    @total=0
    if tauxkm == 0
      @total+=gasoil
    else
      @total+=tauxkm*nombrekm
    end
    unless diver.nil?
      @total+=diver.montant
    end
    @total+=peage+parking
  end

  def self.to_csv
    attributes = %w(date fullname credit_salarie debit_carburant debit_peage debit_parking debit_divers debit_kil TVA)
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end

  end

  def fullname
    "#{user.name} #{user.first_name}"
  end

  def credit_salarie
    total=gasoil+peage+parking+(tauxkm*nombrekm)
    if diver
      total+=diver.montant
    end
    total
  end

  def debit_carburant
    (gasoil*80)/100
  end

  def debit_peage
    (peage*80)/100
  end

  def debit_parking
    (parking*80)/100
  end

  def debit_divers
    if diver
      diver.montant
    end
  end

  def debit_kil
    tauxkm*nombrekm
  end

  def TVA
    (gasoil*20+parking*20+peage*20)/100
  end
end
