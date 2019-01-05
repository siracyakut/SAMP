//----------------------------------------------------------------------------------------------------------------.
//																												 //
//	FairPlay 																					   Version 1.2	//
//																								   			   //
//------------------------------------------------------------------------------------------------------------//
//-----------------------------------------------------------------------------------------------------------//
//																									        //
//	Credits																							       //
//	- Scripting: Ricky Phelps (SuperViper)																  //
//	- Testing: Chriham3/Alex Shock								 										 //
//																								        //
//-----------------------------------------------------------------------------------------------------//
//----------------------------------------------------------------------------------------------------//
// ============================================ SETTINGS =========================================== //

/* Unfair play list (comment the line of anything you don't want to be detected) */
//#define FP_HIGH_PING					(1)
//#define FP_WEAPON_HACK					(2)
#define FP_VEHICLE_SPEED_HACK			(3)
//#define FP_JETPACK_HACK				(4)
//#define FP_DRIVER_DRIVEBY				(5) // Commenting this will ENABLE driver driveby
//#define FP_DRIVEBY_WEAPONS_RESTRICT	(6)
//#define FP_SWEARING					(7)
#define FP_FLY_HACK						(8)
//#define FP_CHAT_SPAM					(9)
//#define FP_AFK						(10)
//#define FP_TABBING					(11)
//#define FP_NINJA_JACK					(12)
//#define FP_CAR_RAM					(13)
//#define FP_HELIBLADE					(14)
#define FP_VEHICLE_MOD_HACK				(15)
//#define FP_SERVER_AD					(16)
//#define FP_FAKE_KILL					(17)
#define FP_TELEPORT_HACK				(18)
#define Color_Hack						(19)
#define Player_Bugger					(20)
#define FP_PLAYER_SPEED_HACK			(21)

#if defined FP_MASTER
	/* This is the interval of the timer which checks for fair play */
	#define FP_TIMER_INTERVAL		(1000)

	/* The maximum ping allowed on the server (will be ignored if high ping detection is disabled) */
	#define FP_MAX_PING				(500)

	/* The weapons which are allowed for drivebys (separate with space - will be ignored if driveby weapons restriction is disabled) */
	#define FP_DRIVEBY_WEAPONS		"28 29 32"

	/* The IP address of your server (will be ignored if server advertisement detection is disabled) */
	#define FP_SERVER_IP			"95.173.182.245"

	/* The domain of your server (will be ignored if server advertisement detection is disabled) */
	#define FP_SERVER_DOMAIN		"turkibiza.net"

	/* Curse words (will be ignored if swearing detection is disabled) */
	/*new FP_CurseWords[][] =
	{
		"ass", "bitch", "cunt", "fuck", "nigga", "nigger", "shit", "whore"
	};*/
#endif

// ================================================================================================= //
// =============================== DO NOT TOUCH ANYTHING BELOW THIS =============================== //
// =============================================================================================== //

#define FAIRPLAY_INCLUDED

#if !defined sscanf
	#tryinclude <sscanf2>
#endif

forward public FP_Detection();
forward public OnPlayerUnfairPlay(playerid, playType);

forward public FP_ReduceChatCounter(playerid);
forward public FP_VehicleJackCheck(playerid);

