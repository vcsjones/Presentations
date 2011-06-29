class Person
  attr_accessor :first_name, :last_name, :email_address, :password

  def initialize(first_name, last_name, email_address)
    @first_name = first_name
    @last_name =last_name
    @email_address = email_address
  end
end