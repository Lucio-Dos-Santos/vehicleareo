-------------made by Sam and Lucio------------
function alert(msg)
	SetTextComponentFormat("STRING")
	AddTextComponentString(msg)
	DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function notify(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(true, false)
end
local point = { ['heading'] = 153.63, ['x'] = -979.06, ['y'] = -2689.05, ['z'] = 13.83 }
local blip = AddBlipForCoord(point.x, point.y, point.z)
local vehSpawned = false
local vehHash = -431692672
SetBlipSprite (blip, 225)
SetBlipDisplay(blip, 4)
SetBlipScale  (blip, 0.9)
SetBlipColour (blip, 3)
SetBlipAsShortRange(blip, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString('Emprunt véhicule')
EndTextCommandSetBlipName(blip)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if not(vehSpawned) then
			DrawMarker(27, point.x, point.y, point.z - 0.99, 0, 0, 0, 0, 0, 0, 3.5, 3.5, 0.5001, 0, 255, 0, 105, 0, 0, 0, 1, 0, 0, 0)
			if testpresence(point, 2.0) and not(vehSpawned) then
				notify("Salut à toi, tu peux emprunter un de nos véhicules gratuitement pour te déplacer")
				alert("~b~Appuie sur ~INPUT_PICKUP~ pour emprunter un véhicule")
				if IsControlJustReleased(1, 38) then
					RequestModel(vehHash)
					local i = 0
					while not(HasModelLoaded(vehHash)) and i<5 do
						Wait(1000)
						i = i +1
					end

					if i>5 then
						print ("Erreur")
					end
					local vehicleareo = CreateVehicle(vehHash, point.x, point.y, point.z, point.heading, true, 1)
					SetPedIntoVehicle(PlayerPedId(), vehicleareo, -1)
					vehSpawned = true

				end
			end
		end
	end
end)	

function testpresence(point, radius)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
	if GetDistanceBetweenCoords(x, y, z, point.x, point.y, point.z, true) <= radius then
		return true
	else
		return false
	end
end
