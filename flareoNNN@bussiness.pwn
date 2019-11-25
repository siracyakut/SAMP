/*
					   __ _                      _   _ _   _ _   _
					  / _| |                    | \ | | \ | | \ | |
					 | |_| | __ _ _ __ ___  ___ |  \| |  \| |  \| |
					 |  _| |/ _` | '__/ _ \/ _ \| . ` | . ` | . ` |
					 | | | | (_| | | |  __/ (_) | |\  | |\  | |\  |
					 |_| |_|\__,_|_|  \___|\___/|_| \_|_| \_|_| \_|
*/

// - Include
#include <a_samp>
#include <a_mysql>
#include <sscanf2>
#include <foreach>
#include <streamer>
#include <izcmd>
#include <mSelection>

// - Pragma
#pragma dynamic 			100000

// - Define
#define MAX_DUKKAN			500

// - Deðiþkenler
new bool: ArabaAliyor[MAX_PLAYERS];
new aracliste = mS_INVALID_LISTID;

new MySQL: db;

enum dukkanvars
{
	dID,
	dSahip[24],
	dArac[3],
	dAracModel[3],
	Float: dAracPos1[4],
	Float: dAracPos2[4],
	Float: dAracPos3[4],
	Text3D: dAracLabel[3],
	dFiyat,
	Text3D: dLabel,
	dPickup,
	Float: dX,
	Float: dY,
	Float: dZ
}
new dData[MAX_DUKKAN][dukkanvars];
new dAracMod[MAX_DUKKAN][3][14];
new Iterator: dukkanlar<MAX_DUKKAN>;

// - Publicler
public OnFilterScriptInit()
{
	db = mysql_connect("127.0.0.1", "root", "", "dukkan");
	mysql_log(ALL);

	if(mysql_errno(db) == 0)
	{
		print("<< DÜKKAN >> MySQL Baðlantýsý baþarýlý!");
	}
	else
	{
		print("<< DÜKKAN >> MySQL Baðlantýsý baþarýsýz!");
		SendRconCommand("exit");
		return false;
	}

	mysql_query(db, "CREATE TABLE IF NOT EXISTS `dukkanlar` (\
	`id` int(11) NOT NULL,\
	`sahip` varchar(24) NOT NULL,\
	`fiyat` int(11) NOT NULL,\
	`araclar` varchar(2048) NOT NULL,\
	`aracmodlar` varchar(2048) NOT NULL,\
	`x` float NOT NULL,\
	`y` float NOT NULL,\
	`z` float NOT NULL\
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;");

	mysql_query(db, "ALTER TABLE `dukkanlar`\
	ADD UNIQUE KEY `id` (`id`);");

	DukkanYukle();

	aracliste = LoadModelSelectionMenu("dukkan_arac.txt");
	return true;
}

public OnFilterScriptExit()
{
	foreach(new id: dukkanlar)
	{
		dData[id][dID] = -1;
		format(dData[id][dSahip], 24, "Yok");
		DestroyVehicle(dData[id][dArac][0]);
		DestroyVehicle(dData[id][dArac][1]);
		DestroyVehicle(dData[id][dArac][2]);
		for(new i; i < 3; i++)
		{
			dData[id][dArac][i] = -1;
			dData[id][dAracModel][i] = -1;
			if(IsValidDynamic3DTextLabel(dData[id][dAracLabel][i]))
				DestroyDynamic3DTextLabel(dData[id][dAracLabel][i]);
		}
		for(new i; i < 4; i++)
		{
			dData[id][dAracPos1][i] = 0.0;
			dData[id][dAracPos2][i] = 0.0;
			dData[id][dAracPos3][i] = 0.0;
		}
		for(new i; i < 3; i++)
		{
			for(new q; q < 14; q++)
			{
				dAracMod[id][i][q] = 0;
			}
		}
		dData[id][dFiyat] = 0;
		dData[id][dX] = 0.0;
		dData[id][dY] = 0.0;
		dData[id][dZ] = 0.0;

		if(IsValidDynamic3DTextLabel(dData[id][dLabel]))
			DestroyDynamic3DTextLabel(dData[id][dLabel]);

		if(IsValidDynamicPickup(dData[id][dPickup]))
			DestroyDynamicPickup(dData[id][dPickup]);

		Iter_Remove(dukkanlar, id);
	}
	return true;
}

