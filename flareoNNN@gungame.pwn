#include <a_samp>
#include <foreach>
#include <gvar>
#include <izcmd>

#define function%0(%1) 	forward %0(%1); public %0(%1)
#define SCM             SendClientMessage

new Iterator: GGL<MAX_PLAYERS>;
new Float: GGPos[][] =
{
//	X           Y          Z        A
	{1314.0756, 2108.4871, 11.0156, 338.0312},
	{1330.2604, 2111.4509, 11.0156, 285.1818},
	{1344.2887, 2115.3184, 11.0156, 285.4116},
	{1354.1132, 2126.2024, 11.0156, 330.4116},
	{1341.8070, 2136.2429, 11.0156, 34.0975},
	{1329.6571, 2144.5186, 11.0156, 58.2244},
	{1324.5974, 2156.3748, 11.0234, 18.4744},
	{1313.3184, 2166.8308, 11.0234, 58.2244},
	{1325.8174, 2177.3738, 11.0234, 306.9740},
	{1343.1202, 2178.0291, 11.0234, 261.9740},
	{1359.2811, 2179.1021, 11.0156, 261.9740},
	{1378.5459, 2181.5947, 11.0234, 273.2240}
};
new GGWeapon[][] =
{
//	ID   MERMI MODEL
	{23, 3131, 347},
	{28, 3131, 352},
	{29, 3131, 353},
	{30, 3131, 355},
	{31, 3131, 356},
	{33, 3131, 357},
	{34, 3131, 358},
	{9, 3131, 341},
	{24, 3131, 348}
};
new Text: GunGameTD[MAX_PLAYERS][36] = {Text: INVALID_TEXT_DRAW, ...};
new TDRenk[] =
{
	0xFFFFFFFF,
	0xFFF6F6FF,
	0xFFEEEEFF,
	0xFFE6E6FF,
	0xFFDEDEFF,
	0xFFD5D5FF,
	0xFFCDCDFF,
	0xFFC5C5FF,
	0xFFBDBDFF,
	0xFFB4B4FF,
	0xFFACACFF,
	0xFFA4A4FF,
	0xFF9C9CFF,
	0xFF9494FF,
	0xFF8B8BFF,
	0xFF8383FF,
	0xFF7B7BFF,
	0xFF7373FF,
	0xFF6A6AFF,
	0xFF6262FF,
	0xFF5A5AFF,
	0xFF5252FF,
	0xFF4A4AFF,
	0xFF4141FF,
	0xFF3939FF,
	0xFF3131FF,
	0xFF2929FF,
	0xFF2020FF,
	0xFF1818FF,
	0xFF1010FF,
	0xFF0808FF,
	0xFF0000FF,
	0xFF0000FF
};

public OnFilterScriptInit()
{
	SetGVarInt("GG_Genel_Timer", _:(SetTimer("GGBaslat", 600000, true))); // 10 dakika
	return true;
}

public OnFilterScriptExit()
{
	KillTimer(_:GetGVarInt("GG_Genel_Timer"));
	return true;
}

public OnPlayerConnect(playerid)
{
	TD_Add(playerid);
	return true;
}

public OnPlayerDisconnect(playerid, reason)
{
	TD_Remove(playerid);
	return true;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(playerid != INVALID_PLAYER_ID && killerid != INVALID_PLAYER_ID)
	{
	    if(Iter_Contains(GGL, playerid) && Iter_Contains(GGL, killerid))
	    {
	        if(GetPVarInt(killerid, "GGKill") < 3)
	        {
	            SetPVarInt(killerid, "GGKill", (GetPVarInt(killerid, "GGKill") + 1));
	        }
	        if(GetPVarInt(killerid, "GGKill") == 3)
	        {
	            SetTimerEx("LevelUp", 1000, false, "d", killerid);
	        }
	        GunGame_CheckTD(killerid);
	    }
	}
	return true;
}

public OnPlayerSpawn(playerid)
{
	if(Iter_Contains(GGL, playerid))
	{
	    GunGame_Join(playerid);
	    GunGame_CheckWeapon(playerid);
	}
	return true;
}

