-- TMA
--
-- You don't need this code server-side if all you're gonna do is blow the vehicle. That just adds CPU time
-- when it's not needed - I have changed and moved the code into the client.


--[[			NOT USED



function start ()
setTimer(arena, 1000, 0)
end

addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), start )

function arena()
	for i,player in ipairs(getElementsByType('player')) do
		killx, killy, killz = getElementPosition(player)
		if killz < 1050 or killz > 1250 or killx < 2930 or killx > 3130 or killy < 3600 or killy > 3800 then
			pojazd = getPedOccupiedVehicle(player)
			blowVehicle ( pojazd )
		end
	end
end
--]]