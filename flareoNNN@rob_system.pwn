#include <a_samp>
#include <a_mysql>
#include <streamer>
#include <foreach>
#include <izcmd>

#define MAX_SOYGUN 500

new MySQL: db;
enum soygunEnum
{
	sID,
	sIsim[50],
	Float: sGirisCPX,
	Float: sGirisCPY,
	Float: sGirisCPZ,
	Float: sGirisX,
	Float: sGirisY,
	Float: sGirisZ,
	Float: sGirisF,
	Float: sCikisCPX,
	Float: sCikisCPY,
	Float: sCikisCPZ,
	Float: sCikisX,
	Float: sCikisY,
	Float: sCikisZ,
	Float: sCikisF,
	Float: sSoygunCPX,
	Float: sSoygunCPY,
	Float: sSoygunCPZ,
	sInterior,
	sVW,
	sIcon,
	sDurum,
	Text3D: sLabel,
	sSoygunCP,
	sGirisCP,
	sCikisCP
}
new sData[MAX_SOYGUN][soygunEnum];
new Iterator: soygunlar<MAX_SOYGUN>;
new SoyTimer[MAX_PLAYERS];
new SoygunSure[MAX_PLAYERS];

stock print_(mesaj[])
{
	new str[256];
	format(str, sizeof(str), "<< SOYGUN SISTEMI >> %s", mesaj);
	print(str);
	return true;
}
#define print print_

public OnFilterScriptInit()
{
	db = mysql_connect("localhost", "root", "", "rob_system");
	mysql_log(ALL);
	if(mysql_errno(db) != 0)
	{
	    print("MySQL bağlantısı başarısız.");
	}
	else
	{
	    print("MySQL bağlantısı başarılı.");
	    SoygunYukle();
	    DisableInteriorEnterExits();
	}
	
	mysql_tquery(db, "CREATE TABLE IF NOT EXISTS `soygunlar` (\
	`sid` int(3) NOT NULL,\
	`soygunIsim` varchar(50) CHARACTER SET utf8 COLLATE utf8_turkish_ci NOT NULL,\
	`gCpX` float NOT NULL,\
	`gCpY` float NOT NULL,\
	`gCpZ` float NOT NULL,\
	`GirisPosX` float NOT NULL,\
	`GirisPosY` float NOT NULL,\
	`GirisPosZ` float NOT NULL,\
	`GirisPosA` float NOT NULL,\
	`cCpX` float NOT NULL,\
	`cCpY` float NOT NULL,\
	`cCpZ` float NOT NULL,\
	`CikisPosX` float NOT NULL,\
	`CikisPosY` float NOT NULL,\
	`CikisPosZ` float NOT NULL,\
	`CikisPosA` float NOT NULL,\
	`sCpX` float NOT NULL,\
	`sCpY` float NOT NULL,\
	`sCpZ` float NOT NULL,\
	`sInterior` int(3) NOT NULL,\
	`sVW` int(3) NOT NULL,\
	`sIcon` int(2) NOT NULL DEFAULT '0'\
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;");
	
	mysql_tquery(db, "ALTER TABLE `soygunlar`\
	ADD PRIMARY KEY (`sid`);");
	return true;
}

public OnFilterScriptExit()
{
	mysql_close(db);
	return true;
}

public OnPlayerConnect(playerid)
{
	KillTimer(SoyTimer[playerid]);
	SoygunSure[playerid] = 0;
	return true;
}

