require("net/smtp")

class Person
  def first_name
    @first_name
  end
  def first_name(value)
    @first_name = value
  end

  def last_name
    @last_name
  end

  def last_name(value)
    @last_name = value
  end

  def email_address
    @email_address
  end

  def email_address(value)
    @email_address= value
  end

  def password
    @password
  end

  def password=(value)
    @password = value
  end

  def initialize(first_name, last_name, email_address)
    @first_name = first_name
    @last_name =last_name
    @email_address = email_address
  end

  #NOTE: For people, this is a SAMPLE. Never in a MILLION years should you
  #email someone their original password; or even store it in a way that you
  #can even do this. Hash it, salt it, repeat; use reset codes.
  def send_password()
    begin
      Net::SMTP.start('localhost') do |smtp|
        msgstr = <<EOF
From: kevin.jones@thycotic.com
To: kevin.jones@thycotic.com
Subject: Your Password

Here is your password: blah
EOF
        smtp.send_message msgstr, "system@abccorp.org", @email_address
      end
    rescue
      puts "Oh noes! Something went wrong!"
      raise
    end
  end
end