CMD:gg(playerid)
{
	if(GetGVarInt("GG") == 0) return SCM(playerid, -1, "Şu anda aktif gungame yok!");
	if(GetGVarInt("GG") == 2) return SCM(playerid, -1, "Gungame zaten başlamış!");
	if(Iter_Contains(GGL, playerid)) return SCM(playerid, -1, "Zaten oyundasınız!");
	
	GunGame_Join(playerid, true);
	SCM(playerid, -1, "GunGame'ye katıldınız.");
	return true;
}

CMD:ggcik(playerid)
{
	if(GetGVarInt("GG") == 0) return SCM(playerid, -1, "Şu anda aktif gungame yok!");
	if(!Iter_Contains(GGL, playerid)) return SCM(playerid, -1, "Zaten oyunda değilsiniz!");
	
	GunGame_Leave(playerid);
	SCM(playerid, -1, "GunGame'den ayrıldınız.");
	return true;
}

CMD:ggbaslat(playerid)
{
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, -1, "Bu komutu kullanabilmek için RCON Admin olmalısınız!");
	if(GetGVarInt("GG") == 1 || GetGVarInt("GG") == 2) return SCM(playerid, -1, "Gungame zaten başlamış!");
    	GGBaslat();
	return true;
}

function LevelUp(playerid)
{
	static killerid;
	killerid = playerid;
	SetPVarInt(killerid, "GGKill", 0);
	SetPVarInt(killerid, "GGLevel", GetPVarInt(killerid, "GGLevel") + 1);
	if(GetPVarInt(killerid, "GGLevel") == sizeof(GGWeapon) - 1)
	{
		return GunGame_Stop(killerid);
	}
	GunGame_CheckWeapon(killerid);
	GameTextForPlayer(killerid, "~p~LEVEL UP!", 1000, 6);
	GunGame_CheckTD(killerid);
	return true;
}

function GunGame_CountDown()
{
	new
	    	str[156],
	    	colors[][] = { "r", "g", "b", "w", "p" },
		cnt = GetGVarInt("GGCnt")
	;
	    	
	format(str, sizeof(str), "~%s~%d", colors[random(sizeof(colors))][0], cnt);
	foreach(new playerid: GGL) GameTextForPlayer(playerid, str, 1000, 6);
	SetGVarInt("GGCnt", cnt - 1);
	
	if((GetGVarInt("GGCnt")) <= -1)
	{
	    KillTimer(_:GetGVarInt("GGTimer"));
	    foreach(new playerid: GGL)
	    {
	        TogglePlayerControllable(playerid, true);
	        GunGame_CheckWeapon(playerid);
	        GunGame_TD(playerid, 1);
	        GunGame_CheckTD(playerid);
	        GameTextForPlayer(playerid, "~r~~h~~h~GO!", 1000, 6);
	    }
	}
	return true;
}

function GGBaslat()
{
	if(GetGVarInt("GG")) return true;

	SetGVarInt("GG", 1); // 1 = katılım, 2 = oyun, 0 = kapalı
	Iter_Clear(GGL);
	
	SendClientMessageToAll(-1, "GunGame başladı! Katılmak için \"/gg\" yazın!");
	SetTimer("GGReklam", 15000, false);
	SetTimer("GGBitir", 30000, false);
	return true;
}

function GGReklam() return SendClientMessageToAll(-1, "GunGame başladı! Katılmak için \"/gg\" yazın!");

function GGBitir()
{
	if(Iter_Count(GGL) <= 1)
	{
		return GunGame_Stop(-1);
	}
	
	SetGVarInt("GG", 2);
	SendClientMessageToAll(-1, "GunGame'ye katılım sonlandı! Oyun birazdan başlayacak.");
	SetGVarInt("GGCnt", 3);
	
	SetGVarInt("GGTimer", _:(SetTimer("GunGame_CountDown", 1000, true)));
	return true;
}

stock GunGame_Join(playerid, bool: first = false)
{
	new rand = random(sizeof(GGPos));
	SetPlayerPos(playerid, GGPos[rand][0], GGPos[rand][1], GGPos[rand][2]);
	SetPlayerFacingAngle(playerid, GGPos[rand][3]);
	SetCameraBehindPlayer(playerid);
	
	SetPlayerVirtualWorld(playerid, 33);
	SetPlayerHealth(playerid, 100.0);
	SetPlayerArmour(playerid, 100.0);
	
	if(first)
	{
		TogglePlayerControllable(playerid, false);
		Iter_Add(GGL, playerid);
		SetPVarInt(playerid, "GGLevel", 0);
		SetPVarInt(playerid, "GGKill", 0);
	}
	return true;
}