forward public FP_OnPlayerConnect(playerid);
forward public FP_OnPlayerDisconnect(playerid, reason);
forward public FP_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
forward public FP_OnPlayerDeath(playerid, killerid, reason);
forward public FP_OnPlayerSpawn(playerid);
forward public FP_OnPlayerStateChange(playerid, newstate, oldstate);
forward public FP_OnPlayerText(playerid, text[]);
forward public FP_OnPlayerCommandText(playerid, cmdtext[]);
forward public FP_OnPlayerUpdate(playerid);
forward public FP_OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid);
forward public FP_OnVehicleMod(playerid, vehicleid, componentid);
forward public FP_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
#if defined FP_WEAPON_HACK
new FP_WeaponSlots[47] =
{
	0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10,
	10, 10, 10, 10, 8, 8, 8, -1, -1, -1,
	2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 4, 6,
	6, 7, 7, 7, 7, 8, 12, 9, 9, 9, 11,
	11, 11
};
#endif
stock SetPlayerColor_(playerid,color)
{
	SetPVarInt(playerid,"pcolor",color);
	return SetPlayerColor(playerid,color);
}
#define SetPlayerColor SetPlayerColor_
#if defined FP_MASTER
	stock SetPlayerFairPlayImmune(playerid, immune)
	{
		return SetPVarInt(playerid, "FP_Immune", immune);
	}

	FP_GetVehicleSpeed(vehicleID)
	{
		new Float: vehiclesVelocity[3];
		GetVehicleVelocity(vehicleID, vehiclesVelocity[0], vehiclesVelocity[1], vehiclesVelocity[2]);
		return floatround(floatsqroot((vehiclesVelocity[0] * vehiclesVelocity[0] + vehiclesVelocity[1] * vehiclesVelocity[1] + vehiclesVelocity[2] * vehiclesVelocity[2])) * 200.2);
	}
	FP_GetPlayerSpeed(playerid)
	{
		new Float: vehiclesVelocity[3];
		GetPlayerVelocity(playerid, vehiclesVelocity[0], vehiclesVelocity[1], vehiclesVelocity[2]);
		return floatround(floatsqroot((vehiclesVelocity[0] * vehiclesVelocity[0] + vehiclesVelocity[1] * vehiclesVelocity[1] + vehiclesVelocity[2] * vehiclesVelocity[2])) * 200.2);
	}

stock FP_SetPlayerPos(playerid, Float: x, Float: y, Float: z)
{
	SetPVarFloat(playerid, "FP_LastPositionX", x), SetPVarFloat(playerid, "FP_LastPositionY", y), SetPVarFloat(playerid, "FP_LastPositionZ", z);
	return SetPlayerPos(playerid, x, y, z);
}

#if defined _ALS_SetPlayerPos
	#undef SetPlayerPos
#else
	#define _ALS_SetPlayerPos
#endif

