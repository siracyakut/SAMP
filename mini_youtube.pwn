#include <a_samp>
#include <a_http>
#include <sscanf2>
#include <izcmd>

CMD:youtube(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, "{FF0000}Hata: {FFFFFF}Bu komutu kullanabilmek için RCON Admin olmalýsýnýz!");

	new link[128], edit[256], pos;
	if(sscanf(params, "s[128]", link)) return SendClientMessage(playerid, -1, "{009EFF}Kullanim: {FFFFFF}/youtube [yt link]");
	
	if(strfind(link, "youtube.com") != -1)
	{
		if(-1 == (pos = strfind(link, "=")))
		{
			return SendClientMessage(playerid, -1, "{FF0000}Hata: {FFFFFF}Hatalý youtube linki girdiniz!");
		}
	}
	else return SendClientMessage(playerid, -1, "{FF0000}Hata: {FFFFFF}Hatalý youtube linki girdiniz!");
	if(strlen(link[pos + 1]) < 5) return SendClientMessage(playerid, -1, "{FF0000}Hata: {FFFFFF}Hatalý youtube linki girdiniz!");
	
	format(edit, sizeof(edit), "94.55.225.166/yt.php?link=%s", link);
	HTTP(playerid, HTTP_GET, edit, "", "Convert");
	
	SendClientMessage(playerid, -1, "{DB00FF}Bilgi: {FFFFFF}Ýsteðiniz iþleme alýndý, þarký birazdan açýlacaktýr.");
	return true;
}

forward Convert(playerid, response_code, data[]);
public Convert(playerid, response_code, data[])
{
	if(response_code != 200) return SendClientMessage(playerid, -1, "{FF0000}Hata: {FFFFFF}Dönüþümde hata oluþtu!");
	
	new gelen[256], isim[100], link[100], str[256];
	format(gelen, sizeof(gelen), data);
	
	sscanf(gelen, "p<*>s[100]s[100]", isim, link);
	
	strreplace(isim, "0x01", "ý");
	strreplace(isim, "0x02", "ð");
	strreplace(isim, "0x03", "Ð");
	strreplace(isim, "0x04", "ü");
	strreplace(isim, "0x05", "Ü");
	strreplace(isim, "0x06", "þ");
	strreplace(isim, "0x07", "Þ");
	strreplace(isim, "0x08", "Ý");
	strreplace(isim, "0x09", "ö");
	strreplace(isim, "0x10", "Ö");
	strreplace(isim, "0x11", "ç");
	strreplace(isim, "0x12", "Ç");
	strreplace(isim, "&amp;", "&");
	
	format(str, sizeof(str), "{FF8E00}YouTube: {FFFFFF}%s {FF8E00}- {FFFFFF}%s", isim, getName(playerid));
	
	for(new i, j = GetPlayerPoolSize(); i <= j; i++)
	{
	    if(!IsPlayerConnected(i) || IsPlayerNPC(i)) continue;
	    
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, link);
	    SendClientMessage(i, -1, str);
	}
	return true;
}

stock getName(playerid)
{
	new n[MAX_PLAYER_NAME];
	GetPlayerName(playerid, n, MAX_PLAYER_NAME);
	return n;
}

stock strreplace(string[], const search[], const replacement[], bool:ignorecase = false, pos = 0, limit = -1, maxlength = sizeof(string))
{
    if (limit == 0)
        return false;

    new
             sublen = strlen(search),
             replen = strlen(replacement),
        bool:packed = ispacked(string),
             maxlen = maxlength,
             len = strlen(string),
             count = 0
    ;

    if (packed)
        maxlen *= 4;

    if (!sublen)
        return false;

    while (-1 != (pos = strfind(string, search, ignorecase, pos))) {
        strdel(string, pos, pos + sublen);

        len -= sublen;

        if (replen && len + replen < maxlen) {
            strins(string, replacement, pos, maxlength);

            pos += replen;
            len += replen;
        }

        if (limit != -1 && ++count >= limit)
            break;
    }

    return count;
}
