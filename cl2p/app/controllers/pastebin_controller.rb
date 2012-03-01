class PastebinController < ApplicationController

	#This method will create a new pastebin getting the name from the URL
	#In case its an alread existing pastebin, you can edit
	#GET root/name 
	def create
	
		#must validate the integrity of url to prevent sql injection attacks
		name = params[:name]
		
		#Remove spaces
		name.strip!
		#Change spaces by underscores
		name.gsub!(" ","_")
		#Remove unwanted characters
		name.gsub!(/[^a-zA-Z0-9_]/)
		
		if Pastebin.find_by_url(name).nil?
			#create the new pastebin
			@pastebin = Pastebin.new
			@pastebin.url = name
			@pastebin.content = "\n\n"

			#if everything goes perfectly smooth...
			if @pastebin.save
				@message = "Creating new pastebin #{name}"
				#validates the homepage creation of a pastebin, which uses a special /new/:new route.
				#while it would work without the following code, the route displayed on the browser would be /new/n
				#and not /:name as it should be. So do not erase the following code!
				if !params[:new].nil?
					respond_to do |format|
						format.html { redirect_to :action => 'create', :name => params[:name] }
						format.json { render json => @pastebin }
					end
				end
			else
				@message = "Error while creating new pastebin"
				respond_to do |format|
					format.html { redirect_to :action=>'index', :controller=>'home' }
				end
			end
			
		#Edit method
		else
			@pastebin = Pastebin.find_by_url(name)
			@message = "#{name}"
		end

		
	end

	def update

		@pastebin = Pastebin.find(params[:id]) 

		respond_to do |format|
			if @pastebin.update_attributes(params[:pastebin])
				if @pastebin.user_id.nil? && ( !@pastebin.visible || !@pastebin.editable )
					@pastebin.update_attributes(:user_id => params[:userId])
				elsif !@pastebin.user_id.nil? && @pastebin.visible && @pastebin.editable 
					@pastebin.update_attributes(:user_id => nil)					
				end
				format.html { redirect_to :action => 'create', :name => @pastebin['url'] }
				format.json { head :no_content }
			else
				@message = "Error updating." 
				format.html {redirect_to :action => 'create', :name => @pastebin['url'] }
			end
		end
	end
	
end
