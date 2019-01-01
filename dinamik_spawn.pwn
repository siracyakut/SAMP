/*
					   __ _                      _   _ _   _ _   _
					  / _| |                    | \ | | \ | | \ | |
					 | |_| | __ _ _ __ ___  ___ |  \| |  \| |  \| |
					 |  _| |/ _` | '__/ _ \/ _ \| . ` | . ` | . ` |
					 | | | | (_| | | |  __/ (_) | |\  | |\  | |\  |
					 |_| |_|\__,_|_|  \___|\___/|_| \_|_| \_|_| \_|

								 DINAMIK SPAWN SISTEMI
								 01/07/2018 - 14:36
*/

#include <a_samp>
#include <a_mysql>
#include <sscanf2>
#include <izcmd>
#include <YSI\y_iterate>

#define MYSQL_HOST			"127.0.0.1"
#define MYSQL_USER 			"root"
#define MYSQL_PASS			""
#define MYSQL_DB 			"spawn_alanlari"
#define MAX_SPAWN			(100)
#define SCM 				SendClientMessage
#define DIALOG_SPAWNLAR		(1597)
#define DIALOG_SPAWN_EKLE	(1598)
#define DIALOG_SPAWN_SIL	(1599)

new MySQL: db;
enum spawnVars
{
	sID,
	Float: sX,
	Float: sY,
	Float: sZ,
	Text3D: sLabel
}
new sData[MAX_SPAWN][spawnVars];
new Iterator: spawnlar<MAX_SPAWN>;
new idler[MAX_PLAYERS][MAX_SPAWN];

public OnFilterScriptInit()
{
	db = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB);
	if(mysql_errno(db) == 0)
	{
		print("\n>> MySQL baðlantýsý baþarýlý.\n");
	}
	else
	{
		print("\n>> MySQL baðlantýsý baþarýsýz!\n");
	}

	mysql_query(db, "CREATE TABLE IF NOT EXISTS `spawnlar` (\
	`id` int(11) NOT NULL,\
	`koordinat` varchar(100) NOT NULL\
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;");

	mysql_query(db, "ALTER TABLE `spawnlar`\
	ADD PRIMARY KEY (`id`);");

	SpawnlariYukle();
	return true;
}

public OnFilterScriptExit()
{
	foreach(new i: spawnlar)
	{
		sData[i][sID] = -1;
		sData[i][sX] = 0;
		sData[i][sY] = 0;
		sData[i][sZ] = 0;
		Delete3DTextLabel(sData[i][sLabel]);
	}
	Iter_Clear(spawnlar);
	mysql_close(db);
	return true;
}

public OnPlayerSpawn(playerid)
{
	if(Iter_Count(spawnlar) > 0)
	{
		new id = Iter_Random(spawnlar);
		SetPlayerPos(playerid, sData[id][sX], sData[id][sY], sData[id][sZ]);
	}
	return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_SPAWNLAR)
	{
		if(!response) return true;
		if(response)
		{
			if(listitem == GetPVarInt(playerid, "sayi"))
			{
				ShowPlayerDialog(playerid, DIALOG_SPAWN_EKLE, DIALOG_STYLE_MSGBOX, "{FFB300}» {FFFFFF}Spawn Ekle", "{FFB300}» {FFFFFF}Bulunduðunuz yeri spawn bölgesi olarak kaydetmek istiyor musunuz?", "{FFB300}» {FFFFFF}Evet", "{FFB300}» {FFFFFF}Hayýr");
			}
			else
			{
				SetPVarInt(playerid, "silinecek", idler[playerid][listitem]);
				ShowPlayerDialog(playerid, DIALOG_SPAWN_SIL, DIALOG_STYLE_MSGBOX, "{FFB300}» {FFFFFF}Spawn Sil", "{FFB300}» {FFFFFF}Seçtiðiniz spawn bölgesini silmek istiyor musunuz?", "{FFB300}» {FFFFFF}Evet", "{FFB300}» {FFFFFF}Hayýr");
			}
		}
	}

	if(dialogid == DIALOG_SPAWN_EKLE)
	{
		if(!response) return cmd_spawnlar(playerid, "");
		if(response)
		{
			if(!IsPlayerAdmin(playerid)) return SCM(playerid, -1, "{FFB300}» {FFFFFF}Bu komutu kullanabilmek için RCON Admin olmalýsýnýz.");
			new sql[500], Float: x, Float: y, Float: z, id = Iter_Free(spawnlar);
			GetPlayerPos(playerid, x, y, z);
			format(sql, sizeof(sql), "INSERT INTO `spawnlar` (`id`, `koordinat`) VALUES ('%d', '%f|%f|%f')", id, x, y, z);
			mysql_query(db, sql);
			sData[id][sID] = id;
			sData[id][sX] = x;
			sData[id][sY] = y;
			sData[id][sZ] = z;
			format(sql, sizeof(sql), "{FFB300}»» {FFFFFF}Spawn Bölgesi %d {FFB300}««", id);
			sData[id][sLabel] = Create3DTextLabel(sql, -1, x, y, z, 35.0, 0, 0);
			SCM(playerid, -1, "{FFB300}» {FFFFFF}Spawn alaný baþarýlý bir þeklide eklendi.");
			Iter_Add(spawnlar, id);
		}
	}

	if(dialogid == DIALOG_SPAWN_SIL)
	{
		if(!response) return cmd_spawnlar(playerid, "");
		if(response)
		{
			if(!IsPlayerAdmin(playerid)) return SCM(playerid, -1, "{FFB300}» {FFFFFF}Bu komutu kullanabilmek için RCON Admin olmalýsýnýz.");
			new id = GetPVarInt(playerid, "silinecek"), sql[128];
			sData[id][sID] = -1;
			sData[id][sX] = 0;
			sData[id][sY] = 0;
			sData[id][sZ] = 0;
			Delete3DTextLabel(sData[id][sLabel]);
			Iter_Remove(spawnlar, id);
			format(sql, sizeof(sql), "DELETE FROM `spawnlar` WHERE `id` = '%d'", id);
			mysql_query(db, sql);
			SCM(playerid, -1, "{FFB300}» {FFFFFF}Spawn bölgesi baþarýyla silindi!");
		}
	}
	return true;
}

