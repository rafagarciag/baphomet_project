class PastebinController < ApplicationController

	#This method will create a new pastebin getting the name from the URL
	#In case its an alread existing pastebin, you can edit
	#GET root/name 
	def create
	
		#must validate the integrity of url to prevent sql injection attacks
		name = params[:name]
		if Pastebin.find_by_url(name).nil?
			#create the new pastebin
			@pastebin = Pastebin.new
			@pastebin.url = name
			@pastebin.content = "BLANK"

			#if everything goes perfectly smooth...
			if @pastebin.save
				@message = "Creating new pastebin #{name}"
			else
				@message = "Error while creating new pastebin"
			end
			
		#Edit method
		else
			@pastebin = Pastebin.find_by_url(name)
			@message = "You are editing someone elses pastebin #{name}"
		end
		
	end

	def update

		@pastebin = Pastebin.find(params[:id]) 
		
		respond_to do |format|
			if @pastebin.update_attributes(params[:pastebin])
				format.html { redirect_to :action => 'create', :name => @pastebin['url'] }
			else
				@message = "Error updating." 
				format.html {redirect_to :action => 'create', :name => @pastebin['url'] }
			end
		end
	end
	
end
