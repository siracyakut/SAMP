/*
					   __ _                      _   _ _   _ _   _
					  / _| |                    | \ | | \ | | \ | |
					 | |_| | __ _ _ __ ___  ___ |  \| |  \| |  \| |
					 |  _| |/ _` | '__/ _ \/ _ \| . ` | . ` | . ` |
					 | | | | (_| | | |  __/ (_) | |\  | |\  | |\  |
					 |_| |_|\__,_|_|  \___|\___/|_| \_|_| \_|_| \_|

								 SKIN SECIM SISTEMI
								 28/05/2018 - 17:30
*/

#include <a_samp>
#include <izcmd>

#define DIALOG_SKINSECIM    (1518)

new Text: SkinSecim[MAX_PLAYERS][6];

public OnFilterScriptInit()
{
	for(new i = 0; i <= GetMaxPlayers(); i++)
	{
		SkinSecim[i][0] = TextDrawCreate(191.610580, 112.416656, "box");
		TextDrawLetterSize(SkinSecim[i][0], 0.000000, 24.805267);
		TextDrawTextSize(SkinSecim[i][0], 434.000000, 0.000000);
		TextDrawAlignment(SkinSecim[i][0], 1);
		TextDrawColor(SkinSecim[i][0], -1);
		TextDrawUseBox(SkinSecim[i][0], 1);
		TextDrawBoxColor(SkinSecim[i][0], 68);
		TextDrawSetShadow(SkinSecim[i][0], 0);
		TextDrawSetOutline(SkinSecim[i][0], 0);
		TextDrawBackgroundColor(SkinSecim[i][0], 255);
		TextDrawFont(SkinSecim[i][0], 1);
		TextDrawSetProportional(SkinSecim[i][0], 1);
		TextDrawSetShadow(SkinSecim[i][0], 0);

		SkinSecim[i][1] = TextDrawCreate(257.503601, 124.666702, "");
		TextDrawLetterSize(SkinSecim[i][1], 0.000000, 0.000000);
		TextDrawTextSize(SkinSecim[i][1], 112.000000, 144.000000);
		TextDrawAlignment(SkinSecim[i][1], 1);
		TextDrawColor(SkinSecim[i][1], -1);
		TextDrawSetShadow(SkinSecim[i][1], 0);
		TextDrawSetOutline(SkinSecim[i][1], 0);
		TextDrawBackgroundColor(SkinSecim[i][1], 0);
		TextDrawFont(SkinSecim[i][1], 5);
		TextDrawSetProportional(SkinSecim[i][1], 0);
		TextDrawSetShadow(SkinSecim[i][1], 0);
		TextDrawSetPreviewModel(SkinSecim[i][1], 0);
		TextDrawSetPreviewRot(SkinSecim[i][1], 0.000000, 0.000000, 0.000000, 1.000000);

		SkinSecim[i][2] = TextDrawCreate(290.468475, 276.916595, "~r~~h~~h~ID: ~g~~h~~h~310");
		TextDrawLetterSize(SkinSecim[i][2], 0.400000, 1.600000);
		TextDrawAlignment(SkinSecim[i][2], 1);
		TextDrawColor(SkinSecim[i][2], -1);
		TextDrawSetShadow(SkinSecim[i][2], 0);
		TextDrawSetOutline(SkinSecim[i][2], 1);
		TextDrawBackgroundColor(SkinSecim[i][2], 51);
		TextDrawFont(SkinSecim[i][2], 1);
		TextDrawSetProportional(SkinSecim[i][2], 1);
		TextDrawSetShadow(SkinSecim[i][2], 0);

		SkinSecim[i][3] = TextDrawCreate(267.342681, 303.166748, "ld_beat:left");
		TextDrawLetterSize(SkinSecim[i][3], 0.000000, 0.000000);
		TextDrawTextSize(SkinSecim[i][3], 25.000000, 24.000000);
		TextDrawAlignment(SkinSecim[i][3], 1);
		TextDrawColor(SkinSecim[i][3], -1);
		TextDrawSetShadow(SkinSecim[i][3], 0);
		TextDrawSetOutline(SkinSecim[i][3], 0);
		TextDrawBackgroundColor(SkinSecim[i][3], 255);
		TextDrawFont(SkinSecim[i][3], 4);
		TextDrawSetProportional(SkinSecim[i][3], 0);
		TextDrawSetShadow(SkinSecim[i][3], 0);
		TextDrawSetSelectable(SkinSecim[i][3], 1);

		SkinSecim[i][4] = TextDrawCreate(339.547088, 303.166748, "ld_beat:right");
		TextDrawLetterSize(SkinSecim[i][4], 0.000000, 0.000000);
		TextDrawTextSize(SkinSecim[i][4], 25.000000, 24.000000);
		TextDrawAlignment(SkinSecim[i][4], 1);
		TextDrawColor(SkinSecim[i][4], -1);
		TextDrawSetShadow(SkinSecim[i][4], 0);
		TextDrawSetOutline(SkinSecim[i][4], 0);
		TextDrawBackgroundColor(SkinSecim[i][4], 255);
		TextDrawFont(SkinSecim[i][4], 4);
		TextDrawSetProportional(SkinSecim[i][4], 0);
		TextDrawSetShadow(SkinSecim[i][4], 0);
		TextDrawSetSelectable(SkinSecim[i][4], 1);

		SkinSecim[i][5] = TextDrawCreate(275.475952, 96.083328, "~p~Skin Secimi");
		TextDrawLetterSize(SkinSecim[i][5], 0.526968, 2.305833);
		TextDrawAlignment(SkinSecim[i][5], 1);
		TextDrawColor(SkinSecim[i][5], -1);
		TextDrawSetShadow(SkinSecim[i][5], 0);
		TextDrawSetOutline(SkinSecim[i][5], 1);
		TextDrawBackgroundColor(SkinSecim[i][5], 255);
		TextDrawFont(SkinSecim[i][5], 0);
		TextDrawSetProportional(SkinSecim[i][5], 1);
		TextDrawSetShadow(SkinSecim[i][5], 0);
	}
	
	print("\nflareoNNN - Skin Secim Sistemi Yuklendi.\n");
	return true;
}

