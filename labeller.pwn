#include <a_samp>
#include <streamer>
#include <izcmd>

#pragma dynamic 100000

new GenelTimer;
new Text3D: label[MAX_PLAYERS];
new Oyuncu_Renkleri[] =
{
	0xFF8C13FF, 0xC715FFFF, 0x20B2AAFF, 0xDC143CFF, 0x6495EDFF, 0xf0e68cFF, 0x778899FF, 0xFF1493FF, 0xF4A460FF, 
	0xEE82EEFF, 0xFFD720FF, 0x8b4513FF, 0x4949A0FF, 0x148b8bFF, 0x14ff7fFF, 0x556b2fFF, 0x0FD9FAFF, 0x10DC29FF, 
	0x534081FF, 0x0495CDFF, 0xEF6CE8FF, 0xBD34DAFF, 0x247C1BFF, 0x0C8E5DFF, 0x635B03FF, 0xCB7ED3FF, 0x65ADEBFF, 
	0x5C1ACCFF, 0xF2F853FF, 0x11F891FF, 0x7B39AAFF, 0x53EB10FF, 0x54137DFF, 0x275222FF, 0xF09F5BFF, 0x3D0A4FFF, 
	0x22F767FF, 0xD63034FF, 0x9A6980FF, 0xDFB935FF, 0x3793FAFF, 0x90239DFF, 0xE9AB2FFF, 0xAF2FF3FF, 0x057F94FF, 
	0xB98519FF, 0x388EEAFF, 0x028151FF, 0xA55043FF, 0x0DE018FF, 0x93AB1CFF, 0x95BAF0FF, 0x369976FF, 0x18F71FFF, 
	0x4B8987FF, 0x491B9EFF, 0x829DC7FF, 0xBCE635FF, 0xCEA6DFFF, 0x20D4ADFF, 0x2D74FDFF, 0x3C1C0DFF, 0x12D6D4FF, 
	0x48C000FF, 0x2A51E2FF, 0xE3AC12FF, 0xFC42A8FF, 0x2FC827FF, 0x1A30BFFF, 0xB740C2FF, 0x42ACF5FF, 0x2FD9DEFF, 
	0xFAFB71FF, 0x05D1CDFF, 0xC471BDFF, 0x94436EFF, 0xC1F7ECFF, 0xCE79EEFF, 0xBD1EF2FF, 0x93B7E4FF, 0x3214AAFF, 
	0x184D3BFF, 0xAE4B99FF, 0x7E49D7FF, 0x4C436EFF, 0xFA24CCFF, 0xCE76BEFF, 0xA04E0AFF, 0x9F945CFF, 0xDCDE3DFF, 
	0x10C9C5FF, 0x70524DFF, 0x0BE472FF, 0x8A2CD7FF, 0x6152C2FF, 0xCF72A9FF, 0xE59338FF, 0xEEDC2DFF, 0xD8C762FF, 
	0xD8C762FF, 0xFF8C13FF, 0xC715FFFF, 0x20B2AAFF, 0xDC143CFF, 0x6495EDFF, 0xf0e68cFF, 0x778899FF, 0xFF1493FF, 
	0xF4A460FF, 0xEE82EEFF, 0xFFD720FF, 0x8b4513FF, 0x4949A0FF, 0x148b8bFF, 0x14ff7fFF, 0x556b2fFF, 0x0FD9FAFF, 
	0x10DC29FF, 0x534081FF, 0x0495CDFF, 0xEF6CE8FF, 0xBD34DAFF, 0x247C1BFF, 0x0C8E5DFF, 0x635B03FF, 0xCB7ED3FF, 
	0x65ADEBFF, 0x5C1ACCFF, 0xF2F853FF, 0x11F891FF, 0x7B39AAFF, 0x53EB10FF, 0x54137DFF, 0x275222FF, 0xF09F5BFF, 
	0x3D0A4FFF, 0x22F767FF, 0xD63034FF, 0x9A6980FF, 0xDFB935FF, 0x3793FAFF, 0x90239DFF, 0xE9AB2FFF, 0xAF2FF3FF, 
	0x057F94FF, 0xB98519FF, 0x388EEAFF, 0x028151FF, 0xA55043FF, 0x0DE018FF, 0x93AB1CFF, 0x95BAF0FF, 0x369976FF, 
	0x18F71FFF, 0x4B8987FF, 0x491B9EFF, 0x829DC7FF, 0xBCE635FF, 0xCEA6DFFF, 0x20D4ADFF, 0x2D74FDFF, 0x3C1C0DFF, 
	0x12D6D4FF, 0x48C000FF, 0x2A51E2FF, 0xE3AC12FF, 0xFC42A8FF, 0x2FC827FF, 0x1A30BFFF, 0xB740C2FF, 0x42ACF5FF, 
	0x2FD9DEFF, 0xFAFB71FF, 0x05D1CDFF, 0xC471BDFF, 0x94436EFF, 0xC1F7ECFF, 0xCE79EEFF, 0xBD1EF2FF, 0x93B7E4FF, 
	0x3214AAFF, 0x184D3BFF, 0xAE4B99FF, 0x7E49D7FF, 0x4C436EFF, 0xFA24CCFF, 0xCE76BEFF, 0xA04E0AFF, 0x9F945CFF, 
	0xDCDE3DFF, 0x10C9C5FF, 0x70524DFF, 0x0BE472FF, 0x8A2CD7FF, 0x6152C2FF, 0xCF72A9FF, 0xE59338FF, 0xEEDC2DFF, 
	0xD8C762FF, 0xD8C762FF
};

