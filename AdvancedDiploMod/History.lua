function ShowHistory(datentable,game,ende)
	local daten = "";
	for _,data in pairs(datentable)do
		local teildaten = "";
		if(data.Type == 1)then
			if(data.S1 == game.Us.ID)then
				teildaten = "You declared war on " .. getname(data.S2,game);
			end
			if(data.S2 == game.Us.ID)then
				teildaten = getname(data.S1,game) .. " declared war on you";
			end
			if(data.S1 ~= game.Us.ID and data.S2 ~= game.Us.ID)then
				teildaten = getname(data.S1,game) .. " declared war " .. getname(data.S2,game);
			end
		end
		if(data.Type == 2)then
			teildaten = "You were unable to buy " .. getterrname(data.terrid,game) .. " from " .. getname(data.Von,game) .. " cause he didn't own it, when you tried to buy it";
		end
		if(data.Type == 3)then
			teildaten =  getname(data.Player,game) .. " was unable to buy " .. getterrname(data.terrid,game) .. " from you cause you didn't onwed it at the moment, he tried to buy it";
		end
		if(data.Type == 4)then
			teildaten =  getname(data.Von,game) .. " hasn't " .. tostring(data.Preis) .." to pay you for " .. getterrname(data.terrid,game);
		end
		if(data.Type == 5)then
			teildaten =  "You were unable to buy " .. getterrname(data.terrid,game) .. " from " .. getname(data.Von,game) .. " cause you only had " .. tostring(data.YourMoney) .. " and not the required " .. tostring(data.Preis) .. " money";
		end
		if(data.Type == 6)then
			if(data.Preis == nil)then
				teildaten =  getname(data.buyer,game) .. " bought " .. getterrname(data.terrid,game) .." from " .. getname(data.Von,game);
			else
				if(data.buyer == game.Us.ID)then
					teildaten =  "You bought " .. getterrname(data.terrid,game) .." from " .. getname(data.Von,game) .. " for a price of " .. data.Preis;
				else
					teildaten =  getname(data.buyer,game) .. " bought " .. getterrname(data.terrid,game) .." from you for a price of " .. data.Preis;
				end
			end
		end
		if(data.Type == 7)then
			teildaten =  "You bought " .. tostring(data.Count) .. " armies for " .. getterrname(data.terrid,game) .. ". The total price was " .. tostring(data.Preis);
		end
		if(data.Type == 8)then
			teildaten =  "You declined the territory sell offer from " .. getname(data.Von,game) .. " for the territory " .. getterrname(data.terrid,game);
		end
		if(data.Type == 9)then
			teildaten = getname(data.Revoker,game) .. " declined your territory sell offer for the territory " .. getterrname(data.terrid,game);
		end
		if(data.Type == 10)then
			if(data.Acceptor == game.Us.ID)then
				if(data.Preis ~= 0)then
					teildaten = "You accepted the peace offer " .. getname(data.Von,game) .. " . You have now peace for " .. tostring(data.Duration) .. " Turns. The price for that was just " tostring(data.Preis);
				else
					teildaten = "You accepted the peace offer " .. getname(data.Von,game) .. " . You have now peace for " .. tostring(data.Duration) .. " Turns";
				end
			end
			if(data.Von == game.Us.ID)then
				if(data.Preis ~= 0)then
					teildaten = getname(data.Acceptor,game) .. " accepted your peace offer. You have now peace for " .. tostring(data.Duration) .. " Turns. The price for that was just " tostring(data.Preis);
				else
					teildaten = getname(data.Acceptor,game) .. " accepted your peace offer. You have now peace for " .. tostring(data.Duration) .. " Turns";
				end
			end
			if(data.Acceptor ~= game.Us.ID and data.Von ~= game.Us.ID)then
				teildaten = getname(data.Acceptor,game) .. " and " .. getname(data.Von,game) .. " have now peace for " .. tostring(data.Duration) .. " Turns";
			end
		end
		if(data.Type == 11)then
			if(data.DeclinedBy == game.Us.ID)then
				teildaten =  "You declined the peace offer from " .. getname(data.Von,game);
			else
				teildaten =  getname(data.DeclinedBy,game) .. " declined your peace offer";
			end
		end
		if(data.Type == 12)then
			teildaten =  "The territory sell offer for the territory " .. getterrname(data.terrid,game) .. " by " ..getname(data.Von,game) .. " didn't existed any longer, when you tried to buy it";
		end
		if(data.Type == 13)then
			teildaten =  getname(data.Buyer,game) .. " tried to buy " .. getterrname(data.terrid,game) .. " from you, but you had just " .. tostring(data.YourMoney) .. " of " .. tostring(data.Preis) .. " money";
		end
		if(data.Type == 14)then
			teildaten =  getname(data.Buyer,game) .. " tried to buy " .. getterrname(data.terrid,game) .. " from you, but he hadn't enough money";
		end
		if(teildaten ~= "")then
			daten = daten .. "Turn " .. data.Turn .. ":".. teildaten .. "\n";
		end
	end
	if(daten ~= "")then
		local payload = {};
		payload.Message = "Read";
		game.SendGameCustomMessage("Sending read confirmation...", payload, function(returnvalue)end);
	end
	daten = daten .. ende;
	if(daten ~= "")then
		UI.Alert(daten);
	end
end
function getname(playerid,game)
	print(playerid);
	return game.Game.Players[playerid].DisplayName(nil, false);
end
function getterrname(terrid,game)
	return game.Map.Territories[terrid].Name;
end
function tablelength(T)
	local count = 0;
	for _,elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
