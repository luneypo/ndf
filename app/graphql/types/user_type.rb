module Types
  class UserType < Types::BaseObject
    field :email, String, null: true
    field :name, String, null: true
    field :first_name, String, null: true
    field :login, String, null: true
    field :admin, Boolean, null: true
  end
end
