#if defined _Included_GetVehicleColor
	#endinput
#endif

#define _Included_GetVehicleColor

#define PROPERTY_OFFSET(%0) \
	((((%0) * ((%0) << 1)) << 2) + 65536)

#define PROPERTY_OFFSET2(%0) \
	((((%0) * ((%0) << 1)) << 2) + 61536)
stock n_AddStaticVehicle(modelID, Float: spawn_X, Float: spawn_Y, Float: spawn_Z, Float: z_Angle, color1, color2)
{
	if(color1 < 0 || color2 < 0)
	{
		color1 = random(127);
		color2 = random(127);
	}
	modelID = AddStaticVehicle(modelID, spawn_X, spawn_Y, spawn_Z, z_Angle, color1, color2);
	
	new
		colorStr[24]
	;	
	format(colorStr, sizeof(colorStr), "%d-%d", color1, color2);
	setproperty(_, "", PROPERTY_OFFSET(modelID), colorStr);
	
	return modelID;
}

stock n_AddStaticVehicleEx(modelID, Float: spawn_X, Float: spawn_Y, Float: spawn_Z, Float: z_Angle, color1, color2, respawn_Delay)
{
	if(color1 < 0 || color2 < 0)
	{
		color1 = random(127);
		color2 = random(127);
	}
	modelID = AddStaticVehicleEx(modelID, spawn_X, spawn_Y, spawn_Z, z_Angle, color1, color2, respawn_Delay);
	
	new
		colorStr[24]
	;	
	format(colorStr, sizeof(colorStr), "%d-%d", color1, color2);
	setproperty(_, "", PROPERTY_OFFSET(modelID), colorStr);
	
	return modelID;
}

stock n_CreateVehicle(modelID, Float: spawn_X, Float: spawn_Y, Float: spawn_Z, Float: z_Angle, color1, color2, respawn_Delay)
{
	if(color1 < 0 || color2 < 0)
	{
		color1 = random(127);
		color2 = random(127);
	}
	modelID = CreateVehicle(modelID, spawn_X, spawn_Y, spawn_Z, z_Angle, color1, color2, respawn_Delay);
	
	new
		colorStr[24]
	;	
	format(colorStr, sizeof(colorStr), "%d-%d", color1, color2);
	setproperty(_, "", PROPERTY_OFFSET(modelID), colorStr);
	
	return modelID;
}

stock n_DestroyVehicle(vehicleID)
{
	deleteproperty(_, "", PROPERTY_OFFSET(vehicleID));
	deleteproperty(_, "", PROPERTY_OFFSET2(vehicleID));
	return DestroyVehicle(vehicleID);
}

stock n_ChangeVehicleColor(vehicleID, color1, color2)
{
	new
		colorStr[24]
	;	
	format(colorStr, sizeof(colorStr), "%d-%d", color1, color2);
	setproperty(_, "", PROPERTY_OFFSET(vehicleID), colorStr);
	
	return ChangeVehicleColor(vehicleID, color1, color2);
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	new
		colorStr[24]
	;	
	format(colorStr, sizeof(colorStr), "%d-%d", color1, color2);
	setproperty(_, "", PROPERTY_OFFSET(vehicleid), colorStr);
	
	if(funcidx("n_OnVehicleRespray") != -1)
	{
		return CallLocalFunction("n_OnVehicleRespray", "iiii", playerid, vehicleid, color1, color2);
	}
	return 1;
}
public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
 	new
		colorStr[24]
	;	
	format(colorStr, sizeof(colorStr), "%d", paintjobid);
	setproperty(_, "", PROPERTY_OFFSET2(vehicleid), colorStr);
	return 1;
}
stock n_ChangeVehiclePaintjob(vehicleID, paintjob)
{
	new
		colorStr[24]
	;	
	format(colorStr, sizeof(colorStr), "%d", paintjob);
	setproperty(_, "", PROPERTY_OFFSET2(vehicleID), colorStr);
	return ChangeVehiclePaintjob(vehicleID, paintjob);
}
stock GetVehiclePaintJob(vehicleID)
{
	vehicleID = PROPERTY_OFFSET2(vehicleID);
	if(existproperty(_, "", vehicleID))
	{
		new
			colorStr[24]
		;
		getproperty(_, "", vehicleID, colorStr);
		strunpack(colorStr, colorStr);
		return strval(colorStr);
	}
	return 3;
}
stock GetVehicleColor(vehicleID, &color1, &color2)
{
	vehicleID = PROPERTY_OFFSET(vehicleID);
	
	if(existproperty(_, "", vehicleID))
	{
		new
			colorStr[24],
			strPos
		;
		getproperty(_, "", vehicleID, colorStr);
		strunpack(colorStr, colorStr);
		
		if((strPos = strfind(colorStr, "-")) != -1)
		{
			color1 = strval(colorStr);
			color2 = strval(colorStr[strPos + 1]);
			return 1;
		}
	}
	return 0;
}

/*
#define AddStaticVehicle n_AddStaticVehicle
#define AddStaticVehicleEx n_AddStaticVehicleEx
#define CreateVehicle n_CreateVehicle
#define DestroyVehicle n_DestroyVehicle
*/
#define ChangeVehicleColor n_ChangeVehicleColor
#define ChangeVehiclePaintjob n_ChangeVehiclePaintjob
#if defined _ALS_OnVehicleRespray
	#undef OnVehicleRespray
#else
	#define _ALS_OnVehicleRespray
#endif

#define OnVehicleRespray n_OnVehicleRespray

forward n_OnVehicleRespray(playerid, vehicleid, color1, color2);