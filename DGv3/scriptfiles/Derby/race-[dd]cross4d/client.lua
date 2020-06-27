-- TMA Moved this here and added "me"

grawitacja=0
gMe = getLocalPlayer()

function startclient()
	dolpolnoc1 = createMarker ( 3000.0578613281,3749.7817382813,1101.8922119141, "corona", 5, 255, 0, 0, 0)
	dolpolnoc2 = createMarker ( 3033.3041992188,3749.7958984375,1101.9613037109, "corona", 5, 255, 0, 0, 0)
	dolpolnoc3 = createMarker ( 3066.7575683594,3749.7958984375,1101.9484863281, "corona", 5, 255, 0, 0, 0)
	dolwschod1 = createMarker ( 3083.2744140625,3733.125,1101.9022216797, "corona", 5, 255, 0, 0, 0)
	dolwschod2 = createMarker ( 3083.2985839844,3699.7021484375,1101.9022216797, "corona", 5, 255, 0, 0, 0)
	dolwschod3 = createMarker ( 3083.2985839844,3666.3937988281,1101.9022216797, "corona", 5, 255, 0, 0, 0)
	dolpoludnie1 = createMarker ( 3066.5603027344,3649.8029785156,1101.9434814453, "corona", 5, 255, 0, 0, 0)
	dolpoludnie2 = createMarker ( 3033.2299804688,3649.8371582031,1101.8922119141, "corona", 5, 255, 0, 0, 0)
	dolpoludnie3 = createMarker ( 3000.0068359375,3649.8029785156,1101.9486083984, "corona", 5, 255, 0, 0, 0)
	dolzachod1 = createMarker ( 2983.3232421875,3666.5004882813,1101.9022216797, "corona", 5, 255, 0, 0, 0)
	dolzachod2 = createMarker ( 2983.3557128906,3699.8347167969,1101.9022216797, "corona", 5, 255, 0, 0, 0)
	dolzachod3 = createMarker ( 2983.3156738281,3733.1635742188,1101.9761962891, "corona", 5, 255, 0, 0, 0)
	gorapolnoc1 = createMarker ( 3000.0524902344,3749.7819824219,1202.0559082031, "corona", 5, 255, 0, 0, 0)
	gorapolnoc2 = createMarker ( 3033.248046875,3749.7795410156,1202.0559082031, "corona", 5, 255, 0, 0, 0)
	gorapolnoc3 = createMarker ( 3066.6174316406,3749.763671875,1202.0559082031, "corona", 5, 255, 0, 0, 0)
	gorawschod1 = createMarker ( 3083.3015136719,3732.9340820313,1202.0159912109, "corona", 5, 255, 0, 0, 0)
	gorawschod2 = createMarker ( 3083.2841796875,3699.6342773438,1202.0458984375, "corona", 5, 255, 0, 0, 0)
	gorawschod3 = createMarker ( 3083.2780761719,3666.3449707031,1202.0458984375, "corona", 5, 255, 0, 0, 0)
	gorapoludnie1 = createMarker ( 3066.5578613281,3649.8029785156,1202.0291748047, "corona", 5, 255, 0, 0, 0)
	gorapoludnie2 = createMarker ( 3033.2995605469,3649.8029785156,1202.0141601563, "corona", 5, 255, 0, 0, 0)
	gorapoludnie3 = createMarker ( 3000.0041503906,3649.8029785156,1202.0128173828, "corona", 5, 255, 0, 0, 0)
	gorazachod1 = createMarker ( 2983.3156738281,3666.5437011719,1202.0139160156, "corona", 5, 255, 0, 0, 0)
	gorazachod2 = createMarker ( 2983.3156738281,3699.8752441406,1202.0147705078, "corona", 5, 255, 0, 0, 0)
	gorazachod3 = createMarker ( 2983.3156738281,3733.2580566406,1202.0364990234, "corona", 5, 255, 0, 0, 0)
	polnocwschod1 = createMarker ( 3083.2700195313,3749.78125,1118.4774169922, "corona", 5, 255, 0, 0, 0)
	polnocwschod2 = createMarker ( 3083.2917480469,3749.7580566406,1151.4718017578, "corona", 5, 255, 0, 0, 0)
	polnocwschod3 = createMarker ( 3083.1789550781,3749.78125,1184.9595947266, "corona", 5, 255, 0, 0, 0)
	wschodpoludnie1 = createMarker ( 3083.2883300781,3649.8127441406,1118.1501464844, "corona", 5, 255, 0, 0, 0)
	wschodpoludnie2 = createMarker ( 3083.2917480469,3649.9777832031,1151.7332763672, "corona", 5, 255, 0, 0, 0)
	wschodpoludnie3 = createMarker ( 3083.2216796875,3649.8127441406,1184.9654541016, "corona", 5, 255, 0, 0, 0)
	poludniezachod1 = createMarker ( 2983.3254394531,3649.8859863281,1118.2244873047, "corona", 5, 255, 0, 0, 0)
	poludniezachod2 = createMarker ( 2983.5834960938,3649.8127441406,1151.6170654297, "corona", 5, 255, 0, 0, 0)
	poludniezachod3 = createMarker ( 2983.3527832031,3649.8127441406,1184.9312744141, "corona", 5, 255, 0, 0, 0)
	zachodpolnoc1 = createMarker ( 2983.3286132813,3749.7294921875,1118.1599121094, "corona", 5, 255, 0, 0, 0)
	zachodpolnoc2 = createMarker ( 2983.3286132813,3749.6535644531,1151.5063476563, "corona", 5, 255, 0, 0, 0)
	zachodpolnoc3 = createMarker ( 2983.3286132813,3749.7609863281,1184.7724609375, "corona", 5, 255, 0, 0, 0)


	-- TMA - makes more sense to have these here
	addEventHandler ( "onClientMarkerHit", getRootElement(), Markery )

	-- TMA - put timer from server here
	setTimer(arena, 1000, 0)


