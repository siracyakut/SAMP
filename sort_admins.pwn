#include <a_samp>
#include <izcmd>
#include <foreach>

new adminLevel[MAX_PLAYERS];

public OnFilterScriptInit()
{
	return true;
}

public OnFilterScriptExit()
{

	return true;
}

// kısa yöntem
CMD:admins(playerid, params[])
{
	new str[1000], j;
	for(new level = 10; i != 0; i--)
	{
		foreach(new i: Player)
		{
		    if(adminLevel[i] == level && IsPlayerConnected(i))
		    {
			format(str, sizeof(str), "%s%s - %d level\n", str, getName(i), adminLevel[i]);
			j++;
		    }
		}
	}
	if(j == 0) return SendClientMessage(playerid, -1, "Online admin yok!");
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Adminler", str, "Kapat", "");
	return true;
}

// uzun yöntem
CMD:admins(playerid, params[])
{
	new str[1000], adminler[20], idler[20], j;
	foreach(new i: Player)
	{
	    if(adminLevel[i] > 0 && IsPlayerConnected(i))
	    {
	        adminler[j] = adminLevel[i];
	        idler[j] = i;
	        j++;
	    }
	}
	if(j == 0) return SendClientMessage(playerid, -1, "Online admin yok!");
	BubbleSort(adminler, idler, j);
	for(new i; i < j; i++)
	{
	    format(str, sizeof(str), "%s%s - %d level\n", str, getName(idler[i]), adminler[i]);
	}
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Adminler", str, "Kapat", "");
	return true;
}

stock getName(playerid)
{
	new isim[MAX_PLAYER_NAME];
	GetPlayerName(playerid, isim, MAX_PLAYER_NAME);
	return isim;
}

stock BubbleSort(array[], ids[], a_size = sizeof(array))
{
	new temp[2];
	for(new i = 0, j; i < a_size; i++)
	{
		for(j = 0; j < (a_size - i); j++)
		{
			if(array[j] < array[j + 1])
			{
				temp[0] = array[j];
				temp[1] = ids[j];
				array[j] = array[j + 1];
				ids[j] = ids[j + 1];
				array[j + 1] = temp[0];
				ids[j + 1] = temp[1];
			}
		}
	}
	return true;
}
