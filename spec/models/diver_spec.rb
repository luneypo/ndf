# == Schema Information
#
# Table name: divers
#
#  id             :integer          not null, primary key
#  info           :string(255)
#  montant        :float(24)
#  deplacement_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Diver, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