end

function Markery ( hitPlayer, matchingDimension )


	-- TMA - we only need to change our cars gravity - other players can take care of themselves

	if hitPlayer ~= gMe then
		return
	end



	if source == dolpolnoc1 or source == dolpolnoc2 or source == dolpolnoc3 then
		if grawitacja == 0 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x, y+100, z, 1)
			grawitacja = 1
		elseif grawitacja == 1 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x, y, z-100, 1)
			grawitacja = 0
		end
	end	
	if source == dolwschod1 or source == dolwschod2 or source == dolwschod3 then
		if grawitacja == 0 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x+100, y, z, 1)
			grawitacja = 2
		elseif grawitacja == 2 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x, y, z-100, 1)
			grawitacja = 0
		end
	end	
	if source == dolpoludnie1 or source == dolpoludnie2 or source == dolpoludnie3 then
		if grawitacja == 0 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x, y-100, z, 1)
			grawitacja = 3
		elseif grawitacja == 3 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x, y, z-100, 1)
			grawitacja = 0
		end
	end	
	if source == dolzachod1 or source == dolzachod2 or source == dolzachod3 then
		if grawitacja == 0 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x-100, y, z, 1)
			grawitacja = 4
		elseif grawitacja == 4 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x, y, z-100, 1)
			grawitacja = 0
		end
	end	
	if source == gorapolnoc1 or source == gorapolnoc2 or source == gorapolnoc3 then
		if grawitacja == 5 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x, y+100, z, 1)
			grawitacja = 1
		elseif grawitacja == 1 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x, y, z+100, 1)
			grawitacja = 5
		end
	end	
	if source == gorawschod1 or source == gorawschod2 or source == gorawschod3 then
		if grawitacja == 5 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x+100, y, z, 1)
			grawitacja = 2
		elseif grawitacja == 2 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x, y, z+100, 1)
			grawitacja = 5
		end
	end	
	if source == gorapoludnie1 or source == gorapoludnie2 or source == gorapoludnie3 then
		if grawitacja == 5 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x, y-100, z, 1)
			grawitacja = 3
		elseif grawitacja == 3 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x, y, z+100, 1)
			grawitacja = 5
		end
	end	
	if source == gorazachod1 or source == gorazachod2 or source == gorazachod3 then
		if grawitacja == 5 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x-100, y, z, 1)
			grawitacja = 4
		elseif grawitacja == 4 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x, y, z+100, 1)
			grawitacja = 5
		end
	end	
	if source == polnocwschod1 or source == polnocwschod2 or source == polnocwschod3 then
		if grawitacja == 1 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x+100, y, z, 1)
			grawitacja = 2
		elseif grawitacja == 2 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x, y+100, z, 1)
			grawitacja = 1
		end
	end	
	if source == wschodpoludnie1 or source == wschodpoludnie2 or source == wschodpoludnie3 then
		if grawitacja == 2 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x, y-100, z, 1)
			grawitacja = 3
		elseif grawitacja == 3 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x+100, y, z, 1)
			grawitacja = 2
		end
	end	
	if source == poludniezachod1 or source == poludniezachod2 or source == poludniezachod3 then
		if grawitacja == 3 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x-100, y, z, 1)
			grawitacja = 4
		elseif grawitacja == 4 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x, y-100, z, 1)
			grawitacja = 3
		end
	end	
	if source == zachodpolnoc1 or source == zachodpolnoc2 or source == zachodpolnoc3 then
		if grawitacja == 4 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x, y+100, z, 1)
			grawitacja = 1
		elseif grawitacja == 1 then
			pojazd = getPedOccupiedVehicle ( hitPlayer )
			x,y,z = getElementPosition(hitPlayer)
			setVehicleGravityPoint(pojazd, x-100, y, z, 1)
			grawitacja = 4
		end
	end	
	
