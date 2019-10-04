module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    field :users, [Types::UserType], null: false

    field :user,Types::UserType, null: false do
      argument :id, ID, required: true
    end
    # They will be entry points for queries on your schema.
    def users
      User.all
    end
    def user(id:)
      User.find(id)
    end
  end
end