#define SetPlayerPos FP_SetPlayerPos

	public FP_Detection()
	{
		foreach(new playerid:Player){
		if(!GetPVarInt(playerid, "FP_Immune"))
		{
			new Float: playersPosition[3], playersState = GetPlayerState(playerid);
			GetPlayerPos(playerid, playersPosition[0], playersPosition[1], playersPosition[2]);

			#if defined FP_TELEPORT_HACK
				if(!IsPlayerInAnyVehicle(playerid))
				{
				if(playersState == PLAYER_STATE_ONFOOT || playersState == PLAYER_STATE_SPAWNED)
				{
					if(GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID)
					{
						if(!IsPlayerInRangeOfPoint(playerid,90,GetPVarFloat(playerid, "FP_LastPositionX"),GetPVarFloat(playerid, "FP_LastPositionY"),GetPVarFloat(playerid, "FP_LastPositionZ")) && !IsPlayerInRangeOfPoint(playerid,10,-2340.3945,-1622.7443,483.6996))
						{
							//printf("%f,%f,%f | %f,%f,%f",GetPVarFloat(playerid, "FP_LastPositionX"),GetPVarFloat(playerid, "FP_LastPositionY"),GetPVarFloat(playerid, "FP_LastPositionZ"),playersPosition[0], playersPosition[1], playersPosition[2]);
							CallLocalFunction("OnPlayerUnfairPlay", "dd", playerid, FP_TELEPORT_HACK);
						}
					}
				}
				}
				SetPVarFloat(playerid, "FP_LastPositionX", playersPosition[0]), SetPVarFloat(playerid, "FP_LastPositionY", playersPosition[1]), SetPVarFloat(playerid, "FP_LastPositionZ", playersPosition[2]);
			#endif
			SetPVarInt(playerid, "FP_TabbedUpdates", GetPVarInt(playerid, "FP_TabbedUpdates") + 1);

			#if defined FP_HIGH_PING
				if(GetPlayerPing(playerid) >= FP_MAX_PING)
				{
					SetPVarInt(playerid, "FP_PingWarnings", GetPVarInt(playerid, "FP_PingWarnings") + 1);

					if(GetPVarInt(playerid, "FP_PingWarnings") >= 3)
					{
						SetPVarInt(playerid, "FP_PingWarnings", 0);
						CallLocalFunction("OnPlayerUnfairPlay", "dd", playerid, FP_HIGH_PING);
					}
				}
			#endif

			#if defined FP_VEHICLE_SPEED_HACK
				new playersVehicle = GetPlayerVehicleID(playerid);

				if(playersVehicle)
				{
					new ivme;
					new speed = FP_GetVehicleSpeed(playersVehicle);
					ivme = (speed-GetPVarInt(playerid,"sonhiz"));
					SetPVarInt(playerid,"sonhiz",speed);
					if(ivme > 135)CallLocalFunction("OnPlayerUnfairPlay", "dd", playerid, FP_VEHICLE_SPEED_HACK);
				}
			#endif
			#if defined FP_FLY_HACK
					new ivme;
					new speed = FP_GetPlayerSpeed(playerid);
					ivme = (speed-GetPVarInt(playerid,"sonphiz"));
					SetPVarInt(playerid,"sonphiz",speed);
					if(ivme > 175)CallLocalFunction("OnPlayerUnfairPlay", "dd", playerid, FP_FLY_HACK);
			#endif
			#if defined Player_Bugger
			new Float: pX, Float: pY, Float:pZ;
			GetPlayerPos(playerid, pX, pY, pZ);

			if(pX > 0xdbb9f && pY > 0xdbb9f && pZ > 0xdbb9f) {
				SetTimerEx("verifBugger_pB", 250, false, "i", playerid);
			}
			#endif
			#if defined FP_JETPACK_HACK
				if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
				{
					if(!GetPVarInt(playerid, "FP_PlayerJetpack"))
					{
						CallLocalFunction("OnPlayerUnfairPlay", "dd", playerid, FP_JETPACK_HACK);
					}
				}
				else
				{
					SetPVarInt(playerid, "FP_PlayerJetpack", 0);
				}
			#endif
			
			#if defined Color_Hack
				if(GetPlayerColor(playerid) != GetPVarInt(playerid,"pcolor"))
				{
				CallLocalFunction("OnPlayerUnfairPlay", "dd", playerid, Color_Hack);
				}
			#endif
			

			#if defined FP_AFK
				if(tickcount() - GetPVarInt(playerid, "FP_LastUpdate") >= 300000)
				{
					CallLocalFunction("OnPlayerUnfairPlay", "dd", playerid, FP_AFK);
				}
			#endif

			#if defined FP_TABBING
				if(GetPVarInt(playerid, "FP_TabbedUpdates") >= 3)
				{
					if(playersState == PLAYER_STATE_ONFOOT || playersState == PLAYER_STATE_DRIVER || playersState == PLAYER_STATE_PASSENGER || playersState == PLAYER_STATE_SPAWNED)
					{
						CallLocalFunction("OnPlayerUnfairPlay", "dd", playerid, FP_TABBING);
					}
				}
			#endif
		}
		}
		return 1;
	}

	public FP_ReduceChatCounter(playerid)
	{
		SetPVarInt(playerid, "FP_ChatCounter", GetPVarInt(playerid, "FP_ChatCounter") - 1);
		return 1;
	}

	public FP_VehicleJackCheck(playerid)
	{
		SetPVarInt(playerid, "FP_VehicleJacker", INVALID_PLAYER_ID);
		return 1;
	}

	public OnPlayerConnect(playerid)
	{
		for(new weaponIndex, variableName[20]; weaponIndex < 13; weaponIndex++)
		{
			format(variableName, sizeof(variableName), "FP_PlayerWeapon%d", weaponIndex);
			SetPVarInt(playerid, variableName, 0);
		}
		SetPVarFloat(playerid, "FP_LastPositionX", 0), SetPVarFloat(playerid, "FP_LastPositionY", 0), SetPVarFloat(playerid, "FP_LastPositionZ", 0);
		SetPVarInt(playerid, "FP_PingWarnings", 0);

		SetPVarInt(playerid, "FP_PlayerJetpack", 0);

		SetPVarInt(playerid, "FP_ChatCounter", 0);

		SetPVarInt(playerid, "FP_LastUpdate", tickcount());

		SetPVarInt(playerid, "FP_TabbedUpdates", 0);

		SetPVarInt(playerid, "FP_VehicleJacker", INVALID_PLAYER_ID);
		SetPVarInt(playerid, "FP_VehicleJackTimer", -1);

		SetPVarInt(playerid, "FP_PlayerAlive", 0);

		SetPVarInt(playerid, "FP_LastPositionSet", tickcount());

		return (funcidx("FP_OnPlayerConnect") == -1) ? 1 : CallLocalFunction("FP_OnPlayerConnect", "d", playerid);
	}

	#if defined _ALS_OnPlayerConnect
		#undef OnPlayerConnect
	#else
		#define _ALS_OnPlayerConnect
	#endif

	#define OnPlayerConnect FP_OnPlayerConnect

	public OnPlayerDisconnect(playerid, reason)
	{

		if(GetPVarInt(playerid, "FP_VehicleJackTimer") != -1)
		{
			KillTimer(GetPVarInt(playerid, "FP_VehicleJackTimer"));
		}

		return (funcidx("FP_OnPlayerDisconnect") == -1) ? 1 : CallLocalFunction("FP_OnPlayerDisconnect", "dd", playerid, reason);
	}

	#if defined _ALS_OnPlayerDisconnect
		#undef OnPlayerDisconnect
	#else
		#define _ALS_OnPlayerDisconnect
	#endif

	#define OnPlayerDisconnect FP_OnPlayerDisconnect

	public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
	{
		if(!GetPVarInt(playerid, "FP_Immune"))
		{
			#if defined FP_WEAPON_HACK
				if(newkeys & KEY_FIRE && !IsPlayerInAnyVehicle(playerid))
				{
					new playersWeapon = GetPlayerWeapon(playerid);

					if(playersWeapon && playersWeapon != 40 && playersWeapon != 46)
					{
						new variableName[20];
						format(variableName, sizeof(variableName), "FP_PlayerWeapon%d", FP_WeaponSlots[playersWeapon]);

						if(GetPVarInt(playerid, variableName) != playersWeapon)
						{
							CallLocalFunction("OnPlayerUnfairPlay", "dd", playerid, FP_WEAPON_HACK);
						}
					}
				}
			#endif
		}

		return (funcidx("FP_OnPlayerKeyStateChange") == -1) ? 1 : CallLocalFunction("FP_OnPlayerKeyStateChange", "ddd", playerid, newkeys, oldkeys);
	}

	#if defined _ALS_OnPlayerKeyStateChange
		#undef OnPlayerKeyStateChange
	#else
		#define _ALS_OnPlayerKeyStateChange
	#endif

	#define OnPlayerKeyStateChange FP_OnPlayerKeyStateChange

	public OnPlayerDeath(playerid, killerid, reason)
	{
		new playerAlive = GetPVarInt(playerid, "FP_PlayerAlive");

		switch(playerAlive)
		{
			case 0, 1:
			{
				SetPVarInt(playerid, "FP_PlayerAlive", (playerAlive) ? 0 : 2);
			}

			case 2:
			{
				//CallLocalFunction("OnPlayerUnfairPlay", "dd", playerid, FP_FAKE_KILL);
			}
		}

		SetPVarInt(playerid, "FP_PlayerJetpack", 0);

		if(!GetPVarInt(playerid, "FP_Immune"))
		{
			#if defined FP_NINJA_JACK
				if(GetPVarInt(playerid, "FP_VehicleJacker") != INVALID_PLAYER_ID)
				{
					CallLocalFunction("OnPlayerUnfairPlay", "dd", GetPVarInt(playerid, "FP_VehicleJacker"), FP_NINJA_JACK);
				}
			#endif

			#if defined FP_FAKE_KILL
				if(killerid != INVALID_PLAYER_ID && !IsPlayerNPC(playerid) && !IsPlayerNPC(killerid))
				{
					new Float: playersHealth;
					GetPlayerHealth(playerid, playersHealth);

					if(playersHealth)
					{
						CallLocalFunction("OnPlayerUnfairPlay", "dd", playerid, FP_FAKE_KILL);
					}
				}
			#endif
		}

		SetPVarInt(playerid, "FP_LastPositionSet", tickcount());
		return (funcidx("FP_OnPlayerDeath") == -1) ? 1 : CallLocalFunction("FP_OnPlayerDeath", "ddd", playerid, killerid, reason);
	}

	#if defined _ALS_OnPlayerDeath
		#undef OnPlayerDeath
	#else
		#define _ALS_OnPlayerDeath
	#endif

	#define OnPlayerDeath FP_OnPlayerDeath

	public OnPlayerSpawn(playerid)
	{
		SetPVarInt(playerid, "FP_PlayerJetpack", 0);
		SetPVarInt(playerid, "FP_LastPositionSet", tickcount());
		SetPVarInt(playerid, "FP_PlayerAlive", 1);
		return FP_OnPlayerSpawn(playerid);
	}

	#if defined _ALS_OnPlayerSpawn
		#undef OnPlayerSpawn
	#else
		#define _ALS_OnPlayerSpawn
	#endif

	#define OnPlayerSpawn FP_OnPlayerSpawn

	public OnVehicleMod(playerid, vehicleid, componentid)
	{
		if(!GetPVarInt(playerid, "FP_Immune"))
		{
			#if defined FP_VEHICLE_MOD_HACK
				if(!GetPlayerInterior(playerid))
				{
					CallLocalFunction("OnPlayerUnfairPlay", "dd", playerid, FP_VEHICLE_MOD_HACK);
					return 0;
				}
			#endif
		}

		return (funcidx("FP_OnVehicleMod") == -1) ? 1 : CallLocalFunction("FP_OnVehicleMod", "ddd", playerid, vehicleid, componentid);
	}

	#if defined _ALS_OnVehicleMod
		#undef OnVehicleMod
	#else
		#define _ALS_OnVehicleMod
	#endif

	#define OnVehicleMod FP_OnVehicleMod

	public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
	{
		if(!GetPVarInt(playerid, "FP_Immune"))
		{
			#if defined FP_NINJA_JACK
				if(!ispassenger)
				{
					for(new playerIndex; playerIndex < MAX_PLAYERS; playerIndex++)
					{
						if(IsPlayerInVehicle(playerIndex, vehicleid) && !GetPlayerVehicleSeat(playerIndex))
						{
							SetPVarInt(playerIndex, "FP_VehicleJacker", playerid);
							SetPVarInt(playerIndex, "FP_VehicleJackTimer", SetTimerEx("FP_VehicleJackCheck", 10000, 0, "d", playerIndex));
							break;
						}
					}
				}
			#endif
		}

		return (funcidx("FP_OnPlayerEnterVehicle") == -1) ? 1 : CallLocalFunction("FP_OnPlayerEnterVehicle", "ddd", playerid, vehicleid, ispassenger);
	}

	#if defined _ALS_OnPlayerEnterVehicle
		#undef OnPlayerEnterVehicle
	#else
		#define _ALS_OnPlayerEnterVehicle
	#endif

	#define OnPlayerEnterVehicle FP_OnPlayerEnterVehicle
