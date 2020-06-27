/*---------------------------------------------------\*

		========================================
		    Spawn Bölge | Silah Yasaklayıcı
		========================================

				Kodlama:	NexoR
			
					04.02.2017

\*---------------------------------------------------*/

#include 	<a_samp>
#include 	<streamer>
#define     N_MAX_BOLGE     (15 + 1)    //  Max eklenecek bölge sayısı - Sadece 15 kısmını değiştirin.

enum n_bolgeData
{
	Float: n_minx,
	Float: n_miny,
	Float: n_maxx,
	Float: n_maxy,
	n_worldid,
	n_interiorid,
 	n_playerid,
 	temp_a,
 	n_sID
};
new n_BolgeIslem[N_MAX_BOLGE][n_bolgeData];

enum n_oSilahData
{
	n_Silah[13],
	n_Mermi[13]
};
new n_SilahIslem[MAX_PLAYERS][n_oSilahData];
new n_bCount = 0, n_PreHook[6];

public OnGameModeInit()
{
	n_PreHook[0] = funcidx("_nHook_OnPlayerConnect") != -1;
	n_PreHook[1] = funcidx("_nHook_OnPlayerDisconnect") != -1;
	n_PreHook[2] = funcidx("_nHook_OnPlayerEnterDynamicArea") != -1;
	n_PreHook[3] = funcidx("_nHook_OnPlayerLeaveDynamicArea") != -1;
	n_PreHook[4] = funcidx("_nHook_OnPlayerWeaponShot") != -1;
	n_PreHook[5] = funcidx("_nHook_OnPlayerTakeDamage") != -1;
	if (funcidx("_nHook_OnGameModeInit") != -1)
	{
		return CallLocalFunction("_nHook_OnGameModeInit", "");
	}
	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit _nHook_OnGameModeInit
forward _nHook_OnGameModeInit();

public OnPlayerConnect(playerid)
{
    for(new n_oSilahData: n; n < n_oSilahData; n++) n_SilahIslem[playerid][n] = 0;
	if (n_PreHook[0])
	{
		return CallLocalFunction("_nHook_OnPlayerConnect", "i",playerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect _nHook_OnPlayerConnect
forward _nHook_OnPlayerConnect(playerid);

public OnPlayerDisconnect(playerid, reason)
{
    DeletePVar(playerid, "n_SpawnBolgesindeyim");
    DeletePVar(playerid, "n_TempCount");
    for(new n_oSilahData: n; n < n_oSilahData; n++) n_SilahIslem[playerid][n] = 0;
	if (n_PreHook[1])
	{
		return CallLocalFunction("_nHook_OnPlayerDisconnect", "ii",playerid,  reason);
	}
	return 1;
}

#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect _nHook_OnPlayerDisconnect
forward _nHook_OnPlayerDisconnect(playerid,  reason);

public OnPlayerEnterDynamicArea(playerid, areaid)
{
	for(new i = 0; i < N_MAX_BOLGE-1; i ++)
	{
		if(areaid == n_BolgeIslem[i][n_sID])
		{
		    SetPVarInt(playerid, "n_SpawnBolgesindeyim", 1);
		    SetPVarInt(playerid, "n_TempCount", 1);
 			new n_TempSilahId = 0, n_TempMermi;
			for(new n = 0; n < 13; n++)
			{
				GetPlayerWeaponData(playerid, n, n_TempSilahId, n_TempMermi);
				if(n_TempSilahId != 0)
				{
					n_SilahIslem[playerid][n_Silah][n] = n_TempSilahId;
					n_SilahIslem[playerid][n_Mermi][n] = n_TempMermi;
				}
			}
	    	ResetPlayerWeapons(playerid);
		}
	}
	if(n_PreHook[2])
	{
	    return CallLocalFunction("_nHook_OnPlayerEnterDynamicArea", "ii", playerid, areaid);
	}
	return 1;
}

#if defined _ALS_OnPlayerEnterDynamicArea
	#undef OnPlayerEnterDynamicArea
#else
	#define _ALS_OnPlayerEnterDynamicArea
#endif
#define OnPlayerEnterDynamicArea _nHook_OnPlayerEnterDynamicArea
forward _nHook_OnPlayerEnterDynamicArea(playerid, areaid);

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
	for(new i = 0; i < N_MAX_BOLGE-1; i ++)
	{
		if(areaid == n_BolgeIslem[i][n_sID])
		{
		    DeletePVar(playerid, "n_SpawnBolgesindeyim");
		    DeletePVar(playerid, "n_TempCount");
	    	for(new n = 0; n < 13; n++)
			{
			    if(n_SilahIslem[playerid][n_Silah][n] != 0)
			    {
					GivePlayerWeapon(playerid, n_SilahIslem[playerid][n_Silah][n], n_SilahIslem[playerid][n_Mermi][n]);
			    }
			}
		}
	}
	if(n_PreHook[3])
	{
	    return CallLocalFunction("_nHook_OnPlayerLeaveDynamicArea", "ii", playerid, areaid);
	}
	return 1;
}

#if defined _ALS_OnPlayerLeaveDynamicArea
	#undef OnPlayerLeaveDynamicArea
#else
	#define _ALS_OnPlayerLeaveDynamicArea
#endif
#define OnPlayerLeaveDynamicArea _nHook_OnPlayerLeaveDynamicArea
forward _nHook_OnPlayerLeaveDynamicArea(playerid, areaid);

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(GetPVarInt(playerid, "n_SpawnBolgesindeyim") == 1)
	{
	    switch(weaponid)
	    {
	        case 0..46:
			{
				ResetPlayerWeapons(playerid);
    	    	if(GetPVarInt(playerid, "n_TempCount") == 1)
	    		{
	        		SendClientMessage(playerid, 0x3DCFFFFF, "Uyari: {FFFFFF}Spawn bolgesinde silah kullanamazsin !");
	        		SetPVarInt(playerid, "n_TempCount", GetPVarInt(playerid, "n_TempCount")+1);
	    		}
			}
	    }
	}
	if(n_PreHook[4])
	{
	    return CallLocalFunction("_nHook_OnPlayerWeaponShot", "iiiifff", playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
	}
    return 1;
}

#if defined _ALS_OnPlayerWeaponShot
	#undef OnPlayerWeaponShot
#else
	#define _ALS_OnPlayerWeaponShot
#endif
#define OnPlayerWeaponShot _nHook_OnPlayerWeaponShot
forward _nHook_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
    if(issuerid != INVALID_PLAYER_ID)
    {
        if(GetPVarInt(playerid, "n_SpawnBolgesindeyim") == 1)
        {
            new Float: n_HP[2];
            GetPlayerHealth(playerid, n_HP[0]);
            GetPlayerArmour(playerid, n_HP[1]);
            if(n_HP[1] > 1.0)
            {
                SetPlayerArmour(playerid, n_HP[1]+amount);
            }else if(n_HP[1] < 0)
            {
				if(n_HP[0] > 1.0)
				{
					SetPlayerHealth(playerid, n_HP[0]+amount);
				}
            }
        }
    }
    if(n_PreHook[5])
    {
    	return CallLocalFunction("_nHook_OnPlayerTakeDamage", "iifii", playerid, issuerid, Float: amount, weaponid, bodypart);
    }
    return 1;
}

#if defined _ALS_OnPlayerTakeDamage
	#undef OnPlayerTakeDamage
#else
	#define _ALS_OnPlayerTakeDamage
#endif
#define OnPlayerTakeDamage _nHook_OnPlayerTakeDamage
forward _nHook_OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart);

stock n_sBolgeOlustur(Float:_n_minx, Float:_n_miny, Float:_n_maxx, Float:_n_maxy, _n_worldid = -1, _n_interiorid = -1, _n_playerid = -1)
{
    n_bCount++;
    if(n_bCount >= N_MAX_BOLGE) return printf(" -> Spawn Bolgesi: Maksimum spawn bolge ekleme limitine ulasildi !");
    n_BolgeIslem[n_bCount][n_minx] = _n_minx;
    n_BolgeIslem[n_bCount][n_miny] = _n_miny;
    n_BolgeIslem[n_bCount][n_maxx] = _n_maxx;
    n_BolgeIslem[n_bCount][n_maxy] = _n_maxy;
    n_BolgeIslem[n_bCount][n_worldid] = _n_worldid;
    n_BolgeIslem[n_bCount][n_interiorid] = _n_interiorid;
    n_BolgeIslem[n_bCount][n_playerid] = _n_playerid;
    n_BolgeIslem[n_bCount][temp_a] = 1;
    n_BolgeIslem[n_bCount][n_sID] = CreateDynamicRectangle(_n_minx, _n_miny, _n_maxx, _n_maxy, _n_worldid, _n_interiorid, _n_playerid);
    printf(" -> Spawn Bolgesi: %d adet koruma bolgesi olusturuldu. [%d/%d]", n_bCount, n_bCount, N_MAX_BOLGE-1);
	return 1;
}

stock n_sBolgeSil(playerid, n_BolgeID)
{
    new n[85];
	if(n_BolgeIslem[n_BolgeID][temp_a] == 0)
	{
	    format(n, sizeof(n), "Uyari: {FFFFFF}Kaldirmak istediginiz %d id'li spawn bolgesi olusturulmamis.", n_BolgeID);
	    SendClientMessage(playerid, 0x3DCFFFFF, n);
		return 1;
	}
	format(n, sizeof(n), "Bilgi: {FFFFFF}Şuanda %d id'li spawn bölgesini kaldırdınız.", n_BolgeID);
	SendClientMessage(playerid, 0x3DCFFFFF, n);
 	n_BolgeIslem[n_BolgeID][n_minx] = 0.0;
	n_BolgeIslem[n_BolgeID][n_miny] = 0.0;
	n_BolgeIslem[n_BolgeID][n_maxx] = 0.0;
	n_BolgeIslem[n_BolgeID][n_maxy] = 0.0;
	n_BolgeIslem[n_BolgeID][n_worldid] = -1;
	n_BolgeIslem[n_BolgeID][n_interiorid] = -1;
	n_BolgeIslem[n_BolgeID][n_playerid] = -1;
	n_BolgeIslem[n_BolgeID][temp_a] = 0;
	DestroyDynamicArea(n_BolgeIslem[n_BolgeID][n_sID]);
	return 1;
}