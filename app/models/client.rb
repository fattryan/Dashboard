class Client < ActiveRecord::Base
 
  has_many:quaters
  has_attached_file :photo, :styles => { :small => "50x50#"}
  
  # Automatically calculate age of client based on birthday year entry field
   before_save :client_age

   def client_age
     self.client_age = Time.now.year-self.birthday.year
   end
  
end