#endif
forward verifBugger_pB(playerid);
public verifBugger_pB(playerid) {
	new Float: ax, Float: ay, Float: az;
	GetPlayerPos(playerid, ax, ay, az);
	if(ax > 0xdbb9f && ay > 0xdbb9f && az > 0xdbb9f) SetPlayerPos(playerid, GetPVarFloat(playerid,"xposSet"),  GetPVarFloat(playerid,"yposSet"),  GetPVarFloat(playerid,"zposSet"));
	else CallLocalFunction("OnPlayerUnfairPlay", "ii", playerid, Player_Bugger);
	return 1;
}
#if defined FP_WEAPON_HACK
stock FP_GivePlayerWeapon(playerid, weaponid, ammo)
{
	new variableName[20];
	format(variableName, sizeof(variableName), "FP_PlayerWeapon%d", FP_WeaponSlots[weaponid]);
	SetPVarInt(playerid, variableName, weaponid);
	return GivePlayerWeapon(playerid, weaponid, ammo);
}

#if defined _ALS_GivePlayerWeapon
	#undef GivePlayerWeapon
#else
	#define _ALS_GivePlayerWeapon
#endif

#define GivePlayerWeapon FP_GivePlayerWeapon

stock FP_ResetPlayerWeapons(playerid)
{
	for(new weaponIndex, variableName[20]; weaponIndex < 13; weaponIndex++)
	{
		format(variableName, sizeof(variableName), "FP_PlayerWeapon%d", weaponIndex);
		SetPVarInt(playerid, variableName, 0);
	}

	return ResetPlayerWeapons(playerid);
}

