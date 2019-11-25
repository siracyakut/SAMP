#include <a_samp>
#include <strlib>

public OnPlayerText(playerid, text[])
{
	for(new i, j = GetPlayerPoolSize(); i <= j; i++)
	{
		Mention_SendMessage(i, text);
	}
	return false;
}

stock Mention_SendMessage(playerid, const text[])
{
	new _text[144];
	strcat(_text, text);
	if(strfind(_text, "@") != -1)
	{
	    new _Find[10], __changeText[50];
	    for(new i = GetPlayerPoolSize(); i != -1; i--)
	    {
	        format(_Find, sizeof(_Find), "@%d", i);
	        if(strfind(_text, _Find) != -1)
	        {
	            if(playerid == i)
	            {
	                format(__changeText, sizeof(__changeText), "{FF6900}%s(%d){FFFFFF}", Name(i), i);
	            }
	            else
	            {
	                format(__changeText, sizeof(__changeText), "{CCCCCC}%s(%d){FFFFFF}", Name(i), i);
	            }
	            strreplace(_text, _Find, __changeText);
	        }
	    }
	}
	SendPlayerMessageToPlayer(playerid, playerid, _text);
	return true;
}

stock Name(playerid)
{
	new __nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, __nick, MAX_PLAYER_NAME);
	return __nick;
}