public OnPlayerDisconnect(playerid, reason)
{
	KillTimer(SoyTimer[playerid]);
	SoygunSure[playerid] = 0;
	return true;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	foreach(new id: soygunlar)
	{
	    if(checkpointid == sData[id][sGirisCP])
    	{
	        SetPlayerPos(playerid, sData[id][sGirisX], sData[id][sGirisY], sData[id][sGirisZ]);
	        SetPlayerFacingAngle(playerid, sData[id][sGirisF]);
	        SetCameraBehindPlayer(playerid);
	        SetPlayerVirtualWorld(playerid, sData[id][sVW]);
	        SetPlayerInterior(playerid, sData[id][sInterior]);
	        break;
	    }
	    
	    if(checkpointid == sData[id][sCikisCP])
    	{
	        SetPlayerPos(playerid, sData[id][sCikisX], sData[id][sCikisY], sData[id][sCikisZ]);
	        SetPlayerFacingAngle(playerid, sData[id][sCikisF]);
	        SetCameraBehindPlayer(playerid);
	        SetPlayerVirtualWorld(playerid, 0);
	        SetPlayerInterior(playerid, 0);
	        break;
	    }
	    
	    if(checkpointid == sData[id][sSoygunCP])
	    {
	        if(sData[id][sDurum] != 1) return true;
	        sData[id][sDurum] = 0;
	        SoygunSure[playerid] = 20;
	        LabelGuncelle(id);
	        SoyTimer[playerid] = SetTimerEx("SoygunYapiyorum", 1000, true, "dd", playerid, id);
	        break;
	    }
	}
	return true;
}

CMD:sf(playerid, params[])
{
	SetPlayerPos(playerid, -2178.7957, -71.3587, 35.1719);
	return true;
}

stock SoygunYukle()
{
	Iter_Clear(soygunlar);
	
	new yuklenen, id, label[512];
	mysql_query(db, "SELECT * FROM `soygunlar`");
	if(cache_num_rows() > 0)
	{
	    while(yuklenen < cache_num_rows())
	    {
	        cache_get_value_name_int(yuklenen, "sid", id);
	        sData[id][sID] = id;
	        cache_get_value_name(yuklenen, "soygunIsim", sData[id][sIsim], 50);
	        cache_get_value_name_float(yuklenen, "gCpX", sData[id][sGirisCPX]);
	        cache_get_value_name_float(yuklenen, "gCpY", sData[id][sGirisCPY]);
	        cache_get_value_name_float(yuklenen, "gCpZ", sData[id][sGirisCPZ]);
	        cache_get_value_name_float(yuklenen, "GirisPosX", sData[id][sGirisX]);
	        cache_get_value_name_float(yuklenen, "GirisPosY", sData[id][sGirisY]);
	        cache_get_value_name_float(yuklenen, "GirisPosZ", sData[id][sGirisZ]);
	        cache_get_value_name_float(yuklenen, "GirisPosA", sData[id][sGirisF]);
	        cache_get_value_name_float(yuklenen, "cCpX", sData[id][sCikisCPX]);
	        cache_get_value_name_float(yuklenen, "cCpY", sData[id][sCikisCPY]);
	        cache_get_value_name_float(yuklenen, "cCpZ", sData[id][sCikisCPZ]);
	        cache_get_value_name_float(yuklenen, "CikisPosX", sData[id][sCikisX]);
	        cache_get_value_name_float(yuklenen, "CikisPosY", sData[id][sCikisY]);
	        cache_get_value_name_float(yuklenen, "CikisPosZ", sData[id][sCikisZ]);
	        cache_get_value_name_float(yuklenen, "CikisPosA", sData[id][sCikisF]);
	        cache_get_value_name_float(yuklenen, "sCpX", sData[id][sSoygunCPX]);
	        cache_get_value_name_float(yuklenen, "sCpY", sData[id][sSoygunCPY]);
	        cache_get_value_name_float(yuklenen, "sCpZ", sData[id][sSoygunCPZ]);
	        cache_get_value_name_int(yuklenen, "sInterior", sData[id][sInterior]);
	        cache_get_value_name_int(yuklenen, "sVW", sData[id][sVW]);
	        cache_get_value_name_int(yuklenen, "sIcon", sData[id][sIcon]);
	        sData[id][sDurum] = 1;
	        format(label, sizeof(label), "{00BFFF}%s\n{FFF700}Durum: %s", sData[id][sIsim], (sData[id][sDurum] == 1 ? ("{48FF00}Soyulabilir") : ("{FF0000}Soyulamaz")));
			sData[id][sLabel] = CreateDynamic3DTextLabel(label, -1, sData[id][sSoygunCPX], sData[id][sSoygunCPY], sData[id][sSoygunCPZ], 15.0, .worldid = sData[id][sVW], .interiorid = sData[id][sInterior]);
			format(label, sizeof(label), "{00FF88}Mekan: {00FFEE}%s", sData[id][sIsim]);
			CreateDynamic3DTextLabel(label, -1, sData[id][sGirisCPX], sData[id][sGirisCPY], sData[id][sGirisCPZ], 20.0);
			CreateDynamic3DTextLabel("{00FF88}ÇIKIÞ", -1, sData[id][sCikisCPX], sData[id][sCikisCPY], sData[id][sCikisCPZ], 15.0, .worldid = sData[id][sVW], .interiorid = sData[id][sInterior]);
			sData[id][sCikisCP] = CreateDynamicCP(sData[id][sCikisCPX], sData[id][sCikisCPY], sData[id][sCikisCPZ], 1.0, .worldid = sData[id][sVW], .interiorid = sData[id][sInterior]);
			sData[id][sGirisCP] = CreateDynamicCP(sData[id][sGirisCPX], sData[id][sGirisCPY], sData[id][sGirisCPZ], 1.0);
			sData[id][sSoygunCP] = CreateDynamicCP(sData[id][sSoygunCPX], sData[id][sSoygunCPY], sData[id][sSoygunCPZ], 1.0, .worldid = sData[id][sVW], .interiorid = sData[id][sInterior]);
			CreateDynamicMapIcon(sData[id][sGirisCPX], sData[id][sGirisCPY], sData[id][sGirisCPZ], sData[id][sIcon], -1);
			Iter_Add(soygunlar, id);
			yuklenen++;
	    }
	}
	printf("Toplam %d soygun mekaný yüklendi.", yuklenen);
	return true;
}