public OnFilterScriptInit()
{
    GenelTimer = SetTimer("LabelTimer", 500, true);
    ShowNameTags(0);
    return true;
}

public OnFilterScriptExit()
{
    KillTimer(GenelTimer);
    return true;
}

public OnPlayerConnect(playerid)
{
    SetPlayerColor(playerid, Oyuncu_Renkleri[random(sizeof(Oyuncu_Renkleri))]);

    if(IsValidDynamic3DTextLabel(label[playerid]))
        DestroyDynamic3DTextLabel(label[playerid]);

    label[playerid] = CreateDynamic3DTextLabel("_", -1, 0.0, 0.0, 0.7, 50.0, playerid);
    return true;
}

public OnPlayerDisconnect(playerid, reason)
{
    if(IsValidDynamic3DTextLabel(label[playerid]))
        DestroyDynamic3DTextLabel(label[playerid]);
    return true;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(IsValidDynamic3DTextLabel(label[playerid]))
	{
	    new i = playerid, str2[500], str[2048];
	    str2 = "{8A0000}- {FF0000}ÖLÜ {8A0000}-";
		format(str, sizeof(str), "{%06x}%s ({B3B3B3}%d{%06x})\n{%06x}[%s{%06x}]", GetPlayerColor(i) >>> 8,
                getName(i), i, GetPlayerColor(i) >>> 8, GetPlayerColor(i) >>> 8, str2, GetPlayerColor(i) >>> 8);
        UpdateDynamic3DTextLabelText(label[i], -1, str);
	}
	return true;
}

forward LabelTimer();
public LabelTimer()
{
    new Float: can, Float: zirh, duzcan, duzzirh, str[2048], str2[2048], xd1, xd2;
    for(new i, j = GetPlayerPoolSize(); i <= j; i++)
    {
        if(IsPlayerConnected(i))
        {
            if(GetPlayerState(i) == PLAYER_STATE_WASTED) return true;
        
            str2 = "";
            
            GetPlayerHealth(i, can);
            GetPlayerArmour(i, zirh);

			if(zirh > 0.0)
            {
                duzzirh = floatround(zirh);

                xd1 = 100 / 25;
                xd2 = duzzirh / xd1;
                for(new x; x < 25; x++)
                {
                    if(x < xd2)
                    {
                        format(str2, sizeof(str2), "%s{FFFFFF}I", str2);
                    }
                    else
                    {
                        format(str2, sizeof(str2), "%s{8A8A8A}I", str2);
                    }
                }
            }
            else
            {
                duzcan = floatround(can);

                xd1 = 100 / 25;
                xd2 = duzcan / xd1;
                for(new x; x < 25; x++)
                {
                    if(x < xd2)
                    {
                        format(str2, sizeof(str2), "%s{FF0000}I", str2);
                    }
                    else
                    {
                        format(str2, sizeof(str2), "%s{8A0000}I", str2);
                    }
                }
            }

            format(str, sizeof(str), "{%06x}%s ({B3B3B3}%d{%06x})\n{%06x}[%s{%06x}]", GetPlayerColor(i) >>> 8, 
                getName(i), i, GetPlayerColor(i) >>> 8, GetPlayerColor(i) >>> 8, str2, GetPlayerColor(i) >>> 8);
            UpdateDynamic3DTextLabelText(label[i], -1, str);
        }
    }
    return true;
}

stock getName(playerid)
{
    new isim[MAX_PLAYER_NAME];
    GetPlayerName(playerid, isim, MAX_PLAYER_NAME);
    return isim;
}

CMD:zirh(playerid, params[])
{
	SetPlayerArmour(playerid, 100.0);
	return true;
}

CMD:can(playerid, params[])
{
	SetPlayerHealth(playerid, 100.0);
	return true;
}

CMD:silah(playerid, params[])
{
	GivePlayerWeapon(playerid, 24, 3131);
	return true;
}
