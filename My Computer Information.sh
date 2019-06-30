#!/bin/bash

#Custom Variables
itNumber="867-5309"

#Gets necessary info
computerName=`scutil --get ComputerName`
#username=`defaults read /Library/Preferences/com.apple.loginwindow.plist lastUserName`
username="$(/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }')"
ipAddress=`ifconfig | grep inet | grep -v inet6 | grep -v 127.0.0.1 | awk '{print $2}' | tr '
' ' '`

#Compiles the information string
info="Computer Name: $computerName
Username: $username
IP Address: $ipAddress
Call $itNumber for Tech Support"

#Copies Computer Info to clipboard
osascript -e "set the clipboard to \"$info\""

#Uses jamf helper to display a dialog of user information. The helper uses the standard Self Service icon when displaying
/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper \
-windowType hud -heading "My Computer Information" -description "$info" -button1 "OK" \
-icon /Applications/Self\ Service.app/Contents/Resources/AppIcon.icns -defaultButton 1 -lockHUD
