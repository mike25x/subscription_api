class User < ActiveRecord::Base
 	
 	before_save :encrypt_password

 	has_many :subscription
 	attr_accessor :password

	def self.authenticate(email, password)
	    user = User.find_by(email:email)
	    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
	      user
	    else
	      nil
	    end
  	end

  	def encrypt_password
	    if password.present?
	      self.password_salt = BCrypt::Engine.generate_salt
	      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
	    end
  	end
end
