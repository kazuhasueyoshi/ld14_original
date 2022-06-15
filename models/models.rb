ActiveRecord::Base.establish_connection
class User < ActiveRecord::Base
    has_many :chatrooms, through: :participants
    has_many :participants
    has_many :messages
    has_many :contents
    has_many :comment
    has_secure_password
end

class Student < ActiveRecord::Base
     
end

class Univstudent < ActiveRecord::Base
    
end

class Chatroom < ActiveRecord::Base
    has_many :users, through: :participants
    has_many :participants
    has_many :messages
end

class Participant < ActiveRecord::Base
    belongs_to :user
    belongs_to :chatroom
end

class Message < ActiveRecord::Base
    belongs_to :user
    belongs_to :chatroom
end

class Content < ActiveRecord::Base
    belongs_to :user
end

class Comment < ActiveRecord::Base
    belongs_to :user
end