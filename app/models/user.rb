# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  name                   :string(255)      default(""), not null
#  first_name             :string(255)      default(""), not null
#  admin                  :boolean          default(FALSE)
#  login                  :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord

  has_many :deplacements

  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable

  validates :email, presence: true, uniqueness: true
  validates :login, presence: true, uniqueness: true
  validates :name, presence: true
  validates :first_name, presence: true

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      user = find_by(id: row["id"]) || new
      user.attributes = row.to_hash
      user.temp=user.password=user.password_confirmation=Devise.friendly_token(8)
      user.save!
    end
  end

  def untemp
    self.temp=nil
  end
end
