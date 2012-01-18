class HomeController < ApplicationController
	
	#Home page
	def index
		#Code for home page
		@message = "THE FUTURE OF PASTEBINS IS HERE"
		@pastebin = Pastebin.new
	end
end
