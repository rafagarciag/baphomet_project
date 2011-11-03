class PastebinController < ApplicationController

	#This method will create a new pastebin getting the name from the URL
	#GET root/name 
	def create
	
		#must validate the integrity of url to prevent sql injection attacks
		name = params[:name]
		
		if Pastebin.find_by_url(name).nil?
			#create the new pastebin
			@pastebin = Pastebin.new
			@pastebin.url = name
			@pastebin.content = "testing"
			
			#if everything goes perfectly smooth...
			if @pastebin.save
				@message = "Creating new pastebin #{name}"
			else
				@message = "Error while creating new pastebin"
			end
			
			
		else
			#display the pastebin to edit
			@message = "You are editing someone elses pastebin"
		end
		
	end
end
