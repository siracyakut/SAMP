#include <a_samp>
#include <foreach>

public OnPlayerText(playerid, text[])
{
	new str[1024];
	format(str, sizeof(str), "{%06x}%s(%d): {FFFFFF}%s", GetPlayerColor(playerid) >>> 8, getName(playerid), playerid, text);
	
	foreach(new i: Player)
	{
		if(IsPlayerNPC(i)) continue;

		if(strfind(text, "@") != -1)
			Mention(i, str);
		else
			SendClientMessage(i, -1, str);
	}
	return false;
}

stock Mention(playerid, text[])
{
	if(strfind(text, "@") != -1)
	{
		new strx[30], stry[128], sayi = strcount(text, '@');
		for(new q; q < sayi; q++)
		{
			for(new x = GetPlayerPoolSize(); x != -1; x--)
			{
				format(strx, sizeof(strx), "@%d", x);
				if(strfind(text, strx) != -1)
				{
					if(playerid == x)
						format(stry, sizeof(stry), "{2471A3}%s{FFFFFF}(%d)", getName(x), x);
					else
						format(stry, sizeof(stry), "%s(%d)", getName(x), x);
					GameTextForPlayer(x, "~n~~n~~n~~n~~n~~n~~n~~y~Sizden Bahsedildi", 2500, 5);
					strreplace(text, strx, stry, .maxlength = 1024);
				}
			}
		}
	}
	SendClientMessage(playerid, -1, text);
	return true;
}

stock strcount(str[], aranan)
{
	new sayi;
	for(new i; i < strlen(str); i++)
	{
	    if(str[i] == aranan)
	    {
	        sayi++;
	    }
	}
	return sayi;
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

stock getName(playerid)
{
	new isim[MAX_PLAYER_NAME];
	GetPlayerName(playerid, isim, MAX_PLAYER_NAME);
	return isim;
}
