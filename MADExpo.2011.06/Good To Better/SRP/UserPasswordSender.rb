require_relative("Person")

class UserPasswordSender
  def send_user_password(userId)
    user = Person.new("Kevin", "Jones", "kevin@vcsjones.com") #pretend its a database lookup
    user.send_password()
  end
end