#if defined _ALS_ResetPlayerWeapons
	#undef ResetPlayerWeapons
#else
	#define _ALS_ResetPlayerWeapons
#endif

#define ResetPlayerWeapons FP_ResetPlayerWeapons

stock FP_SetPlayerAmmo(playerid, weapon, ammo)
{
	if(!ammo)
	{
		new variableName[20];
		format(variableName, sizeof(variableName), "FP_PlayerWeapon%d", FP_WeaponSlots[weapon]);
		SetPVarInt(playerid, variableName, 0);
	}

	return SetPlayerAmmo(playerid, weapon, ammo);
}

#if defined _ALS_SetPlayerAmmo
	#undef SetPlayerAmmo
#else
	#define _ALS_SetPlayerAmmo
#endif

#define SetPlayerAmmo FP_SetPlayerAmmo
#endif
stock FP_SetPlayerSpecialAction(playerid, actionid)
{
	if(actionid == SPECIAL_ACTION_USEJETPACK)
	{
		SetPVarInt(playerid, "FP_PlayerJetpack", 1);
	}
	else if(actionid == SPECIAL_ACTION_NONE)
	{
		SetPVarInt(playerid, "FP_PlayerJetpack", 0);
	}

	return SetPlayerSpecialAction(playerid, actionid);
}

