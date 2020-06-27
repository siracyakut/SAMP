
g_mapOptions = {
	BarrelCount = 500,
	OriginX = 1418.918579,
	OriginY = -2608.629883,
	Breadth = 605.259766,
	Width = 30,739258,
	zIndex = 13
}

-- get number or default
function getNumber(var,default)
    local result = get(var)
    if not result then
        return default
    end
    return tonumber(result)
end

function setupBarrels()
	math.randomseed(getTickCount())
	local z = g_mapOptions.zIndex
	g_mapOptions.BarrelCount = getNumber("race-gtthboom.BarrelCount", 500)
	outputDebugString('Barrel count is ' .. g_mapOptions.BarrelCount)
	for i = 0, g_mapOptions.BarrelCount, 1 do
		local x = g_mapOptions.OriginX + g_mapOptions.Breadth * math.random()
		local y = g_mapOptions.OriginY + g_mapOptions.Width * math.random()
		createObject(1225, x, y, z)
	end
end
addEventHandler('onResourceStart', getRootElement(), setupBarrels)
	