public OnFilterScriptExit()
{
	for(new i = 0; i <= GetMaxPlayers(); i++)
	{
	    for(new x = 0; x < 6; x++)
	    {
	        TextDrawHideForPlayer(i, SkinSecim[i][x]);
	        TextDrawDestroy(SkinSecim[i][x]);
	    }
	}
	
	print("\nflareoNNN - Skin Secim Sistemi Kapatildi.\n");
	return true;
}

public OnPlayerConnect(playerid)
{
	SetPVarInt(playerid, "gosteriliyor", 0);
	SetPVarInt(playerid, "skin_secim", 0);
	return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_SKINSECIM)
	{
		if(!response)
	    {
	    	for(new i = 0; i < 6; i++)
	        {
	            TextDrawHideForPlayer(playerid, SkinSecim[playerid][i]);
	        }
	    }
	    if(response)
	    {
	        new str_x[128];

	        for(new i = 0; i < 6; i++)
	        {
	            TextDrawHideForPlayer(playerid, SkinSecim[playerid][i]);
	        }

	        SetPlayerSkin(playerid, GetPVarInt(playerid, "skin_secim"));

	        format(str_x, sizeof(str_x), "{FFA200}<< {FFFFFF}Bilgi {FFA200}>> {FFFFFF}Skininiz baþarýyla güncellendi! (ID: {FFA200}%d{FFFFFF})", GetPVarInt(playerid, "skin_secim"));
	        SendClientMessage(playerid, -1, str_x);
	    }
	}
	return true;
}

public OnPlayerClickTextDraw(playerid, Text: clickedid)
{
	if(clickedid == Text: INVALID_TEXT_DRAW)
	{
	    if(GetPVarInt(playerid, "gosteriliyor") == 1)
	    {
	        ShowPlayerDialog(playerid, DIALOG_SKINSECIM, DIALOG_STYLE_MSGBOX, "{FFA200}Skin Seçimi", "{FFFFFF}En son seçtiðiniz skini almak istiyor musunuz?", "{00F600}Evet", "{FF0000}Hayýr");
            SetPVarInt(playerid, "gosteriliyor", 0);
		}
	    return true;
	}
	
	new str[50];
	if(clickedid == SkinSecim[playerid][4])
	{
	    if(GetPVarInt(playerid, "skin_secim") > 310) return PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0), true;

		format(str, sizeof(str), "~r~~h~~h~ID: ~g~~h~~h~%d", GetPVarInt(playerid, "skin_secim") + 1);
		TextDrawSetString(SkinSecim[playerid][2], str);

		TextDrawSetPreviewModel(SkinSecim[playerid][1], GetPVarInt(playerid, "skin_secim") + 1);
		TextDrawShowForPlayer(playerid, SkinSecim[playerid][1]);

		SetPVarInt(playerid, "skin_secim", GetPVarInt(playerid, "skin_secim") + 1);
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		return true;
	}

	if(clickedid == SkinSecim[playerid][3])
	{
		if(GetPVarInt(playerid, "skin_secim") <= 0) return PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0), true;

		format(str, sizeof(str), "~r~~h~~h~ID: ~g~~h~~h~%d", GetPVarInt(playerid, "skin_secim") - 1);
		TextDrawSetString(SkinSecim[playerid][2], str);

		TextDrawSetPreviewModel(SkinSecim[playerid][1], GetPVarInt(playerid, "skin_secim") - 1);
		TextDrawShowForPlayer(playerid, SkinSecim[playerid][1]);

		SetPVarInt(playerid, "skin_secim", GetPVarInt(playerid, "skin_secim") - 1);
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		return true;
	}
	return false;
}

CMD:skinler(playerid)
{
	new str[50];
	SetPVarInt(playerid, "skin_secim", 0);
	SetPVarInt(playerid, "gosteriliyor", 1);
	for(new i = 0; i < 6; i++)
	{
	    TextDrawShowForPlayer(playerid, SkinSecim[playerid][i]);
	}
	
	format(str, sizeof(str), "~r~~h~~h~ID: ~g~~h~~h~%d", GetPVarInt(playerid, "skin_secim"));
	TextDrawSetString(SkinSecim[playerid][2], str);
	
	TextDrawSetPreviewModel(SkinSecim[playerid][1], GetPVarInt(playerid, "skin_secim"));
	TextDrawShowForPlayer(playerid, SkinSecim[playerid][1]);
	
	SelectTextDraw(playerid, 0x00FF00AA);
	
	SendClientMessage(playerid, -1, "{FFA200}<< {FFFFFF}Bilgi {FFA200}>> {FFFFFF}Skin seçiminizi yaptýðýnýzda {FFA200}\"ESC\" {FFFFFF}tuþuna basabilirsiniz.");
	return true;
}
