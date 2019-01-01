#include 							 	<a_samp>
#include 							  	 <izcmd>
#include 							   	  <Dini>
#include 								   <GVC>

#pragma dynamic 						(100000)

#define YOL 							"SaveLoadCar/%s.txt"
#define SCM 							SendClientMessage
#define DIALOG_SAVECAR					(1)
#define DIALOG_LOADCAR					(2)

new AracMod[MAX_PLAYERS][5][18];
new aracim[MAX_PLAYERS] = -1;

public OnFilterScriptInit()
{
	print("Save-Load Car System Loaded.");
	for(new i, j = GetPlayerPoolSize(); i <= j; i++)
		OnPlayerConnect(i);
	return true;
}

public OnFilterScriptExit()
{
	print("Save-Load Car System un-Loaded.");
	for(new i, j = GetPlayerPoolSize(); i <= j; i++)
		OnPlayerDisconnect(i, 1);
	return true;
}

public OnPlayerConnect(playerid)
{
	for(new i; i < 5; i++)
	{
		AracMod[playerid][i][0] = -1;
		AracMod[playerid][i][1] = 0;
		AracMod[playerid][i][2] = 0;
		AracMod[playerid][i][3] = 3;
		for(new x; x < 14; x++)
		{
			AracMod[playerid][i][x + 4] = 0;
		}
	}
	OyuncuYukle(playerid);
	DestroyVehicle(aracim[playerid]);
	aracim[playerid] = -1;
	return true;
}

public OnPlayerDisconnect(playerid, reason)
{
	OyuncuKaydet(playerid);
	return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_SAVECAR:
		{
			if(!response) return true;

			if(AracMod[playerid][listitem][0] != -1) return SCM(playerid, -1, "Bu slot dolu!");
			new renk1, renk2;
			GetVehicleColor(GetPlayerVehicleID(playerid), renk1, renk2);
			AracMod[playerid][listitem][0] = GetVehicleModel(GetPlayerVehicleID(playerid));
			AracMod[playerid][listitem][1] = renk1;
			AracMod[playerid][listitem][2] = renk2;
			AracMod[playerid][listitem][3] = GetVehiclePaintJob(GetPlayerVehicleID(playerid));
			for(new i; i < 14; i++)
			{
				AracMod[playerid][listitem][i + 4] = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), i);
			}
			OyuncuKaydet(playerid);
			SCM(playerid, -1, "Araç baþarýyla kaydedildi!");
		}
		case DIALOG_LOADCAR:
		{
			if(!response) return true;

			if(AracMod[playerid][listitem][0] == -1) return SCM(playerid, -1, "Bu slot boþ!");
			new model = AracMod[playerid][listitem][0], Float: x, Float: y, Float: z, Float: f;
			GetPlayerPos(playerid, x, y, z);
			GetPlayerFacingAngle(playerid, f);
			if(aracim[playerid] != -1) DestroyVehicle(aracim[playerid]);
			aracim[playerid] = CreateVehicle(model, x, y, z, f, random(255), random(255), 999999, 0);
			PutPlayerInVehicle(playerid, aracim[playerid], 0);
			for(new i; i < 14; i++)
			{
				if(AracMod[playerid][listitem][i + 4] != 0)
				{
					AddVehicleComponent(GetPlayerVehicleID(playerid), AracMod[playerid][listitem][i + 4]);
				}
			}
			ChangeVehicleColor(GetPlayerVehicleID(playerid), AracMod[playerid][listitem][1], AracMod[playerid][listitem][2]);
			if(AracMod[playerid][listitem][3] != 3) ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), AracMod[playerid][listitem][3]);
			SCM(playerid, -1, "Aracýnýz baþarýyla çaðýrýldý!");
		}
	}
	return true;
}

stock OyuncuYukle(playerid)
{
	new dosya[100], veri[1024], veriler[18][156], veriler2[5][156];
	format(dosya, sizeof(dosya), YOL, Isim(playerid));
	if(dini_Exists(dosya))
	{
		format(veri, sizeof(veri), "%s", dini_Get(dosya, "araclar"));
		split(veri, veriler2, '|');
		for(new q; q != 5; q++)
		{
			split(veriler2[q], veriler, ',');
			AracMod[playerid][q][0] = strval(veriler[0]);
			AracMod[playerid][q][1] = strval(veriler[1]);
			AracMod[playerid][q][2] = strval(veriler[2]);
			AracMod[playerid][q][3] = strval(veriler[3]);
			for(new x; x < 14; x++)
			{
				AracMod[playerid][q][x + 4] = strval(veriler[x + 4]);
			}
		}
	}
	return true;
}