public OnPlayerConnect(playerid)
{
	ArabaAliyor[playerid] = false;
	return true;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(ArabaAliyor[playerid] == true)
	{
		new slot = GetPVarInt(playerid, "slot"), id = GetPVarInt(playerid, "dukkan");
		dData[id][dAracModel][slot] = -1;
		DestroyVehicle(dData[id][dArac][slot]);
		dData[id][dArac][slot] = -1;
		for(new q; q < 14; q++)
		{
			dAracMod[id][slot][q] = 0;
		}
		DukkanGuncelle(id);
		ArabaAliyor[playerid] = false;
	}
	return true;
}

public OnPlayerModelSelection(playerid, response, listid, modelid)
{
	if(listid == aracliste)
	{
		if(!response) return true;
		if(response)
		{
			new id = GetPVarInt(playerid, "dukkan"), slot, Float: x, Float: y, Float: z, Float: f;
			for(new i; i < 3; i++)
			{
				if(dData[id][dAracModel][i] != -1) continue;
				slot = i;
				break;
			}
			if(slot < 0 || slot > 2) return true;
			SetPVarInt(playerid, "slot", slot);
			ArabaAliyor[playerid] = true;
			GetPlayerPos(playerid, x, y, z);
			GetPlayerFacingAngle(playerid, f);
			dData[id][dAracModel][slot] = modelid;
			dData[id][dArac][slot] = CreateVehicle(modelid, x, y, z, f, 0, 0, 999999, 0);
			PutPlayerInVehicle(playerid, dData[id][dArac][slot], 0);
			for(new q; q < 14; q++)
			{
				dAracMod[id][slot][q] = 0;
			}
			SendClientMessage(playerid, -1, "Aracýn yerini belirleyin ve \"/dukkanparket\" yazýn.");
		}
	}
	return true;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(ArabaAliyor[playerid] == true && oldstate == PLAYER_STATE_DRIVER)
	{
		new id = GetPVarInt(playerid, "dukkan"), slot = GetPVarInt(playerid, "slot");
		PutPlayerInVehicle(playerid, dData[id][dArac][slot], 0);
	}
	return true;
}

// - Komutlar
CMD:dukkanparket(playerid, params[])
{
	if(ArabaAliyor[playerid] == false) return SendClientMessage(playerid, -1, "Araba satýn almýyorsunuz.");

	new id = GetPVarInt(playerid, "dukkan"), slot = GetPVarInt(playerid, "slot"), Float: x, Float: y, Float: z, Float: f;
	GetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);
	GetVehicleZAngle(GetPlayerVehicleID(playerid), f);

	if(slot == 0)
	{
		dData[id][dAracPos1][0] = x;
		dData[id][dAracPos1][1] = y;
		dData[id][dAracPos1][2] = z;
		dData[id][dAracPos1][3] = f;
	}
	else if(slot == 1)
	{
		dData[id][dAracPos2][0] = x;
		dData[id][dAracPos2][1] = y;
		dData[id][dAracPos2][2] = z;
		dData[id][dAracPos2][3] = f;
	}
	else if(slot == 2)
	{
		dData[id][dAracPos3][0] = x;
		dData[id][dAracPos3][1] = y;
		dData[id][dAracPos3][2] = z;
		dData[id][dAracPos3][3] = f;
	}

	RemovePlayerFromVehicle(playerid);
	DukkanGuncelle(id);

	SendClientMessage(playerid, -1, "Araç baþarýyla satýn alýndý ve kaydedildi!");

	ArabaAliyor[playerid] = false;
	return true;
}

