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

class Diver < ApplicationRecord
  belongs_to :deplacement,optional: true

  # validates :info, presence: true
  # validates :montant, presence: true
end
