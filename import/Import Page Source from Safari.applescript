tell application "Safari"
	activate
	set theHTML to source of document 1
	tell application "Receipts Space"
		import theHTML type html
	end tell
end tell