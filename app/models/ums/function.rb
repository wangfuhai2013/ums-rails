class Ums::Function < ActiveRecord::Base
	has_and_belongs_to_many :roles
    validates_presence_of :name
    validates_presence_of :controller
    validates_uniqueness_of :name
end
