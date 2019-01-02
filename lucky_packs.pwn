#include <a_samp>
#include <izcmd>

#pragma dynamic 1000000

new oduller[][] =
{
	{"200$ Banka Çeki"},
	{"500$ Banka Çeki"},
	{"800$ Banka Çeki"},
	{"250 Skor Paketi"},
	{"650 Skor Paketi"},
	{"1000 Skor Paketi"},
	{"Günlük EXP Bonus İtem"},
	{"Günlük Ganimet Koruma İtem"},
	{"2'li Renk Paketi"},
	{"2'li Dövüş Paketi"},
	{"1 Jetpack"},
	{"1 Unique Rhino Spawner"},
	{"1 Unique Hunter Spawner"},
	{"1 Unique Hydra Spawner"}
};
new PaketTimer[MAX_PLAYERS], PaketSure[MAX_PLAYERS], YEX[MAX_PLAYERS];

public OnFilterScriptInit()
{
	return true;
}

public OnFilterScriptExit()
{
	return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case 1234:
	    {
	        if(!response) return true;
	        
	        KillTimer(PaketTimer[playerid]);
	        PaketSure[playerid] = randomEx(28, 45);
	        YEX[playerid] = 0;
	        PaketTimer[playerid] = SetTimerEx("PaketAcilimi", 100, true, "d", playerid);
	    }
	    case 1236:
	    {
	        if(!response) return true;
	        
	        new str[128], odul_id = GetPVarInt(playerid, "sonodul");
	        format(str, sizeof(str), "{008c23}<{c0c0c0}(?){008c23}> Kutudan '{c0c0c0}%s{008c23}' kazandınız!", oduller[odul_id][0]);
	        SendClientMessage(playerid, -1, str);
	    }
	}
	return true;
}

CMD:paket(playerid, params[])
{
	new str[10000], str2[500];
	strcat(str, "{0027e7}===========================================================================\n");
	strcat(str, "{0027e7}Küçük Şanslı Paket Açılımı\n");
	strcat(str, "{0027e7}===========================================================================\n");
	for(new i; i < sizeof(oduller); i++)
	{
	    format(str2, sizeof(str2), "{0027e7}> {aeb4b3}??????\n");
	    strcat(str, str2);
	}
	strcat(str, "{0027e7}===========================================================================\n");
	strcat(str, "{00a882}(?) Eğer sahip olduğunuz süreli eşyalardan biri gelirse mevcut eşyanın süresi otomatik uzatılır.\n");
	strcat(str, "{00a882}(?) Eğer sahip olduğunuz sınırsız eşyalardan biri gelirse eşya yerine +10 TIFKredi hesabınıza eklenir.\n");
	ShowPlayerDialog(playerid, 1234, DIALOG_STYLE_MSGBOX, "TurkIbiza™ Freeroam", str, "AÇ", "İptal");
	return true;
}

forward PaketAcilimi(playerid);
public PaketAcilimi(playerid)
{
	if(PaketSure[playerid] != 0)
	{
		new str[10000], str2[500];
		strcat(str, "{0027e7}===========================================================================\n");
		strcat(str, "{0027e7}Küçük Şanslı Paket Açılımı\n");
		strcat(str, "{0027e7}===========================================================================\n");
		for(new i; i < sizeof(oduller); i++)
		{
		    if(YEX[playerid] == i) format(str2, sizeof(str2), "{0027e7}( %s )\n", oduller[i][0]), SetPVarInt(playerid, "sonodul", i);
		    else format(str2, sizeof(str2), "{0027e7}> {aeb4b3}%s\n", oduller[i][0]);
		    strcat(str, str2);
		}
		YEX[playerid]++;
		if(YEX[playerid] >= sizeof(oduller)) YEX[playerid] = 0;
		strcat(str, "{0027e7}===========================================================================\n");
		strcat(str, "{00a882}(?) Eğer sahip olduğunuz süreli eşyalardan biri gelirse mevcut eşyanın süresi otomatik uzatılır.\n");
		strcat(str, "{00a882}(?) Eğer sahip olduğunuz sınırsız eşyalardan biri gelirse eşya yerine +10 TIFKredi hesabınıza eklenir.\n");
		ShowPlayerDialog(playerid, 1235, DIALOG_STYLE_MSGBOX, "TurkIbiza™ Freeroam", str, "Bekleyiniz", "");
		PaketSure[playerid]--;
	}
	else
	{
		new str[10000], str2[500], odul_id = GetPVarInt(playerid, "sonodul");
		strcat(str, "{0027e7}===========================================================================\n");
		strcat(str, "{0027e7}Küçük Şanslı Paket Açılımı\n");
		strcat(str, "{0027e7}===========================================================================\n");
		for(new i; i < sizeof(oduller); i++)
		{
		    if(i == odul_id) format(str2, sizeof(str2), "{2d7e39}>>>> ( %s ) <<<<\n", oduller[i][0]);
		    else format(str2, sizeof(str2), "{0027e7}> {aeb4b3}%s\n", oduller[i][0]);
		    strcat(str, str2);
		}
		strcat(str, "{0027e7}===========================================================================\n");
		strcat(str, "{00a882}(?) Eğer sahip olduğunuz süreli eşyalardan biri gelirse mevcut eşyanın süresi otomatik uzatılır.\n");
		strcat(str, "{00a882}(?) Eğer sahip olduğunuz sınırsız eşyalardan biri gelirse eşya yerine +10 TIFKredi hesabınıza eklenir.\n");
		ShowPlayerDialog(playerid, 1236, DIALOG_STYLE_MSGBOX, "TurkIbiza™ Freeroam", str, "AL", "");
		KillTimer(PaketTimer[playerid]);
		PaketSure[playerid] = -1;
		YEX[playerid] = -1;
	}
	return true;
}

stock randomEx(min, max)
{
	new rand = random(max - min + 1) + min;
	return rand;
}