stock OyuncuKaydet(playerid)
{
	new dosya[100], str[1024];
	format(dosya, sizeof(dosya), YOL, Isim(playerid));
	if(dini_Exists(dosya))
	{
		for(new i; i < 5; i++)
		{
			format(str, sizeof(str), "%s%d,%d,%d,%d,", str, AracMod[playerid][i][0], AracMod[playerid][i][1], AracMod[playerid][i][2], AracMod[playerid][i][3]);
			for(new x; x < 14; x++)
			{
				format(str, sizeof(str), "%s%d,", str, AracMod[playerid][i][x + 4]);
			}
			new x = strlen(str);
			str[x - 1] = '|';
		}
		strdel(str, strlen(str) - 1, strlen(str));
		dini_Set(dosya, "araclar", str);
	}
	else
	{
		dini_Create(dosya);
		for(new i; i < 5; i++)
		{
			format(str, sizeof(str), "%s%d,%d,%d,%d,", str, AracMod[playerid][i][0], AracMod[playerid][i][1], AracMod[playerid][i][2], AracMod[playerid][i][3]);
			for(new x; x < 14; x++)
			{
				format(str, sizeof(str), "%s%d,", str, AracMod[playerid][i][x + 4]);
			}
			new x = strlen(str);
			str[x - 1] = '|';
		}
		strdel(str, strlen(str) - 1, strlen(str));
		dini_Set(dosya, "araclar", str);
	}
	return true;
}

stock Isim(playerid)
{
	new isim[MAX_PLAYER_NAME];
	GetPlayerName(playerid, isim, MAX_PLAYER_NAME);
	return isim;
}

stock split(const strsrc[], strdest[][], delimiter)
{
	new i, li, aNum, len;
	while(i <= strlen(strsrc))
	{
		if(strsrc[i] == delimiter || i == strlen(strsrc))
		{
			len = strmid(strdest[aNum], strsrc, li, i, 128);
			strdest[aNum][len] = 0;
			li = i + 1;
			aNum++;
		}
		i++;
	}
	return true;
}

CMD:savecar(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, -1, "Bir araçta olmalýsýnýz!");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SCM(playerid, -1, "Sürücü olmalýsýnýz!");
	new str[1024], durum[15];
	strcat(str, "#\t#\n");
	for(new i; i < 5; i++)
	{
		if(AracMod[playerid][i][0] == -1)
			durum = "BOÞ";
		else
			durum = "DOLU";
		format(str, sizeof(str), "%sSlot %d\t%s\n", str, i + 1, durum);
	}
	ShowPlayerDialog(playerid, DIALOG_SAVECAR, DIALOG_STYLE_TABLIST_HEADERS, "Save Car", str, "Kaydet", "Iptal");
	return true;
}

CMD:loadcar(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) return SCM(playerid, -1, "Araçtan inmelisiniz!");
	new str[1024], durum[15];
	strcat(str, "#\t#\n");
	for(new i; i < 5; i++)
	{
		if(AracMod[playerid][i][0] == -1)
			durum = "BOÞ";
		else
			durum = "DOLU";
		format(str, sizeof(str), "%sSlot %d\t%s\n", str, i + 1, durum);
	}
	ShowPlayerDialog(playerid, DIALOG_LOADCAR, DIALOG_STYLE_TABLIST_HEADERS, "Load Car", str, "Çaðýr", "Iptal");
	return true;
}

CMD:mod3(playerid, params[])
{
	SetPlayerPos(playerid, -2705.5503, 206.1621, 4.1797);
	GivePlayerMoney(playerid, 123123123);
	return true;
}

CMD:veh(playerid, params[])
{
	if(aracim[playerid] != -1) DestroyVehicle(aracim[playerid]);
	new Float: x, Float: y, Float: z, Float: f;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, f);
	aracim[playerid] = CreateVehicle(560, x, y, z, f, random(255), random(255), 999999, 0);
	PutPlayerInVehicle(playerid, aracim[playerid], 0);
	SCM(playerid, -1, "Araç verildi!");
	return true;
}
