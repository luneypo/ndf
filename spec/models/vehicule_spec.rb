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

require 'rails_helper'

RSpec.describe Vehicule, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
