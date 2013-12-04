class Ums::User < ActiveRecord::Base
  belongs_to :role

  validates_presence_of :name,:role
  validates_uniqueness_of :name

  validate :password_non_blank


    def self.authenticate(name,password)
    	user = self.find_by_name(name)
    	if user
      	expected_password = encrypted_password(password,user.salt)
      	if user.hashed_password != expected_password || !user.is_enabled
      		user = nil    		
      	end
      end
      user
    end
    
    def verify_password(password)
      expected_password = Ums::User.encrypted_password(password,self.salt)
      logger.debug("expected_password:"+expected_password+",hashed_password:"+self.hashed_password)
      if self.hashed_password == expected_password
        true       
      else
        false
      end
    end

    def password
    	@password
    end

	def password=(pwd)
		@password = pwd
		return if pwd.blank?
		create_salt
		self.hashed_password = Ums::User.encrypted_password(pwd,self.salt)
	end
  
  def as_json options=nil
    options ||= {}
    options[:except] = [:hashed_password,:salt]
    super options
  end

	private
	def password_non_blank
		errors.add(:password,"missing password") if hashed_password.blank?
		
	end
	def self.encrypted_password(password,slat)
		Digest::SHA1.hexdigest(password+slat)
	end
	def create_salt
	    self.salt =  rand.to_s
	end
end
