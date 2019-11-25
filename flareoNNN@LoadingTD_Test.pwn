#include <a_samp>

#undef MAX_PLAYERS
#define MAX_PLAYERS 2

new PlayerText: flareoNNN_TD[MAX_PLAYERS][62];
new Renkler__[] =
{
	0xFF0000FF,
	0xFF0800FF,
	0xFF1000FF,
	0xFF1900FF,
	0xFF2100FF,
	0xFF2A00FF,
	0xFF3300FF,
	0xFF3B00FF,
	0xFF4400FF,
	0xFF4C00FF,
	0xFF5500FF,
	0xFF5D00FF,
	0xFF6600FF,
	0xFF6E00FF,
	0xFF7700FF,
	0xFF7F00FF,
	0xFF8800FF,
	0xFF9000FF,
	0xFF9900FF,
	0xFFA100FF,
	0xFFAA00FF,
	0xFFB200FF,
	0xFFBB00FF,
	0xFFC300FF,
	0xFFCC00FF,
	0xFFD400FF,
	0xFFDD00FF,
	0xFFE500FF,
	0xFFEE00FF,
	0xFFF600FF,
	0xFEFF00FF,
	0xF6FF00FF,
	0xEDFF00FF,
	0xE5FF00FF,
	0xDCFF00FF,
	0xD4FF00FF,
	0xCBFF00FF,
	0xC3FF00FF,
	0xBAFF00FF,
	0xB2FF00FF,
	0xA9FF00FF,
	0xA1FF00FF,
	0x98FF00FF,
	0x90FF00FF,
	0x87FF00FF,
	0x7FFF00FF,
	0x76FF00FF,
	0x6EFF00FF,
	0x65FF00FF,
	0x5DFF00FF,
	0x54FF00FF,
	0x4CFF00FF,
	0x43FF00FF,
	0x3BFF00FF,
	0x32FF00FF,
	0x2AFF00FF,
	0x21FF00FF,
	0x19FF00FF,
	0x10FF00FF,
	0x08FF00FF,
	0x00FF00FF
};

new
	___Durum,
	___Max_Durum = 100
;

public OnFilterScriptInit()
{
	TD@Yukle();
	___TDYukle();

	___Durum = 0;
	SetTimerEx("Update_Timer__", 10, true, "d", 0);
	return true;
}

public OnFilterScriptExit()
{
    TD@Sil();
	return true;
}

forward Update_Timer__(playerid);
public Update_Timer__(playerid)
{
	new Float: __@x1 = floatdiv(___Max_Durum, 61);
	new Float: __@x2 = floatdiv(___Durum, __@x1);

	for(new __@f0r; __@f0r < 61; __@f0r++)
	{
	    if(__@f0r < __@x2)
	    {
	        PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][__@f0r + 1], Renkler__[__@f0r]);
	    }
	    else
	    {
	        PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][__@f0r + 1], 0x25252544);
	    }
	    PlayerTextDrawShow(playerid, flareoNNN_TD[playerid][__@f0r + 1]);
	}

	___Durum++;
	if(___Durum == (___Max_Durum + 1)) ___Durum = 0;
	return true;
}

stock ___TDYukle()
{
	for(new i; i < MAX_PLAYERS; i++)
	{
	    for(new x = 1; x < 61; x++)
	    {
	        PlayerTextDrawColor(i, flareoNNN_TD[i][x], Renkler__[x - 1]);
	        PlayerTextDrawShow(i, flareoNNN_TD[i][x]);
	    }
	}
	return true;
}

stock TD@Sil()
{
	for(new i; i < MAX_PLAYERS; i++)
	{
	    for(new x; x < 62; x++)
	    {
	        PlayerTextDrawHide(i, flareoNNN_TD[i][x]);
	        PlayerTextDrawDestroy(i, flareoNNN_TD[i][x]);
	    }
	}
	return true;
}

