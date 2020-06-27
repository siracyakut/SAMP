objects = getElementsByType("object")
for index,value in ipairs(objects) do
setElementData(value,"used",false)
end

function moveEverything()
toUse = {}
for index, value in ipairs(toUse) do
value = nil
end
for index, value in ipairs(objects) do
	if getElementData(value, "used") == false then
		table.insert(toUse,value)
	end
end
local randomO = math.random(1,#toUse)
local x,y,z = getElementPosition(toUse[randomO])
createExplosion(x,y,z,5)
moveObject(toUse[randomO],3000,x,y,z-20)
setElementData(toUse[randomO],"used",true)
setTimer(moveEverything,7000,1)
end

addEvent("onRaceStateChanging", true)
addEventHandler("onRaceStateChanging",getRootElement(),
function (newState)
if newState == "Running" then
setTimer(moveEverything,3000,1)
end
end)