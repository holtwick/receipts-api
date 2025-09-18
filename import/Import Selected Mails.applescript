tell application "Mail"
	set theMessages to the selected messages of message viewer 0
	repeat with this_message in theMessages
		try
			tell this_message
				# set background color of this_message to none		
				set thisSource to get (source of this_message)
				tell application "Receipts Space"
					import thisSource type mail
				end tell
			end tell
		end try
	end repeat
end tell
