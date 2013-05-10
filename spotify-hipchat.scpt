tell application "Spotify"
	set current_track to null
	set current_artist to null
	set current_album to null
	
	repeat until application "Spotify" is not running
		set track_name to name of current track
		set track_artist to artist of current track
		set track_album to album of current track
		
		if track_name ≠ current_track then
			set current_track to name of current track
			set current_artist to artist of current track
			set current_album to album of current track
			
			set current_uri to spotify url of current track
			set AppleScript's text item delimiters to "spotify:"
			set current_url to text item 2 of current_uri
			
			set message to "♪ is listening to " & current_artist & " --  " & current_track & " --  " & " (spotify://" & current_url & ")"
			
			set message to do shell script "echo " & quoted form of message & " | sed 's/'\\''//g' | sed 's/'\\&'/'and'/g'"
			
			do shell script "curl -sS -d 'message_format=text&auth_token=AUTHTOKEN&room_id=ROOMID&from=PERSONNAME&color=yellow&message=" & message & "' https://api.hipchat.com/v1/rooms/message"
			
		end if
		
		delay 10
	end repeat
end tell
