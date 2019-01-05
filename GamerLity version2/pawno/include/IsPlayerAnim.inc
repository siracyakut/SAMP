
// LethaL'den EDIT by Wipsjack

#if defined _IsPlayerAnim_included
  #endinput
#endif
#define _IsPlayerAnim_included
#pragma library IsPlayerAnim

#include <a_samp>
#include <lethaldudb2>


stock IsPlayerAnim(playerid)
{

new name[MAX_PLAYER_NAME];  GetPlayerName(playerid, name, sizeof(name));
new file[256], tmp, tmp2; 

format(file,256,"/ladmin/users/%s.sav",udb_encode(name));
tmp = dini_Int(file,"level");
tmp2 = dini_Int(file,"loggedin");

if( (IsPlayerConnected(playerid)) && (tmp < 0) && (tmp2 == 1) )
	return true;
else return false;

}


stock IsPlayerAnimLevel(playerid, level)
{

new name[MAX_PLAYER_NAME];  GetPlayerName(playerid, name, sizeof(name));
new file[256], tmp, tmp2; 

format(file,256,"/ladmin/users/%s.sav",udb_encode(name));
tmp = dini_Int(file,"level");
tmp2 = dini_Int(file,"loggedin");
printf("tmp = %d, tmp2(logged) = %d, level = %d", tmp, tmp2, level );
if( (IsPlayerConnected(playerid)) && (tmp <= level) && (tmp2 != 0) )
	return true;
else return false;

}
