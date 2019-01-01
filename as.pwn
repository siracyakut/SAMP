#include <a_samp>
#include <sscanf2>
#include <izcmd>

CMD:sifrekoy(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, "Bu komutu kullanabilmek icin RCON Admin olmalisiniz!");
	new sifre[128], str[140];
	if(sscanf(params, "s[128]", sifre)) return SendClientMessage(playerid, -1, "Kullanim: /sifrekoy [sifre]");
	format(str, sizeof(str), "password %s", sifre);
	SendRconCommand(str);
	SendClientMessage(playerid, -1, "Sifre basariyla guncellendi!");
	return true;
}

CMD:sifrekaldir(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, "Bu komutu kullanabilmek icin RCON Admin olmalisiniz!");
	SendRconCommand("password 0");
	SendClientMessage(playerid, -1, "Sifre basariyla kaldirildi!");
	return true;
}