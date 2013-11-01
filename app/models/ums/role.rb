class Ums::Role < ActiveRecord::Base
	has_and_belongs_to_many :functions
	validates_presence_of :name
end