stock SpawnlariYukle()
{
	Iter_Clear(spawnlar);
	new deger, id, koordinat[100];
	mysql_query(db, "SELECT * FROM `spawnlar`");
	if(cache_num_rows() > 0)
	{
		while(deger < cache_num_rows())
		{
			cache_get_value_name_int(deger, "id", id);
			cache_get_value_name(deger, "koordinat", koordinat, 100);
			sData[id][sID] = id;
			sscanf(koordinat, "p<|>fff", sData[id][sX], sData[id][sY], sData[id][sZ]);
			Iter_Add(spawnlar, id);
			format(koordinat, sizeof(koordinat), "{FFB300}»» {FFFFFF}Spawn Bölgesi %d {FFB300}««", id);
			sData[id][sLabel] = Create3DTextLabel(koordinat, -1, sData[id][sX], sData[id][sY], sData[id][sZ], 35.0, 0, 0);
			deger++;
		}
	}
	printf("\n>> Toplam %d spawn bölgesi yüklendi.\n", deger);
	return true;
}

CMD:spawnlar(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, -1, "{FFB300}» {FFFFFF}Bu komutu kullanabilmek için RCON Admin olmalýsýnýz.");
	new str[1024], Float: x, Float: y, Float: z, koordinat[100], id;
	mysql_query(db, "SELECT * FROM `spawnlar`");
	strcat(str, "{FFB300}» {FFFFFF}ID\t{FFB300}» {FFFFFF}X\t{FFB300}» {FFFFFF}Y\t{FFB300}» {FFFFFF}Z\n");
	for(new i = 0; i < cache_num_rows(); i++)
	{
		cache_get_value_name_int(i, "id", id);
		cache_get_value_name(i, "koordinat", koordinat, 100);
		sscanf(koordinat, "p<|>fff", x, y, z);
		format(str, sizeof(str), "%s{FFB300}» {FFFFFF}%d\t%f\t%f\t%f\n", str, id, x, y, z);
		idler[playerid][i] = id;
	}
	strcat(str, "{FFB300}» {FFFFFF}Spawn\tEkle\n");
	SetPVarInt(playerid, "sayi", cache_num_rows());
	ShowPlayerDialog(playerid, DIALOG_SPAWNLAR, DIALOG_STYLE_TABLIST_HEADERS, "{FFB300}» {FFFFFF}Spawn Bölgeleri", str, "{FFB300}» {FFFFFF}Seç", "{FFB300}» {FFFFFF}Kapat");
	return true;
}

CMD:kill(playerid, params[])
{
	SetPlayerHealth(playerid, 0.0);
	return true;
}