CMD:dukkanaracal(playerid, params[])
{
	if(GetPlayerMoney(playerid) < 1000000) return SendClientMessage(playerid, -1, "Dükkana araba almak için $1.000.000 para gerekmektedir.");
	new isim[MAX_PLAYER_NAME];
	GetPlayerName(playerid, isim, MAX_PLAYER_NAME);
	foreach(new i: dukkanlar)
	{
		if(!strcmp(dData[i][dSahip], isim))
		{
			if(dData[i][dAracModel][0] == -1 || dData[i][dAracModel][1] == -1 || dData[i][dAracModel][2] == -1)
			{
				SetPVarInt(playerid, "dukkan", i);
				return ShowModelSelectionMenu(playerid, aracliste, "Satilik Araclar");
			}
			else
			{
				return SendClientMessage(playerid, -1, "En fazla 3 araç alabilirsiniz!");
			}
		}
	}
	SendClientMessage(playerid, -1, "Bir dükkanýnýz yok!");
	return true;
}

CMD:dukkanisat(playerid, params[])
{
	new isim[MAX_PLAYER_NAME];
	GetPlayerName(playerid, isim, MAX_PLAYER_NAME);

	foreach(new i: dukkanlar)
	{
		if(!strcmp(dData[i][dSahip], isim))
		{
			format(dData[i][dSahip], 24, "Yok");
			GivePlayerMoney(playerid, dData[i][dFiyat] / 2);

			DestroyVehicle(dData[i][dArac][0]);
			DestroyVehicle(dData[i][dArac][1]);
			DestroyVehicle(dData[i][dArac][2]);
			for(new r; r < 3; r++)
			{
				dData[i][dArac][r] = -1;
				dData[i][dAracModel][r] = -1;
				if(IsValidDynamic3DTextLabel(dData[i][dAracLabel][r]))
					DestroyDynamic3DTextLabel(dData[i][dAracLabel][r]);
			}
			for(new r; r < 4; r++)
			{
				dData[i][dAracPos1][r] = 0.0;
				dData[i][dAracPos2][r] = 0.0;
				dData[i][dAracPos3][r] = 0.0;
			}
			for(new r; r < 3; r++)
			{
				for(new q; q < 14; q++)
				{
					dAracMod[i][r][q] = 0;
				}
			}

			DukkanGuncelle(i);

			return SendClientMessage(playerid, -1, "Dükkan satýldý.");
		}
		else return SendClientMessage(playerid, -1, "Bir dükkanýnýz yok!");
	}
	return true;
}

CMD:dukkanisatinal(playerid, params[])
{
	new isim[MAX_PLAYER_NAME];
	GetPlayerName(playerid, isim, MAX_PLAYER_NAME);
	foreach(new i: dukkanlar)
	{
		if(!strcmp(dData[i][dSahip], isim)) return SendClientMessage(playerid, -1, "Zaten bir dükkanýnýz var.");
	}

	foreach(new i: dukkanlar)
	{
		if(IsPlayerInRangeOfPoint(playerid, 1.0, dData[i][dX], dData[i][dY], dData[i][dZ]))
		{
			if(GetPlayerMoney(playerid) < dData[i][dFiyat]) return SendClientMessage(playerid, -1, "Dükkaný alabilmek için yeterli paranýz yok.");
			if(strcmp(dData[i][dSahip], "Yok", true)) return SendClientMessage(playerid, -1, "Bu dükkanýn bir sahibi zaten var.");

			format(dData[i][dSahip], 24, "%s", isim);
			GivePlayerMoney(playerid, -dData[i][dFiyat]);

			DukkanGuncelle(i);

			return SendClientMessage(playerid, -1, "Dükkaný baþarýyla satýn aldýnýz.");
		}
	}
	SendClientMessage(playerid, -1, "Bir dükkanýn üzerinde deðilsiniz.");
	return true;
}

