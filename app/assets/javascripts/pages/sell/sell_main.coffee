# Created: Daniel Swain
# Date: 05/04/2016
# 
# The following coffeescript are for the main sales pages.
# 
# Todo:

# Function containing all javascript needed on page load for the manage page and index page
ready = ->
	#--------- Sort Dropdown Code
	# Sort dropdown for manage page, combo action replaces previous elements text with selection from dropdown
	$('#manage-filter').dropdown()

	# Handle the sort change via the update_sort Ajax action in sell_controller
	$('#manage-filter').change ->
		# Get the sort value from the dropdown
		selected_item = parseInt($('#manage-filter :selected').val())
		# Get the filter method and send that through (in case the user has changed from 'desc' to 'asc' and wants to change the sort type)
		filter_method = $('#manage-filter-method').data 'filter-method'
		# Now we have the sort method, lets send this to our sell controller to handle the sort and update the view
		# There's no success handler as it's done by manage.js.erb
		$.ajax
			type: 'POST'
			url: '/update-sort'
			data:
				_method: 'PUT'
				listing_filter: selected_item
				listing_filter_method: filter_method

	# Change the filter method form descending to ascending when clicked, but only if a filter choice is chosen
	$('#manage-filter-method').click ->
		# Get the selected_item and current filter method (shown on the button as an icon)
		selected_item = $('#manage-filter :selected').val()
		filter_method = $('#manage-filter-method').data 'filter-method'
		# Check for selection
		if !selected_item
			# No selection made so lets notify the user
			alert 'Please select a sorting option and try again.'
		else
			# The user has chosen a sorting option so lets send this through to the update-sort method
			# Get an integer from the selected item
			selected_item = parseInt(selected_item)
			# Change the filter method data value to the other type and change the icon
			if filter_method == 'desc'
				$('#manage-filter-method').data 'filter-method', 'asc'
				$('#manage-filter-method i').addClass('ascending')
				$('#manage-filter-method i').removeClass('descending')
				# Change the filter method to the oposite of what was on the button (the user clicking the button wants to change the filter method from what is listed)
				filter_method = 'asc'
			else
				$('#manage-filter-method').data 'filter-method', 'desc'
				$('#manage-filter-method i').addClass('descending')
				$('#manage-filter-method i').removeClass('ascending')
				# Change the filter method to the oposite of what was on the button (the user clicking the button wants to change the filter method from what is listed)
				filter_method = 'desc'
			# Send an ajax call to update the sort methodology
			$.ajax
				type: 'POST'
				url: '/update-sort'
				data:
					_method: 'PUT'
					listing_filter: selected_item
					listing_filter_method: filter_method
					listing_filter_reset: 'true'
				success: (response) ->
					# Blur the button on successful filter so it doesn't remain focused/in an active state
					$('#manage-filter-method').blur()

	#--------- Sticky Code
	# No longer using the semantic Sticky method, but using the visibility fixed method as this works better when the page content is small
	$('.manage-table-header').visibility
		type: 'fixed'
		offset: 60 # Offset = page offset so the header sticks to the bottom of the header when it gets the fixed class applied
	
	# -------- Manage Listing Card Code
	# Popup tooltip for the approval corner label in the manage table cards when you hover over the label
	$('.manage-listing-card #listing-approval-label').popup	hoverable: true

	# Cut of extra large descriptions so they only show the first 500 characters (change max_description_length to use a different max length)
	max_description_length = 500
	@cut_off_description_field = ->
		$('.description-field').each ->
			# Get the text from the description field
			description_text = $(this).text()
			if description_text.length < max_description_length
				# Do nothing as the description field text is less than the specified maximum
				return
			else
				# Slice the extra characters off the end of the description text to the specified lenght and show an elipsis to show it's been truncated
				$(this).html(description_text.slice(0, max_description_length) + '...')
	
	# Call the function on initial page load
	cut_off_description_field()

	return

# Turbolinking only runs the $(document).ready on initial page load. 
# So we need to assign 'ready' to both document.ready and page:load (which is a turboscript thing)
$(document).ready ready
