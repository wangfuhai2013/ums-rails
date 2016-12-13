class Ums::User < ActiveRecord::Base
  belongs_to :role

  validates_presence_of :account,:role
  validates_uniqueness_of :account,:name

  validate :password_non_blank

  belongs_to :created_by, class_name: "Ums::User"
  belongs_to :updated_by, class_name: "Ums::User"

  before_validation :record_operator

    #记录操作人员
    def record_operator
      if self.respond_to?(:session) && session[:user_id]
        self.created_by_id = session[:user_id] if new_record?
        self.updated_by_id = session[:user_id]
      end
    end

    def self.authenticate(account,password)
    	user = self.find_by_account(account)
    	if user
      	expected_password = encrypted_password(password,user.salt)
        #logger.debug("user.hashed_password:" + user.hashed_password + ",expected_password:" + expected_password)
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
    Digest::SHA2.hexdigest(password.to_s + slat.to_s)    
	end
	def create_salt
	    self.salt =  rand.to_s
	end
end
