#include "a_samp"
#include "zcmd"

#define MAX_PARA 500

enum paraVeri
{
	pPickup,
	Text3D: pLabel,
	pDeger,
	bool: pVar,
	pTimer
}
new pData[MAX_PARA][paraVeri];
new Float: posx[MAX_PLAYERS][3];

public OnPlayerDeath(playerid, killerid, reason)
{
	GetPlayerPos(playerid, posx[playerid][0], posx[playerid][1], posx[playerid][2]);
	
	SetTimerEx("Drop", 4000, false, "ddfff", playerid, GetPlayerMoney(playerid), posx[playerid][0], posx[playerid][1], posx[playerid][2]);
	return true;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_WASTED) return true;
	
	for(new i; i < MAX_PARA; i++)
	{
	    if(pickupid == pData[i][pPickup] && pData[i][pVar] == true)
	    {
	        GivePlayerMoney(playerid, pData[i][pDeger]);
	        
	    	pData[i][pVar] = false;
			DestroyPickup(pData[i][pPickup]);
			Delete3DTextLabel(pData[i][pLabel]);
			pData[i][pLabel] = Text3D: INVALID_3DTEXT_ID;
			pData[i][pDeger] = 0;
			KillTimer(pData[i][pTimer]);
			break;
	    }
	}
	return true;
}

CMD:kill(playerid) return SetPlayerHealth(playerid, 0.0);
CMD:para(playerid) return GivePlayerMoney(playerid, 999999);
CMD:go(playerid) return SetPlayerPos(playerid, posx[playerid][0] + 10, posx[playerid][1], posx[playerid][2]);

stock GetID()
{
	for(new i; i < MAX_PARA; i++)
	{
	    if(pData[i][pVar] == false) return i;
	}
	return -1;
}

stock randomEx(min, max)
{
	return random(max - min) + min;
}

forward Drop(playerid, mny, Float: x, Float: y, Float: z);
public Drop(playerid, mny, Float: x, Float: y, Float: z)
{
	if(mny >= 10)
	{
	    new bol = mny / 10;
	    new str[64];

	    format(str, sizeof(str), "{00902c}( {00d742}$%d {00902c})", bol);

	    for(new i; i < 10; i++)
	    {
	        new id = GetID();
	    	new xboost = random(3) - random(3);
	    	new yboost = random(3) - random(3);

		    pData[id][pVar] = true;
		    pData[id][pPickup] = CreatePickup(1212, 1, x + xboost, y + yboost, z - 0.5, 0);
		    pData[id][pLabel] = Create3DTextLabel(str, -1, x + xboost, y + yboost, z - 0.5, 15.0, 0);
		    pData[id][pDeger] = bol;

			pData[id][pTimer] = SetTimerEx("Delete", 30000, false, "d", id);
	    }
	}
	return true;
}

forward Delete(id);
public Delete(id)
{
  pData[id][pVar] = false;
  DestroyPickup(pData[id][pPickup]);
  Delete3DTextLabel(pData[id][pLabel]);
  pData[id][pLabel] = Text3D: INVALID_3DTEXT_ID;
  pData[id][pDeger] = 0;
  KillTimer(pData[id][pTimer]);
  return true;
}