end

function setVehicleGravityPoint( targetVehicle, pointX, pointY, pointZ, strength )
	if isElement( targetVehicle ) and getElementType( targetVehicle ) == "vehicle" then
		local vehicleX,vehicleY,vehicleZ = getElementPosition( targetVehicle )
		local vectorX = vehicleX-pointX
		local vectorY = vehicleY-pointY
		local vectorZ = vehicleZ-pointZ
		local length = ( vectorX^2 + vectorY^2 + vectorZ^2 )^0.5
 
		local propX = vectorX^2 / length^2
		local propY = vectorY^2 / length^2
		local propZ = vectorZ^2 / length^2
 
		local finalX = ( strength^2 * propX )^0.5
		local finalY = ( strength^2 * propY )^0.5
		local finalZ = ( strength^2 * propZ )^0.5
 
		if vectorX > 0 then finalX = finalX * -1 end
		if vectorY > 0 then finalY = finalY * -1 end
		if vectorZ > 0 then finalZ = finalZ * -1 end
 
		return setVehicleGravity( targetVehicle, finalX, finalY, finalZ )
	end
	return false
end



-- TMA - change to getResourceRootElement(getThisResource())

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startclient)


-- TMA - this death-check function no-longer has to loop through all players - it just checks my position

function arena()

	-- TMA - first we can check we are alive in race by looking at the state attribute race sets

	local state = getElementData(gMe,"state")
	if state and state == "alive" then

		killx, killy, killz = getElementPosition(gMe)

		if killz < 1050 or killz > 1250 or killx < 2930 or killx > 3130 or killy < 3600 or killy > 3800 then
			pojazd = getPedOccupiedVehicle(gMe)


			-- TMA
			--
			-- Check the vehicle is valid before blowing it up - without the check your code was causing lots of console errors
			-- please fix this for all your maps

			if pojazd then
				blowVehicle ( pojazd )
			end


		end
	end
end