CMD:dukkanyarat(playerid, params[])
{
	new fiyat, id = Iter_Free(dukkanlar), Float: x, Float: y, Float: z, str[512], sql[500];
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, "Bu komutu kullanabilmek için RCON admin olmalýsýn.");
	if(sscanf(params, "d", fiyat)) return SendClientMessage(playerid, -1, "/dukkanyarat [fiyat]");
	if(fiyat < 1) return SendClientMessage(playerid, -1, "Geçersiz fiyat.");
	if(id == -1) return SendClientMessage(playerid, -1, "Dükkan sýnýrý \"500\" dolmuþ.");

	GetPlayerPos(playerid, x, y, z);

	dData[id][dID] = id;
	format(dData[id][dSahip], 24, "Yok");
	for(new i; i < 3; i++)
	{
		dData[id][dArac][i] = -1;
		dData[id][dAracModel][i] = -1;
	}
	for(new i; i < 4; i++)
	{
		dData[id][dAracPos1][i] = 0.0;
		dData[id][dAracPos2][i] = 0.0;
		dData[id][dAracPos3][i] = 0.0;
	}
	for(new i; i < 3; i++)
	{
		for(new q; q < 14; q++)
		{
			dAracMod[id][i][q] = 0;
		}
	}
	dData[id][dFiyat] = fiyat;
	dData[id][dX] = x;
	dData[id][dY] = y;
	dData[id][dZ] = z;

	format(str, sizeof(str), "{00BFFF}Dükkan {0095FF}#%d\n\n{00BFFF}Sahip: {0095FF}%s\n{00BFFF}Fiyat: {0095FF}$%d\n{00BFFF}Araç Sayýsý: {0095FF}3", 
		id, dData[id][dSahip], dData[id][dFiyat]);
	dData[id][dLabel] = CreateDynamic3DTextLabel(str, -1, dData[id][dX], dData[id][dY], dData[id][dZ], 35.0);

	dData[id][dPickup] = CreateDynamicPickup(1239, 1, dData[id][dX], dData[id][dY], dData[id][dZ]);

	Iter_Add(dukkanlar, id);

	format(sql, sizeof(sql), "INSERT INTO `dukkanlar` (`id`, `sahip`, `fiyat`, `araclar`, `aracmodlar`, `x`, `y`, `z`) VALUES \
		('%d', 'Yok', '%d', '-', '-', '%f', '%f', '%f')", 
		id, fiyat, x, y, z);
	mysql_query(db, sql);

	DukkanGuncelle(id);

	SendClientMessage(playerid, -1, "Dükkan oluþturuldu.");
	return true;
}

CMD:dukkansil(playerid, params[])
{
	new id, sql[500];
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, "Bu komutu kullanabilmek için RCON admin olmalýsýn.");
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "/dukkansil [id]");
	if(!Iter_Contains(dukkanlar, id)) return SendClientMessage(playerid, -1, "Böyle bir dükkan mevcut deðil.");
	if(id > 500) return SendClientMessage(playerid, -1, "Dükkan sýnýrý \"500\" dolmuþ.");

	dData[id][dID] = -1;
	format(dData[id][dSahip], 24, "Yok");
	DestroyVehicle(dData[id][dArac][0]);
	DestroyVehicle(dData[id][dArac][1]);
	DestroyVehicle(dData[id][dArac][2]);
	for(new i; i < 3; i++)
	{
		dData[id][dArac][i] = -1;
		dData[id][dAracModel][i] = -1;
		if(IsValidDynamic3DTextLabel(dData[id][dAracLabel][i]))
			DestroyDynamic3DTextLabel(dData[id][dAracLabel][i]);
	}
	for(new i; i < 4; i++)
	{
		dData[id][dAracPos1][i] = 0.0;
		dData[id][dAracPos2][i] = 0.0;
		dData[id][dAracPos3][i] = 0.0;
	}
	for(new i; i < 3; i++)
	{
		for(new q; q < 14; q++)
		{
			dAracMod[id][i][q] = 0;
		}
	}
	dData[id][dFiyat] = 0;
	dData[id][dX] = 0.0;
	dData[id][dY] = 0.0;
	dData[id][dZ] = 0.0;

	if(IsValidDynamic3DTextLabel(dData[id][dLabel]))
		DestroyDynamic3DTextLabel(dData[id][dLabel]);

	if(IsValidDynamicPickup(dData[id][dPickup]))
		DestroyDynamicPickup(dData[id][dPickup]);

	Iter_Remove(dukkanlar, id);

	format(sql, sizeof(sql), "DELETE FROM `dukkanlar` WHERE `id` = '%d'", id);
	mysql_query(db, sql);

	SendClientMessage(playerid, -1, "Dükkan silindi.");
	return true;
}

