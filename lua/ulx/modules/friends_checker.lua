function ulx.checkFriends(caller, target_player)
	http.Fetch("https://api.steampowered.com/ISteamUser/GetFriendList/v1/?key=2E13692A3A02D5BCE96337CB82FF1F54&steamid=" .. target_player:SteamID64() .. "&relationship=friend",
		function(body, len, headers, code) 
			local friendsJson = util.JSONToTable(body)
			if (code == 401) then
				caller:ChatPrint("Could not access player's friend list!")
				return
			end

			local friendsList = friendsJson["friendslist"]["friends"]

			local friendsFoundOnServer = {}

			for i, ply in ipairs(player.GetAll()) do
				local server_steamid = ply:SteamID64()
				for i2, friendinfo in ipairs(friendsList) do
					local friend_steamid = friendinfo["steamid"]
					if (server_steamid == friend_steamid) then
						friendsFoundOnServer[#friendsFoundOnServer + 1] = ply:GetName()
					end
				end
			end
			caller:ChatPrint(target_player:GetName() .. "'s friends online: " .. table.concat(friendsFoundOnServer, ", "))
		end,
		function(error)
			caller:ChatPrint("The request failed.")
		end
	)
end
