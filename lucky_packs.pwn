#include "a_samp"
#include "zcmd"

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
new rx[MAX_PLAYERS];

CMD:paket(playerid, params[])
{
	new str[1024];
	strcat(str, "{0027e7}===========================================================================\n");
	strcat(str, "{0027e7}Küçük Şanslı Paket Açılımı\n");
	strcat(str, "{0027e7}===========================================================================\n");
	for(new i; i < sizeof(oduller); i++)
	{
	    format(str, sizeof(str), "%s{0027e7}> {aeb4b3}??????\n", str);
	}
	strcat(str, "{0027e7}===========================================================================\n");
	strcat(str, "{00a882}(?) Eğer sahip olduğunuz süreli eşyalardan biri gelirse mevcut eşyanın süresi otomatik uzatılır.\n");
	strcat(str, "{00a882}(?) Eğer sahip olduğunuz sınırsız eşyalardan biri gelirse eşya yerine +10 TIFKredi hesabınıza eklenir.\n");
	ShowPlayerDialog(playerid, 12, DIALOG_STYLE_MSGBOX, "TurkIbiza™ Freeroam", str, "AÇ", "İptal");
	return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 12)
	{
	    if(response)
	    {
	        new rastgele = randomEx(25, 45);
	        SetPVarInt(playerid, "tick", rastgele);
	        SetPVarInt(playerid, "current", 0);
	        
	        SetPVarInt(playerid, "interval", 1);
	        SetTimerEx("Paket", GetPVarInt(playerid, "interval"), false, "d", playerid);
	        rx[playerid] = 0;
	    }
	}
	return false;
}

forward Paket(playerid);
public Paket(playerid)
{
	new str[1024], current = GetPVarInt(playerid, "current");
	
	strcat(str, "{0027e7}===========================================================================\n");
	strcat(str, "{0027e7}Küçük Şanslı Paket Açılımı\n");
	strcat(str, "{0027e7}===========================================================================\n");
	for(new i; i < sizeof(oduller); i++)
	{
	    if(i == current) format(str, sizeof(str), "%s{0027e7}( %s )\n", str, oduller[i][0]);
	    else format(str, sizeof(str), "%s{0027e7}> {aeb4b3}%s\n", str, oduller[i][0]);
	}
	strcat(str, "{0027e7}===========================================================================\n");
	strcat(str, "{00a882}(?) Eğer sahip olduğunuz süreli eşyalardan biri gelirse mevcut eşyanın süresi otomatik uzatılır.\n");
	strcat(str, "{00a882}(?) Eğer sahip olduğunuz sınırsız eşyalardan biri gelirse eşya yerine +10 TIFKredi hesabınıza eklenir.\n");

	ShowPlayerDialog(playerid, 13, DIALOG_STYLE_MSGBOX, "TurkIbiza™ Freeroam", str, "Bekleyiniz", "");

	SetPVarInt(playerid, "current", GetPVarInt(playerid, "current") + 1);
	if(GetPVarInt(playerid, "current") == sizeof(oduller)) SetPVarInt(playerid, "current", 0);
	rx[playerid]++;
	
	if(rx[playerid] == GetPVarInt(playerid, "tick"))
	{
	    	str[0] = EOS;
    		strcat(str, "{0027e7}===========================================================================\n");
		strcat(str, "{0027e7}Küçük Şanslı Paket Açılımı\n");
		strcat(str, "{0027e7}===========================================================================\n");
		for(new i; i < sizeof(oduller); i++)
		{
		    if(i == current) format(str, sizeof(str), "%s{2d7e39}>>>> ( %s ) <<<<\n", str, oduller[i][0]);
		    else format(str, sizeof(str), "%s{0027e7}> {aeb4b3}%s\n", str, oduller[i][0]);
		}
		strcat(str, "{0027e7}===========================================================================\n");
		strcat(str, "{00a882}(?) Eğer sahip olduğunuz süreli eşyalardan biri gelirse mevcut eşyanın süresi otomatik uzatılır.\n");
		strcat(str, "{00a882}(?) Eğer sahip olduğunuz sınırsız eşyalardan biri gelirse eşya yerine +10 TIFKredi hesabınıza eklenir.\n");
		ShowPlayerDialog(playerid, 13, DIALOG_STYLE_MSGBOX, "TurkIbiza™ Freeroam", str, "AL", "");
		
        	format(str, sizeof(str), "{008c23}<{c0c0c0}(?){008c23}> Kutudan '{c0c0c0}%s{008c23}' kazandınız!", oduller[current][0]);
        	SendClientMessage(playerid, -1, str);
		return true;
	}
	
	SetPVarInt(playerid, "interval", GetPVarInt(playerid, "interval") + 13);
	SetTimerEx("Paket", GetPVarInt(playerid, "interval"), false, "d", playerid);
	return true;
}

stock randomEx(min, max)
{
	return random(max - min + 1) + min;
}