stock TD@Yukle()
{
	for(new playerid; playerid < MAX_PLAYERS; playerid++)
	{
		flareoNNN_TD[playerid][0] = CreatePlayerTextDraw(playerid, 55.270904, 159.083343, "box");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][0], 0.000000, 7.188868);
		PlayerTextDrawTextSize(playerid, flareoNNN_TD[playerid][0], 212.000000, 0.000000);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][0], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][0], -1);
		PlayerTextDrawUseBox(playerid, flareoNNN_TD[playerid][0], 1);
		PlayerTextDrawBoxColor(playerid, flareoNNN_TD[playerid][0], 90);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][0], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][0], 1);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][0], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][0], 0);

		flareoNNN_TD[playerid][1] = CreatePlayerTextDraw(playerid, 55.270874, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][1], 0.607554, 8.028329);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][1], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][1], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][1], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][1], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][1], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][1], 0);

		flareoNNN_TD[playerid][2] = CreatePlayerTextDraw(playerid, 57.770835, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][2], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][2], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][2], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][2], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][2], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][2], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][2], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][2], 0);

		flareoNNN_TD[playerid][3] = CreatePlayerTextDraw(playerid, 60.270797, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][3], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][3], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][3], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][3], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][3], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][3], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][3], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][3], 0);

		flareoNNN_TD[playerid][4] = CreatePlayerTextDraw(playerid, 62.770755, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][4], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][4], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][4], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][4], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][4], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][4], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][4], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][4], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][4], 0);

		flareoNNN_TD[playerid][5] = CreatePlayerTextDraw(playerid, 65.270721, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][5], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][5], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][5], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][5], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][5], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][5], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][5], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][5], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][5], 0);

		flareoNNN_TD[playerid][6] = CreatePlayerTextDraw(playerid, 67.770675, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][6], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][6], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][6], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][6], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][6], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][6], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][6], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][6], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][6], 0);

		flareoNNN_TD[playerid][7] = CreatePlayerTextDraw(playerid, 70.270637, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][7], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][7], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][7], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][7], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][7], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][7], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][7], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][7], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][7], 0);

		flareoNNN_TD[playerid][8] = CreatePlayerTextDraw(playerid, 72.770599, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][8], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][8], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][8], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][8], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][8], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][8], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][8], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][8], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][8], 0);

		flareoNNN_TD[playerid][9] = CreatePlayerTextDraw(playerid, 75.270561, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][9], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][9], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][9], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][9], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][9], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][9], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][9], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][9], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][9], 0);

		flareoNNN_TD[playerid][10] = CreatePlayerTextDraw(playerid, 77.770523, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][10], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][10], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][10], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][10], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][10], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][10], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][10], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][10], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][10], 0);

		flareoNNN_TD[playerid][11] = CreatePlayerTextDraw(playerid, 80.270484, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][11], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][11], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][11], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][11], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][11], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][11], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][11], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][11], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][11], 0);

		flareoNNN_TD[playerid][12] = CreatePlayerTextDraw(playerid, 82.770446, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][12], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][12], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][12], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][12], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][12], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][12], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][12], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][12], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][12], 0);

		flareoNNN_TD[playerid][13] = CreatePlayerTextDraw(playerid, 85.270401, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][13], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][13], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][13], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][13], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][13], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][13], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][13], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][13], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][13], 0);

		flareoNNN_TD[playerid][14] = CreatePlayerTextDraw(playerid, 87.770370, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][14], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][14], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][14], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][14], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][14], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][14], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][14], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][14], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][14], 0);

		flareoNNN_TD[playerid][15] = CreatePlayerTextDraw(playerid, 90.270324, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][15], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][15], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][15], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][15], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][15], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][15], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][15], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][15], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][15], 0);

		flareoNNN_TD[playerid][16] = CreatePlayerTextDraw(playerid, 92.770286, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][16], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][16], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][16], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][16], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][16], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][16], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][16], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][16], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][16], 0);

		flareoNNN_TD[playerid][17] = CreatePlayerTextDraw(playerid, 95.270248, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][17], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][17], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][17], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][17], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][17], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][17], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][17], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][17], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][17], 0);

		flareoNNN_TD[playerid][18] = CreatePlayerTextDraw(playerid, 97.770210, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][18], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][18], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][18], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][18], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][18], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][18], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][18], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][18], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][18], 0);

		flareoNNN_TD[playerid][19] = CreatePlayerTextDraw(playerid, 100.270172, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][19], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][19], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][19], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][19], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][19], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][19], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][19], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][19], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][19], 0);

		flareoNNN_TD[playerid][20] = CreatePlayerTextDraw(playerid, 102.770126, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][20], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][20], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][20], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][20], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][20], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][20], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][20], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][20], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][20], 0);

		flareoNNN_TD[playerid][21] = CreatePlayerTextDraw(playerid, 105.270095, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][21], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][21], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][21], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][21], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][21], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][21], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][21], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][21], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][21], 0);

		flareoNNN_TD[playerid][22] = CreatePlayerTextDraw(playerid, 107.770050, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][22], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][22], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][22], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][22], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][22], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][22], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][22], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][22], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][22], 0);

		flareoNNN_TD[playerid][23] = CreatePlayerTextDraw(playerid, 110.270011, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][23], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][23], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][23], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][23], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][23], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][23], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][23], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][23], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][23], 0);

		flareoNNN_TD[playerid][24] = CreatePlayerTextDraw(playerid, 112.769973, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][24], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][24], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][24], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][24], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][24], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][24], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][24], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][24], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][24], 0);

		flareoNNN_TD[playerid][25] = CreatePlayerTextDraw(playerid, 115.269935, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][25], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][25], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][25], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][25], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][25], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][25], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][25], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][25], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][25], 0);

		flareoNNN_TD[playerid][26] = CreatePlayerTextDraw(playerid, 117.769897, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][26], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][26], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][26], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][26], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][26], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][26], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][26], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][26], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][26], 0);

		flareoNNN_TD[playerid][27] = CreatePlayerTextDraw(playerid, 120.269859, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][27], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][27], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][27], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][27], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][27], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][27], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][27], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][27], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][27], 0);

		flareoNNN_TD[playerid][28] = CreatePlayerTextDraw(playerid, 122.769821, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][28], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][28], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][28], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][28], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][28], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][28], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][28], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][28], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][28], 0);

		flareoNNN_TD[playerid][29] = CreatePlayerTextDraw(playerid, 125.269775, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][29], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][29], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][29], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][29], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][29], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][29], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][29], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][29], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][29], 0);

		flareoNNN_TD[playerid][30] = CreatePlayerTextDraw(playerid, 127.769737, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][30], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][30], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][30], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][30], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][30], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][30], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][30], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][30], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][30], 0);

		flareoNNN_TD[playerid][31] = CreatePlayerTextDraw(playerid, 130.269699, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][31], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][31], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][31], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][31], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][31], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][31], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][31], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][31], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][31], 0);

		flareoNNN_TD[playerid][32] = CreatePlayerTextDraw(playerid, 132.769653, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][32], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][32], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][32], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][32], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][32], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][32], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][32], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][32], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][32], 0);

		flareoNNN_TD[playerid][33] = CreatePlayerTextDraw(playerid, 135.269622, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][33], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][33], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][33], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][33], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][33], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][33], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][33], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][33], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][33], 0);

		flareoNNN_TD[playerid][34] = CreatePlayerTextDraw(playerid, 137.769592, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][34], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][34], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][34], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][34], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][34], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][34], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][34], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][34], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][34], 0);

		flareoNNN_TD[playerid][35] = CreatePlayerTextDraw(playerid, 140.269546, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][35], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][35], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][35], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][35], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][35], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][35], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][35], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][35], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][35], 0);

		flareoNNN_TD[playerid][36] = CreatePlayerTextDraw(playerid, 142.769500, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][36], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][36], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][36], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][36], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][36], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][36], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][36], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][36], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][36], 0);

		flareoNNN_TD[playerid][37] = CreatePlayerTextDraw(playerid, 145.269470, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][37], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][37], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][37], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][37], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][37], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][37], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][37], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][37], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][37], 0);

		flareoNNN_TD[playerid][38] = CreatePlayerTextDraw(playerid, 147.769424, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][38], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][38], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][38], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][38], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][38], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][38], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][38], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][38], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][38], 0);

		flareoNNN_TD[playerid][39] = CreatePlayerTextDraw(playerid, 150.269378, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][39], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][39], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][39], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][39], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][39], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][39], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][39], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][39], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][39], 0);

		flareoNNN_TD[playerid][40] = CreatePlayerTextDraw(playerid, 152.769348, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][40], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][40], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][40], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][40], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][40], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][40], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][40], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][40], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][40], 0);

		flareoNNN_TD[playerid][41] = CreatePlayerTextDraw(playerid, 155.269317, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][41], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][41], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][41], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][41], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][41], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][41], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][41], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][41], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][41], 0);

		flareoNNN_TD[playerid][42] = CreatePlayerTextDraw(playerid, 157.769271, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][42], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][42], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][42], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][42], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][42], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][42], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][42], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][42], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][42], 0);

		flareoNNN_TD[playerid][43] = CreatePlayerTextDraw(playerid, 160.269226, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][43], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][43], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][43], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][43], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][43], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][43], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][43], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][43], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][43], 0);

		flareoNNN_TD[playerid][44] = CreatePlayerTextDraw(playerid, 162.769195, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][44], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][44], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][44], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][44], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][44], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][44], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][44], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][44], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][44], 0);

		flareoNNN_TD[playerid][45] = CreatePlayerTextDraw(playerid, 165.269149, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][45], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][45], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][45], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][45], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][45], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][45], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][45], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][45], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][45], 0);

		flareoNNN_TD[playerid][46] = CreatePlayerTextDraw(playerid, 167.769104, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][46], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][46], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][46], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][46], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][46], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][46], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][46], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][46], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][46], 0);

		flareoNNN_TD[playerid][47] = CreatePlayerTextDraw(playerid, 170.269073, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][47], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][47], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][47], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][47], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][47], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][47], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][47], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][47], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][47], 0);

		flareoNNN_TD[playerid][48] = CreatePlayerTextDraw(playerid, 172.769042, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][48], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][48], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][48], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][48], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][48], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][48], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][48], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][48], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][48], 0);

		flareoNNN_TD[playerid][49] = CreatePlayerTextDraw(playerid, 175.268997, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][49], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][49], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][49], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][49], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][49], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][49], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][49], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][49], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][49], 0);

		flareoNNN_TD[playerid][50] = CreatePlayerTextDraw(playerid, 177.768951, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][50], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][50], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][50], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][50], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][50], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][50], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][50], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][50], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][50], 0);

		flareoNNN_TD[playerid][51] = CreatePlayerTextDraw(playerid, 180.268920, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][51], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][51], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][51], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][51], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][51], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][51], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][51], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][51], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][51], 0);

		flareoNNN_TD[playerid][52] = CreatePlayerTextDraw(playerid, 182.768890, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][52], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][52], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][52], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][52], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][52], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][52], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][52], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][52], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][52], 0);

		flareoNNN_TD[playerid][53] = CreatePlayerTextDraw(playerid, 185.268844, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][53], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][53], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][53], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][53], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][53], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][53], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][53], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][53], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][53], 0);

		flareoNNN_TD[playerid][54] = CreatePlayerTextDraw(playerid, 187.768798, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][54], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][54], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][54], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][54], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][54], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][54], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][54], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][54], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][54], 0);

		flareoNNN_TD[playerid][55] = CreatePlayerTextDraw(playerid, 190.268768, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][55], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][55], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][55], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][55], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][55], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][55], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][55], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][55], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][55], 0);

		flareoNNN_TD[playerid][56] = CreatePlayerTextDraw(playerid, 192.768722, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][56], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][56], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][56], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][56], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][56], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][56], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][56], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][56], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][56], 0);

		flareoNNN_TD[playerid][57] = CreatePlayerTextDraw(playerid, 195.268676, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][57], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][57], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][57], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][57], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][57], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][57], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][57], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][57], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][57], 0);

		flareoNNN_TD[playerid][58] = CreatePlayerTextDraw(playerid, 197.768646, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][58], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][58], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][58], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][58], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][58], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][58], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][58], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][58], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][58], 0);

		flareoNNN_TD[playerid][59] = CreatePlayerTextDraw(playerid, 200.268600, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][59], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][59], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][59], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][59], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][59], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][59], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][59], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][59], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][59], 0);

		flareoNNN_TD[playerid][60] = CreatePlayerTextDraw(playerid, 202.768569, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][60], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][60], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][60], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][60], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][60], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][60], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][60], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][60], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][60], 0);

		flareoNNN_TD[playerid][61] = CreatePlayerTextDraw(playerid, 205.268524, 153.250045, "I");
		PlayerTextDrawLetterSize(playerid, flareoNNN_TD[playerid][61], 0.607554, 8.028331);
		PlayerTextDrawAlignment(playerid, flareoNNN_TD[playerid][61], 1);
		PlayerTextDrawColor(playerid, flareoNNN_TD[playerid][61], -1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][61], 0);
		PlayerTextDrawSetOutline(playerid, flareoNNN_TD[playerid][61], 0);
		PlayerTextDrawBackgroundColor(playerid, flareoNNN_TD[playerid][61], 255);
		PlayerTextDrawFont(playerid, flareoNNN_TD[playerid][61], 2);
		PlayerTextDrawSetProportional(playerid, flareoNNN_TD[playerid][61], 1);
		PlayerTextDrawSetShadow(playerid, flareoNNN_TD[playerid][61], 0);
	}
	return true;
}
