ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

ESX.RegisterServerCallback('Menu-Props:getUsergroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	print(GetPlayerName(source).." - "..group)
    cb(group)
end)