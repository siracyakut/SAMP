#include <a_samp>
#include <foreach>

#pragma dynamic 10000

new yazim[MAX_PLAYERS][2048];

public OnPlayerText(playerid, text[])
{
	new yazi[2048];
	format(yazi, sizeof(yazi), "{FFBB00}%s(%d): {FFFFFF}%s", getName(playerid), playerid, text);
	
	foreach(new q: Player)
	{
	    format(yazim[q], 2048, yazi);
	}
	
	foreach(new i: Player)
	{
	    if(strfind(yazim[i], "@") != -1)
	    {
	        new arastr[10], degisstr[100], sayi = strcount(yazim[i], '@'), yapilan;
	        basla:
	        for(new x = GetPlayerPoolSize(); x != -1; x--)
	        {
	            format(arastr, sizeof(arastr), "@%d", x);
	            if(strfind(yazim[i], arastr) != -1)
	            {
	                if(i == x)
				format(degisstr, sizeof(degisstr), "{2471A3}%s{FFFFFF}(%d)", getName(x), x);
			else
				format(degisstr, sizeof(degisstr), "%s(%d)", getName(x), x);
			GameTextForPlayer(x, "~n~~n~~n~~n~~n~~n~~n~~y~Sizden Bahsedildi", 2500, 5);
	                strreplace(yazim[i], arastr, degisstr);
	                break;
	            }
	        }
	        if(yapilan < sayi)
	        {
	            yapilan++;
	            goto basla;
	        }
	    }
	    SendClientMessage(i, -1, yazim[i]);
	}
	return false;
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
