class Ums::Role < ActiveRecord::Base
	has_and_belongs_to_many :functions
	validates_presence_of :name
	validates_uniqueness_of :name

    belongs_to :created_by, class_name: "Ums::User"
    belongs_to :updated_by, class_name: "Ums::User"

	before_create :record_operator
    before_update :record_operator

    #记录操作人员
    def record_operator
      if self.respond_to?(:session) && session[:user_id]
        self.created_by_id = session[:user_id] if new_record?
        self.updated_by_id = session[:user_id]
      end
    end
end