// - Fonksiyonlar
stock DukkanGuncelle(id)
{
	new sql[2048], str[2048], str2[2048];
	format(sql, sizeof(sql), "UPDATE `dukkanlar` SET `sahip` = '%s', `araclar` = '%d,%d,%d,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f' WHERE `id` = '%d'", 
		dData[id][dSahip], dData[id][dAracModel][0], dData[id][dAracModel][1], dData[id][dAracModel][2], 
		dData[id][dAracPos1][0], dData[id][dAracPos1][1], dData[id][dAracPos1][2], dData[id][dAracPos1][3], 
		dData[id][dAracPos2][0], dData[id][dAracPos2][1], dData[id][dAracPos2][2], dData[id][dAracPos2][3], 
		dData[id][dAracPos3][0], dData[id][dAracPos3][1], dData[id][dAracPos3][2], dData[id][dAracPos3][3], id);
	mysql_query(db, sql);

	for(new i; i < 3; i++)
	{
		for(new x; x < 14; x++)
		{
			format(str2, sizeof(str2), "%s%d,", str2, dAracMod[id][i][x]);
		}
		if(i != 2)
		{
			new uzun = strlen(str2);
			str2[uzun - 1] = '|';
		}
	}
	strdel(str2, strlen(str2) - 1, strlen(str2));
	format(sql, sizeof(sql), "UPDATE `dukkanlar` SET `aracmodlar` = '%s' WHERE `id` = '%d'", str2, id);
	mysql_query(db, sql);

	format(str, sizeof(str), "{00BFFF}Dükkan {0095FF}#%d\n\n{00BFFF}Sahip: {0095FF}%s\n{00BFFF}Fiyat: {0095FF}$%d\n{00BFFF}Araç Sayýsý: {0095FF}3", 
		id, dData[id][dSahip], dData[id][dFiyat]);
	UpdateDynamic3DTextLabelText(dData[id][dLabel], -1, str);

	for(new i; i < 3; i++)
	{
		DestroyVehicle(dData[id][dArac][i]);
		dData[id][dArac][i] = -1;
	}

	if(dData[id][dAracModel][0] != -1)
	{
		dData[id][dArac][0] = CreateVehicle(dData[id][dAracModel][0], dData[id][dAracPos1][0], dData[id][dAracPos1][1], dData[id][dAracPos1][2], dData[id][dAracPos1][3], 0, 0, 999999, 0);
	}
	if(dData[id][dAracModel][1] != -1)
	{
		dData[id][dArac][1] = CreateVehicle(dData[id][dAracModel][1], dData[id][dAracPos2][0], dData[id][dAracPos2][1], dData[id][dAracPos2][2], dData[id][dAracPos2][3], 0, 0, 999999, 0);
	}
	if(dData[id][dAracModel][2] != -1)
	{
		dData[id][dArac][2] = CreateVehicle(dData[id][dAracModel][2], dData[id][dAracPos3][0], dData[id][dAracPos3][1], dData[id][dAracPos3][2], dData[id][dAracPos3][3], 0, 0, 999999, 0);
	}

	for(new i; i < 3; i++)
	{
		if(IsValidDynamic3DTextLabel(dData[id][dAracLabel][i]))
			DestroyDynamic3DTextLabel(dData[id][dAracLabel][i]);

		if(dData[id][dAracModel][i] != -1)
		{
			format(str, sizeof(str), "{0095FF}%d {00BFFF}ID'li dükkana aittir. Sahip: {0095FF}%s", id, dData[id][dSahip]);
			dData[id][dAracLabel][i] = CreateDynamic3DTextLabel(str, -1, 0.0, 0.0, 1.0, 35.0, .attachedvehicle = dData[id][dArac][i]);
		}
	}
	return true;
}

