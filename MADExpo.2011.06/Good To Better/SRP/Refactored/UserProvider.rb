require_relative("Person")

module UserProvider
    def UserProvider.user_get(user_id)
      return Person.new("Kevin", "Jones", user_id)
    end
end