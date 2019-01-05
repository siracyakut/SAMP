new __FlyTimer[MAX_PLAYERS], _aFly[2];

public OnGameModeInit()
{
	_aFly[0] = funcidx("_aFly_OnPlayerConnect") != -1;
	_aFly[1] = funcidx("_aFly_OnPlayerDisconnect") != -1;
	if (funcidx("_aFly_OnGameModeInit") != -1)
	{
		return CallLocalFunction("_aFly_OnGameModeInit", "");
	}
	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit _aFly_OnGameModeInit
forward _aFly_OnGameModeInit();

public OnPlayerConnect(playerid)
{
	__FlyTimer[playerid] = SetTimerEx("FlyKontrol", 1000, true, "d", playerid);

	if (_aFly[0])
	{
		return CallLocalFunction("_aFly_OnPlayerConnect", "i",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect _aFly_OnPlayerConnect
forward _aFly_OnPlayerConnect(playerid);


public OnPlayerDisconnect(playerid,  reason)
{
	KillTimer(__FlyTimer[playerid]);
	if (_aFly[1])
	{
		return CallLocalFunction("_aFly_OnPlayerDisconnect", "ii",playerid,  reason);
	}
	return 1;
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect _aFly_OnPlayerDisconnect
forward _aFly_OnPlayerDisconnect(playerid,  reason);


forward FlyKontrol(playerid);
public FlyKontrol(playerid)
{
	if(AnimCek(playerid))
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		if(z > 1.0)
		{
			if(!PosCek(playerid))
			{
				CallRemoteFunction("AntiFly", "d", playerid);
				new ___ping = GetPlayerPing(playerid) + 150;
				SetTimerEx("fly_Kick", (___ping > 500 ? 500 : ___ping), false, "d", playerid);
			}
		}
	}
	return 1;
}

stock AnimCek(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		new animcik[32], animismine[32];
		GetAnimationName(GetPlayerAnimationIndex(playerid),animcik,32,animismine,32);
		if(!strcmp(animcik, "SWIM", true) && !strcmp(animismine, "SWIM_GLIDE", true)) return 1;
		else if(!strcmp(animcik, "SWIM", true) && !strcmp(animismine, "SWIM_BREAST", true)) return 1;
		else if(!strcmp(animcik, "SWIM", true) && !strcmp(animismine, "SWIM_CRAWL", true)) return 1;
		else if(!strcmp(animcik, "SWIM", true) && !strcmp(animismine, "SWIM_DIVE_UNDER", true)) return 1;
		else if(!strcmp(animcik, "SWIM", true) && !strcmp(animismine, "SWIM_DIVE_GLIDE", true)) return 1;
		else if(!strcmp(animcik, "SWIM", true) && !strcmp(animismine, "SWIM_UNDER", true)) return 1;
		else if(!strcmp(animcik, "SWIM", true) && !strcmp(animismine, "SWIM_TREAD", true)) return 1;
		else if(GetPlayerWeapon(playerid) != 46)
		{
			if(!strcmp(animcik, "PARACHUTE", true) && !strcmp(animismine, "FALL_SkyDive_Accel", true)) return 1;
			if(!strcmp(animcik, "PARACHUTE", true) && !strcmp(animismine, "FALL_SKYDIVE", true)) return 1;
		}
	}
	return 0;
}

stock PosCek(playerid)
{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x, y, z);
	if((x >= -1408.0629 && y >= 2021.0587 && x <= -460.9319 && y <= 2861.4893) ||
	(x >= 1269.5886 && y >= -810.4507 && x <= 1288.8916 && y <= -800.5959) ||
	(x >= 1086.6010 && y >= -683.6998 && x <= 1103.0225 && y <= -662.1832) ||
	(x >= 169.6879 && y >= -1392.6630 && x <= 281.5444 && y <= -1168.9749) ||
	(x >= -828.3018 && y >= -2107.1487 && x <= -443.5032 && y <= -1855.6273) ||
	(x >= 1198.9982 && y >= -2407.0581 && x <= 1275.7397 && y <= -2341.6262) ||
	(x >= 2293.1467 && y >= -1432.5869 && x <= 2331.7388 && y <= -1397.6476) ||
	(x >= 1915.3196 && y >= -1236.2382 && x <= 2016.6565 && y <= -1167.9290) ||
	(x >= -2747.1692 && y >= -510.1152 && x <= -2663.2468 && y <= -411.4905) ||
	(x >= 1838.8041 && y >= 1463.2024 && x <= 2035.4167 && y <= 1703.0480) ||
	(x >= 2049.6646 && y >= 1843.3029 && x <= 2119.9021 && y <= 1983.5464) ||
	(x >= 2094.9255 && y >= 1085.2852 && x <= 2179.1790 && y <= 1183.0610) ||
	(x >= 2545.3718 && y >= 2347.7112 && x <= 2593.6794 && y <= 2403.8040))
	{
		return 1;
	}
	return 0;
}

forward fly_Kick(playerid);
public fly_Kick(playerid)
{
	Kick(playerid);
	return 1;
}

forward AntiFly(playerid);