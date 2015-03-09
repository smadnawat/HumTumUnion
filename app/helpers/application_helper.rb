module ApplicationHelper

 def find_user(uid)  
  User.find_by_id(uid.to_i)
 end

end
