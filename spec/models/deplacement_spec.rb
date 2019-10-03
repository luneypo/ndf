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

require 'rails_helper'

RSpec.describe Deplacement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
