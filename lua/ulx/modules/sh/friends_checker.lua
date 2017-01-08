local checkFriends = ulx.command("Friend Checker", "ulx checkfriends", ulx.checkFriends, "!checkfriends")
checkFriends:addParam({ type = ULib.cmds.PlayerArg })
checkFriends:defaultAccess(ULib.ACCESS_ADMIN)
checkFriends:help("List player's friends that are currently on the server.")
