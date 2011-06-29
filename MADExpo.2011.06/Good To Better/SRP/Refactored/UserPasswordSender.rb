require_relative("Person")
require_relative("UserProvider")
require("net/smtp")

class UserPasswordSender

  def send_user_password(userId)
    begin
      user = UserProvider.user_get(userId)
      Net::SMTP.start('localhost') do |smtp|
        msgstr = <<EOF
From: kevin.jones@thycotic.com
To: kevin.jones@thycotic.com
Subject: Your Password

Here is your password: blah
EOF
        smtp.send_message msgstr, "system@abccorp.org", user.email_address
      end
    rescue
      puts "Oh noes! Something went wrong!"
      raise
    end
  end
end