stock LabelGuncelle(id)
{
	new label[256];
	format(label, sizeof(label), "{00BFFF}%s\n{FFF700}Durum: %s", sData[id][sIsim], (sData[id][sDurum] == 1 ? ("{48FF00}Soyulabilir") : ("{FF0000}Soyulamaz")));
	UpdateDynamic3DTextLabelText(sData[id][sLabel], -1, label);
	return true;
}

forward SoygunYapiyorum(playerid, id);
public SoygunYapiyorum(playerid, id)
{
	if(!IsPlayerInDynamicCP(playerid, sData[id][sSoygunCP]))
	{
	    KillTimer(SoyTimer[playerid]);
	    SoygunSure[playerid] = 0;
	    SetTimerEx("Aktiflestir", 180000, false, "d", id);
	    return true;
	}
	new text[128];
	if(SoygunSure[playerid] >= 1)
	{
	    new para = random(1000) + 100;
	    format(text, sizeof(text), "~r~~h~~h~SOYGUN YAPILIYOR~n~~y~- %d -~n~~g~~h~~h~+$%d", SoygunSure[playerid], para);
	    GameTextForPlayer(playerid, text, 999, 5);
	    GivePlayerMoney(playerid, para);
	    SoygunSure[playerid]--;
	}
	else if(SoygunSure[playerid] == 0)
	{
	    SoygunSure[playerid] = 0;
	    KillTimer(SoyTimer[playerid]);
	    GameTextForPlayer(playerid, "~g~~h~~h~SOYGUN TAMAMLANDI!", 999, 5);
	    SetTimerEx("Aktiflestir", 180000, false, "d", id);
	}
	return true;
}

forward Aktiflestir(id);
public Aktiflestir(id)
{
	sData[id][sDurum] = 1;
	LabelGuncelle(id);
	return true;
}
