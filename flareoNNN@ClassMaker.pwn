/*
	Release:
	    	» OnPlayerRequestClass Maker Filterscript

	Version:
			» v0.1a

	Functions:
			» isNumeric(const string[]);

	Credits:
	        » Credits to the maker of isNumeric
*/

#include <a_samp>
	
#define GREEN \
	0x33AA33AA
	
#define RED \
	0xE60000FF

#define SHORT \
	5
	
#define MEDIUM \
	10

#define FAR \
	25
	
new
	bool: MakeClass[MAX_PLAYERS],
	bool: Spawned[MAX_PLAYERS],
	MulValue[MAX_PLAYERS],
	Float: SavePos[4][MAX_PLAYERS]
;
	
public OnFilterScriptInit()
{
    print(">> OnPlayerRequestClass Maker filterscript by  » RyDeR «  has been loaded!");
	return 1;
}

public OnFilterScriptExit()
{
	print(">> OnPlayerRequestClass Maker filterscript by  » RyDeR «  has been unloaded!");
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext, "/classmaker", true))
	{
        if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, RED, ">> You are in a vehicle! Please get out.");
        if(Spawned[playerid] == false) return SendClientMessage(playerid, RED, ">> You have to spawn first!");
		SendClientMessage(playerid, GREEN, ">> You have enabled 'OnPlayerRequestClass Maker', follow the intructions of the dialogs!");
		ShowDialog(playerid, 1000);
		TogglePlayerControllable(playerid, false);
	    return 1;
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case 1000:
	    {
	        if(!response) return SendClientMessage(playerid, RED, ">> You have stopped making class! Type /classmaker to start a new wizard!"), TogglePlayerControllable(playerid, true), MakeClass[playerid] = false;
	        TogglePlayerControllable(playerid, true), MakeClass[playerid] = true;
		}
		case 1001:
		{
		    if(!response) return TogglePlayerControllable(playerid, true), MakeClass[playerid] = true;
		    GetPlayerPos(playerid, SavePos[0][playerid], SavePos[1][playerid], SavePos[2][playerid]);
		    GetPlayerFacingAngle(playerid, SavePos[3][playerid]);
		    ShowDialog(playerid, 1002);
		}
		case 1002:
		{
            if(!response) return SendClientMessage(playerid, RED, ">> You have stopped making class! Type /classmaker to start a new wizard!"), TogglePlayerControllable(playerid, true), MakeClass[playerid] = false;
            if(!strlen(inputtext)) return ShowDialog(playerid, 1003);
			if(isNumeric(inputtext))
			{
				if(strval(inputtext) < 5 || strval(inputtext) > 30) return ShowDialog(playerid, 1003);
					else return MulValue[playerid] = strval(inputtext), ShowDialog(playerid, 1004);
			}
			else if(!isNumeric(inputtext))
			{
			    if(!strcmp(inputtext, "SHORT", true)) return MulValue[playerid] = SHORT, ShowDialog(playerid, 1004);
			    	else ShowDialog(playerid, 1003);
		     	if(!strcmp(inputtext, "MEDIUM", true)) return MulValue[playerid] = MEDIUM, ShowDialog(playerid, 1004);
		     	    else ShowDialog(playerid, 1003);
				if(!strcmp(inputtext, "FAR", true)) return MulValue[playerid] = FAR, ShowDialog(playerid, 1004);
				    else ShowDialog(playerid, 1003);
			}
		}
		case 1003:
		{
            if(!response) return SendClientMessage(playerid, RED, ">> You have stopped making class! Type /classmaker to start a new wizard!"), TogglePlayerControllable(playerid, true), MakeClass[playerid] = false;
            if(!strlen(inputtext)) return ShowDialog(playerid, 1003);
			if(isNumeric(inputtext))
			{
				if(strval(inputtext) < 5 || strval(inputtext) > 30) return ShowDialog(playerid, 1003);
					else return MulValue[playerid] = strval(inputtext), ShowDialog(playerid, 1004);
			}
			else if(!isNumeric(inputtext))
			{
			    if(!strcmp(inputtext, "SHORT", true)) return MulValue[playerid] = SHORT, ShowDialog(playerid, 1004);
			    	else ShowDialog(playerid, 1003);
		     	if(!strcmp(inputtext, "MEDIUM", true)) return MulValue[playerid] = MEDIUM, ShowDialog(playerid, 1004);
		     	    else ShowDialog(playerid, 1003);
				if(!strcmp(inputtext, "FAR", true)) return MulValue[playerid] = FAR, ShowDialog(playerid, 1004);
				    else ShowDialog(playerid, 1003);
			}
		}
		case 1004:
		{
		    if(!strlen(inputtext)) return ShowDialog(playerid, 1006);
		    new
		        File: cFile,
		        string[256]
			;
			cFile = fopen("/Classes.txt", io_append);
			format(string, sizeof(string), "\r\n\r\n/* Saved under name: %s - Add under OnPlayerRequestClass.. */\r\n\r\n", inputtext), fwrite(cFile, string);
			format(string, sizeof(string), "SetPlayerPos(playerid, %f, %f, %f);\r\n", SavePos[0][playerid], SavePos[1][playerid], SavePos[2][playerid]), fwrite(cFile, string);
			format(string, sizeof(string), "SetPlayerFacingAngle(playerid, %f);\r\n", SavePos[3][playerid]), fwrite(cFile, string);
			format(string, sizeof(string), "SetPlayerCameraLookAt(playerid, %f, %f, %f);\r\n", SavePos[0][playerid], SavePos[1][playerid], SavePos[2][playerid]), fwrite(cFile, string);
			format(string, sizeof(string), "SetPlayerCameraPos(playerid, %f + (%d * floatsin(-%f, degrees)), %f + (%d * floatcos(-%f, degrees)), %f);", SavePos[0][playerid], MulValue[playerid], SavePos[3][playerid], SavePos[1][playerid], MulValue[playerid], SavePos[3][playerid], SavePos[2][playerid]), fwrite(cFile, string);
			fclose(cFile);
			ShowDialog(playerid, 1005);
		}
		case 1005:
		{
		    if(!response) return TogglePlayerControllable(playerid, true), MakeClass[playerid] = false;
		    ShowDialog(playerid, 1000);
		}
		case 1006:
		{
		    if(!strlen(inputtext)) return ShowDialog(playerid, 1006);
		}
	}
	return 1;
}