#if defined _ALS_SetPlayerSpecialAction
	#undef SetPlayerSpecialAction
#else
	#define _ALS_SetPlayerSpecialAction
#endif

#define SetPlayerSpecialAction FP_SetPlayerSpecialAction

stock FP_ClearAnimations(playerid)
{
	SetPVarInt(playerid, "FP_PlayerJetpack", 0);
	return ClearAnimations(playerid);
}

#if defined _ALS_ClearAnimations
	#undef ClearAnimations
#else
	#define _ALS_ClearAnimations
#endif

#define ClearAnimations FP_ClearAnimations



stock FP_SetPlayerPosFindZ(playerid, Float: x, Float: y, Float: z)
{
	SetPVarInt(playerid, "FP_LastPositionSet", tickcount());
	return SetPlayerPosFindZ(playerid, x, y, z);
}

#if defined _ALS_SetPlayerPosFindZ
	#undef SetPlayerPosFindZ
#else
	#define _ALS_SetPlayerPosFindZ
#endif

#define SetPlayerPosFindZ FP_SetPlayerPosFindZ

stock FP_SetPlayerVelocity(playerid, Float: x, Float: y, Float: z)
{
	SetPVarInt(playerid, "FP_LastPositionSet", tickcount());
	return SetPlayerVelocity(playerid, x, y, z);
}

#if defined _ALS_SetPlayerVelocity
	#undef SetPlayerVelocity
#else
	#define _ALS_SetPlayerVelocity
#endif

#define SetPlayerVelocity FP_SetPlayerVelocity