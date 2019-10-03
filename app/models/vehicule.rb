# == Schema Information
#
# Table name: vehicules
#
#  id              :integer          not null, primary key
#  immatriculation :string(255)
#  tauxkm          :float(24)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Vehicule < ApplicationRecord

  has_many :deplacements

  validates :immatriculation, presence: true, uniqueness: true
  validates :tauxkm, presence: true, allow_blank: true
end