ShowDialog(playerid, dialogid)
{
	switch(dialogid)
	{
	    case 1000:
	    {
			ShowPlayerDialog(playerid, 1000, DIALOG_STYLE_MSGBOX, "Step 1", "\
			Welcome to 'OnPlayerRequestClass Maker'.\n\
			From now on, it's much easier to create a class instead of gambling the correct camera position etc.\n\n\
			Step 1: \n\
			*********\n\
			Go to a place where the player should stand while he is choosing his skin and while is watching the camera.\n\
			>> Press 'OK' to continue. 'Exit' to cancel the current wizard!\n\n\
			Note: Press Enter when you have the location to continue the wizard!", "OK", "Exit");
		}
		case 1001:
		{
		    ShowPlayerDialog(playerid, 1001, DIALOG_STYLE_MSGBOX, "Are you sure ..", "\
			Are you sure with the player coordinate?\n\n\
			Answer 'Yes' to continue. 'No' to take the player coordinates again.\n\n\
			NOTE: If you answer 'No' you're able to get new coordinates. Press 'Enter' when you found other position!", "Yes", "No");
		}
		case 1002:
		{
		    ShowPlayerDialog(playerid, 1002, DIALOG_STYLE_INPUT, "Step 2", "\
		    Step 2:\n\
			*********\n\
		    Welcome again. In this step you have to choose the distance between the player and the camera.\n\
		    You can also write input as SHORT, MEDIUM, FAR (e.g. SHORT) or just give the correct value between 5-30 (e.g. 25)\n\n\
		    >> Write the value below and press 'OK' to continue. 'Exit' to end the process", "OK", "Exit");
		}
		case 1003:
		{
		    ShowPlayerDialog(playerid, 1003, DIALOG_STYLE_INPUT, "ERROR: Step 2", "\
			ERROR: The value is incorrect(5-30) also check if the value is numeric or is aviable. (SHORT, MEDIUM, FAR)\n\n\n\
		    Welcome again. In this step you have to choose the distance between the player and the camera.\n\
		    You can also write input as SHORT, MEDIUM, FAR (e.g. SHORT) or just give the correct value between 5-30. (e.g. 25)\n\n\
		    >> Write the value below and press 'OK' to continue. 'Exit' to end the process", "OK", "Exit");
		}
		case 1004:
		{
		    ShowPlayerDialog(playerid, 1004, DIALOG_STYLE_INPUT, "Step 3", "\
		    This was actually the last step. This filterscript uses goniometric values to find out where the camera position is.\n\
		    Easy? ;)\n\
		    Step 3:\n\
		    *********\n\
		    You are done if you give the name to save the file under!", "OK", "Exit");
		}
		case 1005:
		{
		    ShowPlayerDialog(playerid, 1005, DIALOG_STYLE_MSGBOX, "Ending wizard..", "\
			The files has been saved in the scriptfiles directory under name Classes.txt.\n\
			If you open it you will see your created class with the given name in the previous step.", "Another", "Finish");
		}
		case 1006:
		{
		    ShowPlayerDialog(playerid, 1004, DIALOG_STYLE_INPUT, "ERROR: Step 3", "\
		    ERROR: You have to give a valid name to save it under!\n\n\n\
		    This was actually the last step. This filterscript uses goniometric values to find out where the camera position is.\n\
		    Easy? ;)\n\n\
		    You are done if you give the name to save the file under!", "OK", "Exit");
		}
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(MakeClass[playerid] == true)
	{
	    if(newkeys == KEY_SECONDARY_ATTACK)
	    {
			ShowDialog(playerid, 1001);
			MakeClass[playerid] = false;
	    }
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	MakeClass[playerid] = (MakeClass[playerid] == true) ? (false) : (false);
	Spawned[playerid] = false;
	return 1;
}

public OnPlayerDisconnect(playerid)
{
    MakeClass[playerid] = (MakeClass[playerid] == true) ? (false) : (false);
    Spawned[playerid] = false;
	return 1;
}

public OnPlayerSpawn(playerid)
{
	Spawned[playerid] = true;
	return 1;
}

public OnPlayerDeath(playerid)
{
	Spawned[playerid] = false;
	return 1;
}

stock isNumeric(const string[])
{
  new length=strlen(string);
  if (length==0) return false;
  for (new i = 0; i < length; i++)
    {
      if (
            (string[i] > '9' || string[i] < '0' && string[i]!='-' && string[i]!='+')
             || (string[i]=='-' && i!=0)                                            
             || (string[i]=='+' && i!=0)                                            
         ) return false;
    }
  if (length==1 && (string[0]=='-' || string[0]=='+')) return false;
  return true;
}
