(* This script copies the current selection to the clipboard as Markdown formatted text. *)

property prefix : "- "
property lineBreakSequence : "  
"

tell application "OmniFocus"
	tell front document
		tell content of document window 1
			set theSelectedItems to value of every selected tree
			if ((count of theSelectedItems) < 1) then
				display alert "You must first select an item to copy." as warning
				return
			end if
			set listItems to {}
			repeat with anItem in theSelectedItems
				if class of anItem is task or class of anItem is inbox task or class of anItem is project
					if completed of anItem is true then
						set listItem to prefix & "<strike>" & name of anItem & "</strike>"
					else
						set listItem to prefix & name of anItem
					end if
					-- See if there is a note for this item
					if not note of anItem is "" then
						set listItem to listItem & lineBreakSequence & note of anItem
					end if
					-- Add this item to the list
					set listItems to listItems & listItem
				end if
			end repeat
			set AppleScript's text item delimiters to "
"
			--Set to the clipboard
			set the clipboard to listItems as string
			set AppleScript's text item delimiters to ""
		end tell
	end tell
end tell
