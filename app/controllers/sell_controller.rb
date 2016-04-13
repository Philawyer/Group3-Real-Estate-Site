#   Creator: Daniel Swain
#   Date created: 05/04/2016
#   
#   Controller Actions:
# 		* index: show the main sell page /sell
# 		* new: create a new property /sell/new
# 		* create: the POST call to /sell upon successful property
# 		* edit: return a html form to edit the property post
# 		* update: update the property post
# 		* destroy: delete the property.
# 	
# 	To do:
# 		complete actions
# 		Connect to actual database

class SellController < ApplicationController

	# Show the main sell page view
	# GET /sell
	def index
		# For testing, I've set user has property to true and have some fake properties in the sqlite database
		user_has_property = true
		if user_has_property
			# Grab the listings
			@listings = Listing.order(:created_at).page(params[:page])
			# grab the counts (currently separate from listing, likely to change)
			@counts = {
				unhide: [450, "Views"],
				star: [30, "Favourites"],
				comments: [5, "Comments"],
				wait: [6, "Weeks Until Expired"]
			}
			# grab the status (all the same). Need to actually grab the listings statuses.
			@status = "Home open Saturday 10am - 12pm"
			# Render the manage template
			render "sell/manage"
		else
			# No properties so render the index template
			render "sell/index"
		end
	end

	# Show the add/edit form ready for user input and adding a new property
	# GET /sell/new
	def new
		# Add logic for new stuff
		# For testing, I'm passing fake property data
		@property = {
			id: 1,
			address: "21 Shackles Street, Suburbia, Stateland",
			status: "Home open Saturday 10am - 12pm",
			images: ["300x300.png","300x300.png","300x300.png","300x300.png","300x300.png","300x300.png","300x300.png","300x300.png","300x300.png","300x300.png"],
			description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
			counts: {
				unhide: [450, "Views"],
				star: [30, "Favourites"],
				comments: [5, "Comments"],
				wait: [6, "Weeks Until Expired"]
			}
		}
		
		render "sell/add_edit"
	end

	# Add the property from the completed userform
	# POST /sell
	def create
		redirect_to action: :index
	end

	# Show the add/edit form ready for user input to edit an existing property
	# GET /sell/:id/edit
	def edit
		# For testing, I'm passing fake property data
		@property = {
			id: 1,
			address: "21 Shackles Street, Suburbia, Stateland",
			status: "Home open Saturday 10am - 12pm",
			images: ["300x300.png","300x300.png","300x300.png","300x300.png","300x300.png","300x300.png","300x300.png","300x300.png","300x300.png","300x300.png"],
			description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
			counts: {
				unhide: [450, "Views"],
				star: [30, "Favourites"],
				comments: [5, "Comments"],
				wait: [6, "Weeks Until Expired"]
			}
		}
		
		render "sell/add_edit"
	end

	# Update the property from the completed userform
	# PATCH/PUT /sell/:id
	def update
		redirect_to action: :index
	end

	# Delete the selected property from the database
	# DELETE /sell/:id/
	def destroy
		redirect_to action: :index
	end
end