stock GunGame_Leave(playerid)
{
	Iter_Remove(GGL, playerid);
	SetPVarInt(playerid, "GGLevel", 0);
	SetPVarInt(playerid, "GGKill", 0);
	GunGame_TD(playerid, 0);
	
	SpawnPlayer(playerid);
	return true;
}

stock GunGame_CheckWeapon(playerid)
{
	ResetPlayerWeapons(playerid);
	new level = GetPVarInt(playerid, "GGLevel");
	GivePlayerWeapon(playerid, GGWeapon[level][0], GGWeapon[level][1]);
	return true;
}

stock GunGame_Stop(winnerid)
{
	if(winnerid != -1)
	{
		new n[MAX_PLAYER_NAME], str[156];
		GetPlayerName(winnerid, n, MAX_PLAYER_NAME);
		new slot, oyuncular[MAX_PLAYERS] = {-1, ...};
		foreach(new playerid: GGL)
		{
			oyuncular[slot] = playerid;
			slot++;
		}
		for(new i; i < sizeof(oyuncular); i++)
		{
		    	if(oyuncular[i] == -1) continue;

			GunGame_Leave(oyuncular[i]);
		}
		format(str, sizeof(str), "GunGame'i %s kazandı. Tebrikler!", n);
		SendClientMessageToAll(-1, str);
		Iter_Clear(GGL);
		SetGVarInt("GG", 0);
	}
	else
	{
		new slot, oyuncular[MAX_PLAYERS] = {-1, ...};
		foreach(new playerid: GGL)
		{
			oyuncular[slot] = playerid;
			slot++;
		}
		for(new i; i < sizeof(oyuncular); i++)
		{
		    	if(oyuncular[i] == -1) continue;
		    
			GunGame_Leave(oyuncular[i]);
		}
		SendClientMessageToAll(-1, "GunGame iptal edildi. (Yetersiz katılım)");
		Iter_Clear(GGL);
		SetGVarInt("GG", 0);
	}
	return true;
}

stock TD_Remove(playerid)
{
	for(new i; i < 36; i++)
	{
		TextDrawDestroy(GunGameTD[playerid][i]);
		GunGameTD[playerid][i] = Text: INVALID_TEXT_DRAW;
	}
	return true;
}

stock GunGame_CheckTD(playerid)
{
	new Float: s1 = floatdiv(3, 32);
	new Float: s2 = floatdiv(GetPVarInt(playerid, "GGKill"), s1);
	
	for(new i; i < 32; i++)
	{
	    if(i < s2)
	    {
	        TextDrawColor(GunGameTD[playerid][i + 1], TDRenk[i]);
	    }
	    else
	    {
	        TextDrawColor(GunGameTD[playerid][i + 1], 0x66666644);
	    }
	    TextDrawShowForPlayer(playerid, GunGameTD[playerid][i + 1]);
	}
	
	TextDrawSetPreviewModel(GunGameTD[playerid][33], GGWeapon[GetPVarInt(playerid, "GGLevel")][2]);
	TextDrawSetPreviewModel(GunGameTD[playerid][34], GGWeapon[GetPVarInt(playerid, "GGLevel") + 1][2]);
	TextDrawShowForPlayer(playerid, GunGameTD[playerid][33]);
	TextDrawShowForPlayer(playerid, GunGameTD[playerid][34]);
	
	static str[156];
	format(str, sizeof(str), "~r~~h~~h~Level: ~w~~h~~h~%d ~r~~h~~h~- Kill: ~w~~h~~h~%d", GetPVarInt(playerid, "GGLevel") + 1, GetPVarInt(playerid, "GGKill"));
	TextDrawSetString(GunGameTD[playerid][35], str);
	return true;
}

stock GunGame_TD(playerid, durum)
{
	if(durum == 0)
	{
	    for(new i; i < 36; i++) TextDrawHideForPlayer(playerid, GunGameTD[playerid][i]);
	}
	else if(durum == 1)
	{
	    for(new i; i < 36; i++) TextDrawShowForPlayer(playerid, GunGameTD[playerid][i]);
	}
	return true;
}

