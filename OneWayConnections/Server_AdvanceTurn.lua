
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	--result GameOrderAttackTransferResult
	--order GameOrderAttackTransfer
    if (order.proxyType == 'GameOrderAttackTransfer') then
		removedconns = stringtotable(Mod.Settings.RemovedConnections);
		local num = 1;
		local Match = false;
		local Fromterrname = string.upper(game.Map.Territories[order.From].Name);
		local Toterrname = string.upper(game.Map.Territories[order.To].Name);
		while(num < Mod.Settings.TotalRemovedConnections*2 and Match == false)do
			if(removedconns[num] ~=nil)then
				print(removedconns[num].ID);
				if(string.upper(removedconns[num]) == Fromterrname and string.upper(removedconns[num+1]) == Toterrname)then
					Match = true;
					skipThisOrder(WL.ModOrderControl.Skip);
				end
			end
			num = num + 2;
		end
	end
end
function stringtotable(variable)
	local chartable = {};
	local Aufrufe = 0;
	while(string.len(variable)>0)do
		chartable[tablelength(chartable)] = string.sub(variable, 1 , 1);
		variable = string.sub(variable, 2);
		Aufrufe = Aufrufe +1;
	end
	if(Aufrufe > 2)then
		print(newtable[tablepos].ID);--causes a bug to so if the while codelines are only called once cause print dont work in multiplayer
	end
	local newtable = {};
	local tablepos = 0;
	for _, elem in pairs(chartable)do
		if(elem == ",")then
			print(newtable[tablepos].ID);
			tablepos = tablepos + 1;
			newtable[tablepos] = "";
		else
			if(elem == nil)then
				print(newtable[tablepos].ID);--causes  an error to see if elem is empty cause print dont work in multiplayer
			end
			print('Test');
			print(newtable[tablepos].ID);--causes an error to see if it comes to this line cause print dont work in multiplayer
			if(newtable[tablepos] == nil)then
				newtable[tablepos] = elem;
			else
				newtable[tablepos] = newtable[tablepos] .. elem;
			end
		end
	end
	return newtable;
end
function tablelength(T)
	local count = 0;
	for _ in pairs(T) do count = count + 1 end;
	return count;
end