stock DukkanYukle()
{
	Iter_Clear(dukkanlar);

	new yuklenen, id, araclar[500], str[512], aracmodlar[2048], modsatir[3][500];
	mysql_query(db, "SELECT * FROM `dukkanlar` LIMIT 500");

	if(cache_num_rows() > 0)
	{
		while(yuklenen < cache_num_rows())
		{
			cache_get_value_name_int(yuklenen, "id", id);
			dData[id][dID] = id;
			cache_get_value_name(yuklenen, "sahip", dData[id][dSahip], 24);
			cache_get_value_name_int(yuklenen, "fiyat", dData[id][dFiyat]);
			cache_get_value_name(yuklenen, "araclar", araclar, 500);
			cache_get_value_name_float(yuklenen, "x", dData[id][dX]);
			cache_get_value_name_float(yuklenen, "y", dData[id][dY]);
			cache_get_value_name_float(yuklenen, "z", dData[id][dZ]);

			sscanf(araclar, "p<,>dddffffffffffff", dData[id][dAracModel][0], dData[id][dAracModel][1], dData[id][dAracModel][2], 
				dData[id][dAracPos1][0], dData[id][dAracPos1][1], dData[id][dAracPos1][2], dData[id][dAracPos1][3], 
				dData[id][dAracPos2][0], dData[id][dAracPos2][1], dData[id][dAracPos2][2], dData[id][dAracPos2][3], 
				dData[id][dAracPos3][0], dData[id][dAracPos3][1], dData[id][dAracPos3][2], dData[id][dAracPos3][3]);

			if(dData[id][dAracModel][0] != -1) dData[id][dArac][0] = CreateVehicle(dData[id][dAracModel][0], dData[id][dAracPos1][0], dData[id][dAracPos1][1], dData[id][dAracPos1][2], dData[id][dAracPos1][3], 0, 0, 999999, 0);
			if(dData[id][dAracModel][1] != -1) dData[id][dArac][1] = CreateVehicle(dData[id][dAracModel][1], dData[id][dAracPos2][0], dData[id][dAracPos2][1], dData[id][dAracPos2][2], dData[id][dAracPos2][3], 0, 0, 999999, 0);
			if(dData[id][dAracModel][2] != -1) dData[id][dArac][2] = CreateVehicle(dData[id][dAracModel][2], dData[id][dAracPos3][0], dData[id][dAracPos3][1], dData[id][dAracPos3][2], dData[id][dAracPos3][3], 0, 0, 999999, 0);

			for(new i; i < 3; i++)
			{
				if(dData[id][dAracModel][i] != -1)
				{
					format(str, sizeof(str), "{0095FF}%d {00BFFF}ID'li dükkana aittir. Sahip: {0095FF}%s", id, dData[id][dSahip]);
					dData[id][dAracLabel][i] = CreateDynamic3DTextLabel(str, -1, 0.0, 0.0, 1.0, 35.0, .attachedvehicle = dData[id][dArac][i]);
				}
			}

			cache_get_value_name(yuklenen, "aracmodlar", aracmodlar, 2048);
			sscanf(aracmodlar, "p<|>s[500]s[500]s[500]", modsatir[0], modsatir[1], modsatir[2]);
			for(new i; i < 3; i++)
			{
				sscanf(modsatir[i], "p<,>iiiiiiiiiiiiii", dAracMod[id][i][0], dAracMod[id][i][1], dAracMod[id][i][2], dAracMod[id][i][3], 
					dAracMod[id][i][4], dAracMod[id][i][5], dAracMod[id][i][6], dAracMod[id][i][7], dAracMod[id][i][8], dAracMod[id][i][9], 
					dAracMod[id][i][10], dAracMod[id][i][11], dAracMod[id][i][12], dAracMod[id][i][13]);
			}
			for(new i; i < 3; i++)
			{
				for(new x; x < 14; x++)
				{
					if(dAracMod[id][i][x] != 0)
					{
						AddVehicleComponent(dData[id][dArac][i], dAracMod[id][i][x]);
					}
				}
			}

			format(str, sizeof(str), "{00BFFF}Dükkan {0095FF}#%d\n\n{00BFFF}Sahip: {0095FF}%s\n{00BFFF}Fiyat: {0095FF}$%d\n{00BFFF}Araç Sayýsý: {0095FF}3", 
				id, dData[id][dSahip], dData[id][dFiyat]);
			dData[id][dLabel] = CreateDynamic3DTextLabel(str, -1, dData[id][dX], dData[id][dY], dData[id][dZ], 35.0);

			dData[id][dPickup] = CreateDynamicPickup(1239, 1, dData[id][dX], dData[id][dY], dData[id][dZ]);

			Iter_Add(dukkanlar, id);
			yuklenen++;
		}
	}

	printf("<< DÜKKAN >> Toplam %d dükkan yüklendi.", yuklenen);
	return true;
}
