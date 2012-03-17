# Ruby

# A mysql-table representing Users
# +-----------------------+--------------+------+-----+
# | Field                 | Type         | Null | Key |
# +-----------------------+--------------+------+-----+
# | id                    | int(11)      | NO   | PRI |
# | login                 | varchar(40)  | YES  |     |
# | email                 | varchar(100) | YES  |     |
# +-----------------------+--------------+------+-----+

class User < ActiveRecord::Base
end

# Note that the method find_by_email is dynamically 
# available based on fields in database.
user = User.find_by_email("daniel@sykewarrior.com")
puts user.email # => prints "daniel@sykewarrior.com"


