class Pastebin < ActiveRecord::Base
	#	============================================
	#	What can be accessed by other classes
	#	============================================
	attr_accessible :url, :content
	
	
	#	============================================
	#	Relations with other classes
	#	============================================
	#belongs_to :user
	
	
	#	============================================
	#	validations
	#	============================================
	#	validates length of pastebin name in URL from 1 - 50
	validates_length_of :url, :minimum => 1, :message => "Pastebin name too short"
	validates_length_of :url, :maximum => 50, :message => "Pastebin name too long"
	
	#	content of pastebin must have at least one character
	validates_length_of :content, :minimum => 1, :message => "Pastebin content missing"
	
end
