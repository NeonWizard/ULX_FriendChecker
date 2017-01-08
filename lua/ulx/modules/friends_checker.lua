function ulx.checkFriends(caller, target_player)
	http.Fetch("http://wizardlywonders.xyz:3005/steam-friends-list/?steamid=" .. target_player:SteamID64(),
		function(body, len, headers, code) 
			local friendsList = util.JSONToTable(body)
			if (code == 401) then
				caller:ChatPrint("Could not access player's friend list!")
				return
			end

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
			caller:ChatPrint("The request failed - " .. error)
		end
	)
end