stock TD_Add(playerid)
{
	GunGameTD[playerid][0] = TextDrawCreate(254.392272, 348.083435, "box");
	TextDrawLetterSize(GunGameTD[playerid][0], 0.000000, 6.626646);
	TextDrawTextSize(GunGameTD[playerid][0], 405.000000, 0.000000);
	TextDrawAlignment(GunGameTD[playerid][0], 1);
	TextDrawColor(GunGameTD[playerid][0], -1);
	TextDrawUseBox(GunGameTD[playerid][0], 1);
	TextDrawBoxColor(GunGameTD[playerid][0], 102);
	TextDrawSetShadow(GunGameTD[playerid][0], 0);
	TextDrawSetOutline(GunGameTD[playerid][0], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][0], 255);
	TextDrawFont(GunGameTD[playerid][0], 1);
	TextDrawSetProportional(GunGameTD[playerid][0], 1);
	TextDrawSetShadow(GunGameTD[playerid][0], 0);

	GunGameTD[playerid][1] = TextDrawCreate(264.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][1], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][1], 1);
	TextDrawColor(GunGameTD[playerid][1], -1);
	TextDrawSetShadow(GunGameTD[playerid][1], 0);
	TextDrawSetOutline(GunGameTD[playerid][1], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][1], 255);
	TextDrawFont(GunGameTD[playerid][1], 1);
	TextDrawSetProportional(GunGameTD[playerid][1], 1);
	TextDrawSetShadow(GunGameTD[playerid][1], 0);

	GunGameTD[playerid][2] = TextDrawCreate(268.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][2], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][2], 1);
	TextDrawColor(GunGameTD[playerid][2], -1);
	TextDrawSetShadow(GunGameTD[playerid][2], 0);
	TextDrawSetOutline(GunGameTD[playerid][2], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][2], 255);
	TextDrawFont(GunGameTD[playerid][2], 1);
	TextDrawSetProportional(GunGameTD[playerid][2], 1);
	TextDrawSetShadow(GunGameTD[playerid][2], 0);

	GunGameTD[playerid][3] = TextDrawCreate(272.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][3], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][3], 1);
	TextDrawColor(GunGameTD[playerid][3], -1);
	TextDrawSetShadow(GunGameTD[playerid][3], 0);
	TextDrawSetOutline(GunGameTD[playerid][3], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][3], 255);
	TextDrawFont(GunGameTD[playerid][3], 1);
	TextDrawSetProportional(GunGameTD[playerid][3], 1);
	TextDrawSetShadow(GunGameTD[playerid][3], 0);

	GunGameTD[playerid][4] = TextDrawCreate(276.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][4], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][4], 1);
	TextDrawColor(GunGameTD[playerid][4], -1);
	TextDrawSetShadow(GunGameTD[playerid][4], 0);
	TextDrawSetOutline(GunGameTD[playerid][4], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][4], 255);
	TextDrawFont(GunGameTD[playerid][4], 1);
	TextDrawSetProportional(GunGameTD[playerid][4], 1);
	TextDrawSetShadow(GunGameTD[playerid][4], 0);

	GunGameTD[playerid][5] = TextDrawCreate(280.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][5], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][5], 1);
	TextDrawColor(GunGameTD[playerid][5], -1);
	TextDrawSetShadow(GunGameTD[playerid][5], 0);
	TextDrawSetOutline(GunGameTD[playerid][5], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][5], 255);
	TextDrawFont(GunGameTD[playerid][5], 1);
	TextDrawSetProportional(GunGameTD[playerid][5], 1);
	TextDrawSetShadow(GunGameTD[playerid][5], 0);

	GunGameTD[playerid][6] = TextDrawCreate(284.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][6], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][6], 1);
	TextDrawColor(GunGameTD[playerid][6], -1);
	TextDrawSetShadow(GunGameTD[playerid][6], 0);
	TextDrawSetOutline(GunGameTD[playerid][6], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][6], 255);
	TextDrawFont(GunGameTD[playerid][6], 1);
	TextDrawSetProportional(GunGameTD[playerid][6], 1);
	TextDrawSetShadow(GunGameTD[playerid][6], 0);

	GunGameTD[playerid][7] = TextDrawCreate(288.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][7], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][7], 1);
	TextDrawColor(GunGameTD[playerid][7], -1);
	TextDrawSetShadow(GunGameTD[playerid][7], 0);
	TextDrawSetOutline(GunGameTD[playerid][7], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][7], 255);
	TextDrawFont(GunGameTD[playerid][7], 1);
	TextDrawSetProportional(GunGameTD[playerid][7], 1);
	TextDrawSetShadow(GunGameTD[playerid][7], 0);

	GunGameTD[playerid][8] = TextDrawCreate(292.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][8], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][8], 1);
	TextDrawColor(GunGameTD[playerid][8], -1);
	TextDrawSetShadow(GunGameTD[playerid][8], 0);
	TextDrawSetOutline(GunGameTD[playerid][8], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][8], 255);
	TextDrawFont(GunGameTD[playerid][8], 1);
	TextDrawSetProportional(GunGameTD[playerid][8], 1);
	TextDrawSetShadow(GunGameTD[playerid][8], 0);

	GunGameTD[playerid][9] = TextDrawCreate(296.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][9], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][9], 1);
	TextDrawColor(GunGameTD[playerid][9], -1);
	TextDrawSetShadow(GunGameTD[playerid][9], 0);
	TextDrawSetOutline(GunGameTD[playerid][9], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][9], 255);
	TextDrawFont(GunGameTD[playerid][9], 1);
	TextDrawSetProportional(GunGameTD[playerid][9], 1);
	TextDrawSetShadow(GunGameTD[playerid][9], 0);

	GunGameTD[playerid][10] = TextDrawCreate(300.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][10], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][10], 1);
	TextDrawColor(GunGameTD[playerid][10], -1);
	TextDrawSetShadow(GunGameTD[playerid][10], 0);
	TextDrawSetOutline(GunGameTD[playerid][10], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][10], 255);
	TextDrawFont(GunGameTD[playerid][10], 1);
	TextDrawSetProportional(GunGameTD[playerid][10], 1);
	TextDrawSetShadow(GunGameTD[playerid][10], 0);

	GunGameTD[playerid][11] = TextDrawCreate(304.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][11], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][11], 1);
	TextDrawColor(GunGameTD[playerid][11], -1);
	TextDrawSetShadow(GunGameTD[playerid][11], 0);
	TextDrawSetOutline(GunGameTD[playerid][11], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][11], 255);
	TextDrawFont(GunGameTD[playerid][11], 1);
	TextDrawSetProportional(GunGameTD[playerid][11], 1);
	TextDrawSetShadow(GunGameTD[playerid][11], 0);

	GunGameTD[playerid][12] = TextDrawCreate(308.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][12], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][12], 1);
	TextDrawColor(GunGameTD[playerid][12], -1);
	TextDrawSetShadow(GunGameTD[playerid][12], 0);
	TextDrawSetOutline(GunGameTD[playerid][12], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][12], 255);
	TextDrawFont(GunGameTD[playerid][12], 1);
	TextDrawSetProportional(GunGameTD[playerid][12], 1);
	TextDrawSetShadow(GunGameTD[playerid][12], 0);

	GunGameTD[playerid][13] = TextDrawCreate(312.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][13], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][13], 1);
	TextDrawColor(GunGameTD[playerid][13], -1);
	TextDrawSetShadow(GunGameTD[playerid][13], 0);
	TextDrawSetOutline(GunGameTD[playerid][13], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][13], 255);
	TextDrawFont(GunGameTD[playerid][13], 1);
	TextDrawSetProportional(GunGameTD[playerid][13], 1);
	TextDrawSetShadow(GunGameTD[playerid][13], 0);

	GunGameTD[playerid][14] = TextDrawCreate(316.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][14], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][14], 1);
	TextDrawColor(GunGameTD[playerid][14], -1);
	TextDrawSetShadow(GunGameTD[playerid][14], 0);
	TextDrawSetOutline(GunGameTD[playerid][14], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][14], 255);
	TextDrawFont(GunGameTD[playerid][14], 1);
	TextDrawSetProportional(GunGameTD[playerid][14], 1);
	TextDrawSetShadow(GunGameTD[playerid][14], 0);

	GunGameTD[playerid][15] = TextDrawCreate(320.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][15], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][15], 1);
	TextDrawColor(GunGameTD[playerid][15], -1);
	TextDrawSetShadow(GunGameTD[playerid][15], 0);
	TextDrawSetOutline(GunGameTD[playerid][15], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][15], 255);
	TextDrawFont(GunGameTD[playerid][15], 1);
	TextDrawSetProportional(GunGameTD[playerid][15], 1);
	TextDrawSetShadow(GunGameTD[playerid][15], 0);

	GunGameTD[playerid][16] = TextDrawCreate(324.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][16], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][16], 1);
	TextDrawColor(GunGameTD[playerid][16], -1);
	TextDrawSetShadow(GunGameTD[playerid][16], 0);
	TextDrawSetOutline(GunGameTD[playerid][16], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][16], 255);
	TextDrawFont(GunGameTD[playerid][16], 1);
	TextDrawSetProportional(GunGameTD[playerid][16], 1);
	TextDrawSetShadow(GunGameTD[playerid][16], 0);

	GunGameTD[playerid][17] = TextDrawCreate(328.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][17], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][17], 1);
	TextDrawColor(GunGameTD[playerid][17], -1);
	TextDrawSetShadow(GunGameTD[playerid][17], 0);
	TextDrawSetOutline(GunGameTD[playerid][17], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][17], 255);
	TextDrawFont(GunGameTD[playerid][17], 1);
	TextDrawSetProportional(GunGameTD[playerid][17], 1);
	TextDrawSetShadow(GunGameTD[playerid][17], 0);

	GunGameTD[playerid][18] = TextDrawCreate(332.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][18], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][18], 1);
	TextDrawColor(GunGameTD[playerid][18], -1);
	TextDrawSetShadow(GunGameTD[playerid][18], 0);
	TextDrawSetOutline(GunGameTD[playerid][18], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][18], 255);
	TextDrawFont(GunGameTD[playerid][18], 1);
	TextDrawSetProportional(GunGameTD[playerid][18], 1);
	TextDrawSetShadow(GunGameTD[playerid][18], 0);

	GunGameTD[playerid][19] = TextDrawCreate(336.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][19], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][19], 1);
	TextDrawColor(GunGameTD[playerid][19], -1);
	TextDrawSetShadow(GunGameTD[playerid][19], 0);
	TextDrawSetOutline(GunGameTD[playerid][19], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][19], 255);
	TextDrawFont(GunGameTD[playerid][19], 1);
	TextDrawSetProportional(GunGameTD[playerid][19], 1);
	TextDrawSetShadow(GunGameTD[playerid][19], 0);

	GunGameTD[playerid][20] = TextDrawCreate(340.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][20], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][20], 1);
	TextDrawColor(GunGameTD[playerid][20], -1);
	TextDrawSetShadow(GunGameTD[playerid][20], 0);
	TextDrawSetOutline(GunGameTD[playerid][20], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][20], 255);
	TextDrawFont(GunGameTD[playerid][20], 1);
	TextDrawSetProportional(GunGameTD[playerid][20], 1);
	TextDrawSetShadow(GunGameTD[playerid][20], 0);

	GunGameTD[playerid][21] = TextDrawCreate(344.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][21], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][21], 1);
	TextDrawColor(GunGameTD[playerid][21], -1);
	TextDrawSetShadow(GunGameTD[playerid][21], 0);
	TextDrawSetOutline(GunGameTD[playerid][21], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][21], 255);
	TextDrawFont(GunGameTD[playerid][21], 1);
	TextDrawSetProportional(GunGameTD[playerid][21], 1);
	TextDrawSetShadow(GunGameTD[playerid][21], 0);

	GunGameTD[playerid][22] = TextDrawCreate(348.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][22], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][22], 1);
	TextDrawColor(GunGameTD[playerid][22], -1);
	TextDrawSetShadow(GunGameTD[playerid][22], 0);
	TextDrawSetOutline(GunGameTD[playerid][22], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][22], 255);
	TextDrawFont(GunGameTD[playerid][22], 1);
	TextDrawSetProportional(GunGameTD[playerid][22], 1);
	TextDrawSetShadow(GunGameTD[playerid][22], 0);

	GunGameTD[playerid][23] = TextDrawCreate(352.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][23], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][23], 1);
	TextDrawColor(GunGameTD[playerid][23], -1);
	TextDrawSetShadow(GunGameTD[playerid][23], 0);
	TextDrawSetOutline(GunGameTD[playerid][23], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][23], 255);
	TextDrawFont(GunGameTD[playerid][23], 1);
	TextDrawSetProportional(GunGameTD[playerid][23], 1);
	TextDrawSetShadow(GunGameTD[playerid][23], 0);

	GunGameTD[playerid][24] = TextDrawCreate(356.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][24], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][24], 1);
	TextDrawColor(GunGameTD[playerid][24], -1);
	TextDrawSetShadow(GunGameTD[playerid][24], 0);
	TextDrawSetOutline(GunGameTD[playerid][24], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][24], 255);
	TextDrawFont(GunGameTD[playerid][24], 1);
	TextDrawSetProportional(GunGameTD[playerid][24], 1);
	TextDrawSetShadow(GunGameTD[playerid][24], 0);

	GunGameTD[playerid][25] = TextDrawCreate(360.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][25], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][25], 1);
	TextDrawColor(GunGameTD[playerid][25], -1);
	TextDrawSetShadow(GunGameTD[playerid][25], 0);
	TextDrawSetOutline(GunGameTD[playerid][25], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][25], 255);
	TextDrawFont(GunGameTD[playerid][25], 1);
	TextDrawSetProportional(GunGameTD[playerid][25], 1);
	TextDrawSetShadow(GunGameTD[playerid][25], 0);

	GunGameTD[playerid][26] = TextDrawCreate(364.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][26], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][26], 1);
	TextDrawColor(GunGameTD[playerid][26], -1);
	TextDrawSetShadow(GunGameTD[playerid][26], 0);
	TextDrawSetOutline(GunGameTD[playerid][26], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][26], 255);
	TextDrawFont(GunGameTD[playerid][26], 1);
	TextDrawSetProportional(GunGameTD[playerid][26], 1);
	TextDrawSetShadow(GunGameTD[playerid][26], 0);

	GunGameTD[playerid][27] = TextDrawCreate(368.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][27], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][27], 1);
	TextDrawColor(GunGameTD[playerid][27], -1);
	TextDrawSetShadow(GunGameTD[playerid][27], 0);
	TextDrawSetOutline(GunGameTD[playerid][27], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][27], 255);
	TextDrawFont(GunGameTD[playerid][27], 1);
	TextDrawSetProportional(GunGameTD[playerid][27], 1);
	TextDrawSetShadow(GunGameTD[playerid][27], 0);

	GunGameTD[playerid][28] = TextDrawCreate(372.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][28], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][28], 1);
	TextDrawColor(GunGameTD[playerid][28], -1);
	TextDrawSetShadow(GunGameTD[playerid][28], 0);
	TextDrawSetOutline(GunGameTD[playerid][28], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][28], 255);
	TextDrawFont(GunGameTD[playerid][28], 1);
	TextDrawSetProportional(GunGameTD[playerid][28], 1);
	TextDrawSetShadow(GunGameTD[playerid][28], 0);

	GunGameTD[playerid][29] = TextDrawCreate(376.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][29], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][29], 1);
	TextDrawColor(GunGameTD[playerid][29], -1);
	TextDrawSetShadow(GunGameTD[playerid][29], 0);
	TextDrawSetOutline(GunGameTD[playerid][29], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][29], 255);
	TextDrawFont(GunGameTD[playerid][29], 1);
	TextDrawSetProportional(GunGameTD[playerid][29], 1);
	TextDrawSetShadow(GunGameTD[playerid][29], 0);

	GunGameTD[playerid][30] = TextDrawCreate(380.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][30], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][30], 1);
	TextDrawColor(GunGameTD[playerid][30], -1);
	TextDrawSetShadow(GunGameTD[playerid][30], 0);
	TextDrawSetOutline(GunGameTD[playerid][30], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][30], 255);
	TextDrawFont(GunGameTD[playerid][30], 1);
	TextDrawSetProportional(GunGameTD[playerid][30], 1);
	TextDrawSetShadow(GunGameTD[playerid][30], 0);

	GunGameTD[playerid][31] = TextDrawCreate(384.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][31], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][31], 1);
	TextDrawColor(GunGameTD[playerid][31], -1);
	TextDrawSetShadow(GunGameTD[playerid][31], 0);
	TextDrawSetOutline(GunGameTD[playerid][31], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][31], 255);
	TextDrawFont(GunGameTD[playerid][31], 1);
	TextDrawSetProportional(GunGameTD[playerid][31], 1);
	TextDrawSetShadow(GunGameTD[playerid][31], 0);

	GunGameTD[playerid][32] = TextDrawCreate(388.231231, 363.833312, "I");
	TextDrawLetterSize(GunGameTD[playerid][32], 0.379384, 3.105000);
	TextDrawAlignment(GunGameTD[playerid][32], 1);
	TextDrawColor(GunGameTD[playerid][32], -1);
	TextDrawSetShadow(GunGameTD[playerid][32], 0);
	TextDrawSetOutline(GunGameTD[playerid][32], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][32], 255);
	TextDrawFont(GunGameTD[playerid][32], 1);
	TextDrawSetProportional(GunGameTD[playerid][32], 1);
	TextDrawSetShadow(GunGameTD[playerid][32], 0);

	GunGameTD[playerid][33] = TextDrawCreate(258.909179, 378.416687, "");
	TextDrawLetterSize(GunGameTD[playerid][33], 0.000000, 0.000000);
	TextDrawTextSize(GunGameTD[playerid][33], 34.000000, 45.000000);
	TextDrawAlignment(GunGameTD[playerid][33], 1);
	TextDrawColor(GunGameTD[playerid][33], -1);
	TextDrawSetShadow(GunGameTD[playerid][33], 0);
	TextDrawSetOutline(GunGameTD[playerid][33], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][33], 0);
	TextDrawFont(GunGameTD[playerid][33], 5);
	TextDrawSetProportional(GunGameTD[playerid][33], 0);
	TextDrawSetShadow(GunGameTD[playerid][33], 0);
	TextDrawSetPreviewModel(GunGameTD[playerid][33], 348);
	TextDrawSetPreviewRot(GunGameTD[playerid][33], 0.000000, 0.000000, 0.000000, 1.000000);

	GunGameTD[playerid][34] = TextDrawCreate(383.281311, 378.416687, "");
	TextDrawLetterSize(GunGameTD[playerid][34], 0.000000, 0.000000);
	TextDrawTextSize(GunGameTD[playerid][34], 34.000000, 45.000000);
	TextDrawAlignment(GunGameTD[playerid][34], 1);
	TextDrawColor(GunGameTD[playerid][34], -1);
	TextDrawSetShadow(GunGameTD[playerid][34], 0);
	TextDrawSetOutline(GunGameTD[playerid][34], 0);
	TextDrawBackgroundColor(GunGameTD[playerid][34], 0);
	TextDrawFont(GunGameTD[playerid][34], 5);
	TextDrawSetProportional(GunGameTD[playerid][34], 0);
	TextDrawSetShadow(GunGameTD[playerid][34], 0);
	TextDrawSetPreviewModel(GunGameTD[playerid][34], 348);
	TextDrawSetPreviewRot(GunGameTD[playerid][34], 0.000000, 0.000000, 0.000000, 1.000000);

	GunGameTD[playerid][35] = TextDrawCreate(287.189239, 354.500122, "~r~~h~~h~Level: ~w~~h~~h~1 ~r~~h~~h~- Kill: ~w~~h~~h~3");
	TextDrawLetterSize(GunGameTD[playerid][35], 0.285679, 1.209166);
	TextDrawAlignment(GunGameTD[playerid][35], 1);
	TextDrawColor(GunGameTD[playerid][35], -1);
	TextDrawSetShadow(GunGameTD[playerid][35], 0);
	TextDrawSetOutline(GunGameTD[playerid][35], 1);
	TextDrawBackgroundColor(GunGameTD[playerid][35], 51);
	TextDrawFont(GunGameTD[playerid][35], 3);
	TextDrawSetProportional(GunGameTD[playerid][35], 1);
	TextDrawSetShadow(GunGameTD[playerid][35], 0);
	return true;
}
