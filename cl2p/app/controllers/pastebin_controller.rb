class PastebinController < ApplicationController

	#This method will create a new pastebin getting the name from the URL
	#GET root/name 
	def create
	
		#must validate the integrity of url to prevent sql injection attacks
		name = params[:name]
		@nameView = params[:name] #So it can be read in the hidden field in the view, we should check this
		if Pastebin.find_by_url(name).nil?
			#create the new pastebin
			@pastebin = Pastebin.new
			@pastebin.url = name
			@pastebin.content = "testing"
			@contentView = @pastebin.content #So it can be read in the hidden field in the view, we should check this
			
			#if everything goes perfectly smooth...
			if @pastebin.save
				@message = "Creating new pastebin #{name}"
				@idView = @pastebin.id #So it can be read in the hidden field in the view, we should check this
			else
				@message = "Error while creating new pastebin"
			end
			
			
		else
			#display the pastebin to edit
			@pastebin = Pastebin.find_by_url(name)
			@idView = @pastebin.id #So it can be read in the hidden field in the view, we should check this
			@contentView = @pastebin.content #So it can be read in the hidden field in the view, we should check this
			@message = "You are editing someone elses pastebin #{name}"
		end
		
	end

	def update
		@pastebinF = params[:pastebin] #Because @pastebin is not being communicated
		@pastebin = Pastebin.find(@pastebinF['id']) #Because @pastebin is not being communicated
      		if @pastebin.update_attributes(params[:pastebin])
			@message = "Succesfully updated."
		else
			@message = "Error updating."
		end
	end
end
