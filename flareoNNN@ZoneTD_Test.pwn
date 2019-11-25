#include <a_samp>
#include <izcmd>

new Text: BolgeBar[MAX_PLAYERS][50];
new Durum[MAX_PLAYERS];
new DurumTimer[MAX_PLAYERS];
new NEWEXPRenkleri[] =
{
	0xFF0000FF, 0xFE0800FF, 0xFE1100FF, 0xFE1900FF, 0xFE2200FF,
	0xFE2B00FF, 0xFE3300FF, 0xFD3C00FF, 0xFD4400FF, 0xFD4D00FF, 0xFD5500FF,
	0xFD5E00FF, 0xFD6600FF, 0xFD6F00FF, 0xFC7800FF, 0xFC8000FF, 0xFC8800FF,
	0xFC9100FF, 0xFC9900FF, 0xFCA200FF, 0xFBAA00FF, 0xFBB300FF, 0xFBBB00FF,
	0xFBC400FF, 0xFBCC00FF, 0xFBD400FF, 0xFBDD00FF, 0xFAE500FF, 0xFAED00FF,
	0xFAF600FF, 0xF6FA00FF, 0xEDFA00FF, 0xE4FA00FF, 0xDCF900FF, 0xD3F900FF,
	0xCBF900FF, 0xC2F900FF, 0xB9F900FF, 0xB1F900FF, 0xA8F900FF, 0xA0F800FF, 0x97F800FF,
	0x8FF800FF, 0x86F800FF, 0x7EF800FF, 0x75F800FF, 0x6DF700FF, 0x64F700FF, 0x5CF700FF,
	0x53F700FF, 0x4BF700FF, 0x43F700FF, 0x3AF700FF, 0x32F600FF, 0x29F600FF, 0x21F600FF,
	0x19F600FF, 0x10F600FF, 0x08F600FF, 0x00F600FF
};

public OnFilterScriptInit()
{
	for(new i = 0; i <= GetMaxPlayers(); i++)
	{
		BolgeBar[i][0] = TextDrawCreate(228.155181, 316.000061, "box");
		TextDrawLetterSize(BolgeBar[i][0], 0.000000, 10.046852);
		TextDrawTextSize(BolgeBar[i][0], 411.000000, 0.000000);
		TextDrawAlignment(BolgeBar[i][0], 1);
		TextDrawColor(BolgeBar[i][0], -1);
		TextDrawUseBox(BolgeBar[i][0], 1);
		TextDrawBoxColor(BolgeBar[i][0], 68);
		TextDrawSetShadow(BolgeBar[i][0], 0);
		TextDrawSetOutline(BolgeBar[i][0], 0);
		TextDrawBackgroundColor(BolgeBar[i][0], 255);
		TextDrawFont(BolgeBar[i][0], 1);
		TextDrawSetProportional(BolgeBar[i][0], 1);
		TextDrawSetShadow(BolgeBar[i][0], 0);

		BolgeBar[i][1] = TextDrawCreate(320.922576, 321.833374, "~r~~h~00 ~g~~h~saniye sonra ~r~~h~Isimsiz Bolge ~g~~h~bolgesini ele gecireceksiniz!");
		TextDrawLetterSize(BolgeBar[i][1], 0.153557, 1.232500);
		TextDrawAlignment(BolgeBar[i][1], 2);
		TextDrawColor(BolgeBar[i][1], -1);
		TextDrawSetShadow(BolgeBar[i][1], 0);
		TextDrawSetOutline(BolgeBar[i][1], 1);
		TextDrawBackgroundColor(BolgeBar[i][1], 51);
		TextDrawFont(BolgeBar[i][1], 1);
		TextDrawSetProportional(BolgeBar[i][1], 1);
		TextDrawSetShadow(BolgeBar[i][1], 0);

		BolgeBar[i][2] = TextDrawCreate(255.329284, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][2], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][2], 1);
		TextDrawColor(BolgeBar[i][2], -1);
		TextDrawSetShadow(BolgeBar[i][2], 0);
		TextDrawSetOutline(BolgeBar[i][2], 0);
		TextDrawBackgroundColor(BolgeBar[i][2], 255);
		TextDrawFont(BolgeBar[i][2], 1);
		TextDrawSetProportional(BolgeBar[i][2], 1);
		TextDrawSetShadow(BolgeBar[i][2], 0);

		BolgeBar[i][3] = TextDrawCreate(257.629425, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][3], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][3], 1);
		TextDrawColor(BolgeBar[i][3], -1);
		TextDrawSetShadow(BolgeBar[i][3], 0);
		TextDrawSetOutline(BolgeBar[i][3], 0);
		TextDrawBackgroundColor(BolgeBar[i][3], 255);
		TextDrawFont(BolgeBar[i][3], 1);
		TextDrawSetProportional(BolgeBar[i][3], 1);
		TextDrawSetShadow(BolgeBar[i][3], 0);

		BolgeBar[i][4] = TextDrawCreate(260.229583, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][4], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][4], 1);
		TextDrawColor(BolgeBar[i][4], -1);
		TextDrawSetShadow(BolgeBar[i][4], 0);
		TextDrawSetOutline(BolgeBar[i][4], 0);
		TextDrawBackgroundColor(BolgeBar[i][4], 255);
		TextDrawFont(BolgeBar[i][4], 1);
		TextDrawSetProportional(BolgeBar[i][4], 1);
		TextDrawSetShadow(BolgeBar[i][4], 0);

		BolgeBar[i][5] = TextDrawCreate(262.729736, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][5], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][5], 1);
		TextDrawColor(BolgeBar[i][5], -1);
		TextDrawSetShadow(BolgeBar[i][5], 0);
		TextDrawSetOutline(BolgeBar[i][5], 0);
		TextDrawBackgroundColor(BolgeBar[i][5], 255);
		TextDrawFont(BolgeBar[i][5], 1);
		TextDrawSetProportional(BolgeBar[i][5], 1);
		TextDrawSetShadow(BolgeBar[i][5], 0);

		BolgeBar[i][6] = TextDrawCreate(265.329895, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][6], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][6], 1);
		TextDrawColor(BolgeBar[i][6], -1);
		TextDrawSetShadow(BolgeBar[i][6], 0);
		TextDrawSetOutline(BolgeBar[i][6], 0);
		TextDrawBackgroundColor(BolgeBar[i][6], 255);
		TextDrawFont(BolgeBar[i][6], 1);
		TextDrawSetProportional(BolgeBar[i][6], 1);
		TextDrawSetShadow(BolgeBar[i][6], 0);

		BolgeBar[i][7] = TextDrawCreate(267.530029, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][7], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][7], 1);
		TextDrawColor(BolgeBar[i][7], -1);
		TextDrawSetShadow(BolgeBar[i][7], 0);
		TextDrawSetOutline(BolgeBar[i][7], 0);
		TextDrawBackgroundColor(BolgeBar[i][7], 255);
		TextDrawFont(BolgeBar[i][7], 1);
		TextDrawSetProportional(BolgeBar[i][7], 1);
		TextDrawSetShadow(BolgeBar[i][7], 0);

		BolgeBar[i][8] = TextDrawCreate(269.930175, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][8], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][8], 1);
		TextDrawColor(BolgeBar[i][8], -1);
		TextDrawSetShadow(BolgeBar[i][8], 0);
		TextDrawSetOutline(BolgeBar[i][8], 0);
		TextDrawBackgroundColor(BolgeBar[i][8], 255);
		TextDrawFont(BolgeBar[i][8], 1);
		TextDrawSetProportional(BolgeBar[i][8], 1);
		TextDrawSetShadow(BolgeBar[i][8], 0);

		BolgeBar[i][9] = TextDrawCreate(272.330322, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][9], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][9], 1);
		TextDrawColor(BolgeBar[i][9], -1);
		TextDrawSetShadow(BolgeBar[i][9], 0);
		TextDrawSetOutline(BolgeBar[i][9], 0);
		TextDrawBackgroundColor(BolgeBar[i][9], 255);
		TextDrawFont(BolgeBar[i][9], 1);
		TextDrawSetProportional(BolgeBar[i][9], 1);
		TextDrawSetShadow(BolgeBar[i][9], 0);

		BolgeBar[i][10] = TextDrawCreate(274.830474, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][10], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][10], 1);
		TextDrawColor(BolgeBar[i][10], -1);
		TextDrawSetShadow(BolgeBar[i][10], 0);
		TextDrawSetOutline(BolgeBar[i][10], 0);
		TextDrawBackgroundColor(BolgeBar[i][10], 255);
		TextDrawFont(BolgeBar[i][10], 1);
		TextDrawSetProportional(BolgeBar[i][10], 1);
		TextDrawSetShadow(BolgeBar[i][10], 0);

		BolgeBar[i][11] = TextDrawCreate(277.530639, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][11], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][11], 1);
		TextDrawColor(BolgeBar[i][11], -1);
		TextDrawSetShadow(BolgeBar[i][11], 0);
		TextDrawSetOutline(BolgeBar[i][11], 0);
		TextDrawBackgroundColor(BolgeBar[i][11], 255);
		TextDrawFont(BolgeBar[i][11], 1);
		TextDrawSetProportional(BolgeBar[i][11], 1);
		TextDrawSetShadow(BolgeBar[i][11], 0);

		BolgeBar[i][12] = TextDrawCreate(280.030792, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][12], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][12], 1);
		TextDrawColor(BolgeBar[i][12], -1);
		TextDrawSetShadow(BolgeBar[i][12], 0);
		TextDrawSetOutline(BolgeBar[i][12], 0);
		TextDrawBackgroundColor(BolgeBar[i][12], 255);
		TextDrawFont(BolgeBar[i][12], 1);
		TextDrawSetProportional(BolgeBar[i][12], 1);
		TextDrawSetShadow(BolgeBar[i][12], 0);

		BolgeBar[i][13] = TextDrawCreate(282.830963, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][13], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][13], 1);
		TextDrawColor(BolgeBar[i][13], -1);
		TextDrawSetShadow(BolgeBar[i][13], 0);
		TextDrawSetOutline(BolgeBar[i][13], 0);
		TextDrawBackgroundColor(BolgeBar[i][13], 255);
		TextDrawFont(BolgeBar[i][13], 1);
		TextDrawSetProportional(BolgeBar[i][13], 1);
		TextDrawSetShadow(BolgeBar[i][13], 0);

		BolgeBar[i][14] = TextDrawCreate(285.731140, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][14], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][14], 1);
		TextDrawColor(BolgeBar[i][14], -1);
		TextDrawSetShadow(BolgeBar[i][14], 0);
		TextDrawSetOutline(BolgeBar[i][14], 0);
		TextDrawBackgroundColor(BolgeBar[i][14], 255);
		TextDrawFont(BolgeBar[i][14], 1);
		TextDrawSetProportional(BolgeBar[i][14], 1);
		TextDrawSetShadow(BolgeBar[i][14], 0);

		BolgeBar[i][15] = TextDrawCreate(288.531311, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][15], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][15], 1);
		TextDrawColor(BolgeBar[i][15], -1);
		TextDrawSetShadow(BolgeBar[i][15], 0);
		TextDrawSetOutline(BolgeBar[i][15], 0);
		TextDrawBackgroundColor(BolgeBar[i][15], 255);
		TextDrawFont(BolgeBar[i][15], 1);
		TextDrawSetProportional(BolgeBar[i][15], 1);
		TextDrawSetShadow(BolgeBar[i][15], 0);

		BolgeBar[i][16] = TextDrawCreate(291.431488, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][16], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][16], 1);
		TextDrawColor(BolgeBar[i][16], -1);
		TextDrawSetShadow(BolgeBar[i][16], 0);
		TextDrawSetOutline(BolgeBar[i][16], 0);
		TextDrawBackgroundColor(BolgeBar[i][16], 255);
		TextDrawFont(BolgeBar[i][16], 1);
		TextDrawSetProportional(BolgeBar[i][16], 1);
		TextDrawSetShadow(BolgeBar[i][16], 0);

		BolgeBar[i][17] = TextDrawCreate(294.231658, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][17], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][17], 1);
		TextDrawColor(BolgeBar[i][17], -1);
		TextDrawSetShadow(BolgeBar[i][17], 0);
		TextDrawSetOutline(BolgeBar[i][17], 0);
		TextDrawBackgroundColor(BolgeBar[i][17], 255);
		TextDrawFont(BolgeBar[i][17], 1);
		TextDrawSetProportional(BolgeBar[i][17], 1);
		TextDrawSetShadow(BolgeBar[i][17], 0);

		BolgeBar[i][18] = TextDrawCreate(297.431854, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][18], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][18], 1);
		TextDrawColor(BolgeBar[i][18], -1);
		TextDrawSetShadow(BolgeBar[i][18], 0);
		TextDrawSetOutline(BolgeBar[i][18], 0);
		TextDrawBackgroundColor(BolgeBar[i][18], 255);
		TextDrawFont(BolgeBar[i][18], 1);
		TextDrawSetProportional(BolgeBar[i][18], 1);
		TextDrawSetShadow(BolgeBar[i][18], 0);

		BolgeBar[i][19] = TextDrawCreate(300.132019, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][19], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][19], 1);
		TextDrawColor(BolgeBar[i][19], -1);
		TextDrawSetShadow(BolgeBar[i][19], 0);
		TextDrawSetOutline(BolgeBar[i][19], 0);
		TextDrawBackgroundColor(BolgeBar[i][19], 255);
		TextDrawFont(BolgeBar[i][19], 1);
		TextDrawSetProportional(BolgeBar[i][19], 1);
		TextDrawSetShadow(BolgeBar[i][19], 0);

		BolgeBar[i][20] = TextDrawCreate(302.632171, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][20], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][20], 1);
		TextDrawColor(BolgeBar[i][20], -1);
		TextDrawSetShadow(BolgeBar[i][20], 0);
		TextDrawSetOutline(BolgeBar[i][20], 0);
		TextDrawBackgroundColor(BolgeBar[i][20], 255);
		TextDrawFont(BolgeBar[i][20], 1);
		TextDrawSetProportional(BolgeBar[i][20], 1);
		TextDrawSetShadow(BolgeBar[i][20], 0);

		BolgeBar[i][21] = TextDrawCreate(304.932312, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][21], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][21], 1);
		TextDrawColor(BolgeBar[i][21], -1);
		TextDrawSetShadow(BolgeBar[i][21], 0);
		TextDrawSetOutline(BolgeBar[i][21], 0);
		TextDrawBackgroundColor(BolgeBar[i][21], 255);
		TextDrawFont(BolgeBar[i][21], 1);
		TextDrawSetProportional(BolgeBar[i][21], 1);
		TextDrawSetShadow(BolgeBar[i][21], 0);

		BolgeBar[i][22] = TextDrawCreate(307.632476, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][22], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][22], 1);
		TextDrawColor(BolgeBar[i][22], -1);
		TextDrawSetShadow(BolgeBar[i][22], 0);
		TextDrawSetOutline(BolgeBar[i][22], 0);
		TextDrawBackgroundColor(BolgeBar[i][22], 255);
		TextDrawFont(BolgeBar[i][22], 1);
		TextDrawSetProportional(BolgeBar[i][22], 1);
		TextDrawSetShadow(BolgeBar[i][22], 0);

		BolgeBar[i][23] = TextDrawCreate(310.032623, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][23], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][23], 1);
		TextDrawColor(BolgeBar[i][23], -1);
		TextDrawSetShadow(BolgeBar[i][23], 0);
		TextDrawSetOutline(BolgeBar[i][23], 0);
		TextDrawBackgroundColor(BolgeBar[i][23], 255);
		TextDrawFont(BolgeBar[i][23], 1);
		TextDrawSetProportional(BolgeBar[i][23], 1);
		TextDrawSetShadow(BolgeBar[i][23], 0);

		BolgeBar[i][24] = TextDrawCreate(312.432769, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][24], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][24], 1);
		TextDrawColor(BolgeBar[i][24], -1);
		TextDrawSetShadow(BolgeBar[i][24], 0);
		TextDrawSetOutline(BolgeBar[i][24], 0);
		TextDrawBackgroundColor(BolgeBar[i][24], 255);
		TextDrawFont(BolgeBar[i][24], 1);
		TextDrawSetProportional(BolgeBar[i][24], 1);
		TextDrawSetShadow(BolgeBar[i][24], 0);

		BolgeBar[i][25] = TextDrawCreate(314.932922, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][25], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][25], 1);
		TextDrawColor(BolgeBar[i][25], -1);
		TextDrawSetShadow(BolgeBar[i][25], 0);
		TextDrawSetOutline(BolgeBar[i][25], 0);
		TextDrawBackgroundColor(BolgeBar[i][25], 255);
		TextDrawFont(BolgeBar[i][25], 1);
		TextDrawSetProportional(BolgeBar[i][25], 1);
		TextDrawSetShadow(BolgeBar[i][25], 0);

		BolgeBar[i][26] = TextDrawCreate(317.433074, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][26], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][26], 1);
		TextDrawColor(BolgeBar[i][26], -1);
		TextDrawSetShadow(BolgeBar[i][26], 0);
		TextDrawSetOutline(BolgeBar[i][26], 0);
		TextDrawBackgroundColor(BolgeBar[i][26], 255);
		TextDrawFont(BolgeBar[i][26], 1);
		TextDrawSetProportional(BolgeBar[i][26], 1);
		TextDrawSetShadow(BolgeBar[i][26], 0);

		BolgeBar[i][27] = TextDrawCreate(320.133239, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][27], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][27], 1);
		TextDrawColor(BolgeBar[i][27], -1);
		TextDrawSetShadow(BolgeBar[i][27], 0);
		TextDrawSetOutline(BolgeBar[i][27], 0);
		TextDrawBackgroundColor(BolgeBar[i][27], 255);
		TextDrawFont(BolgeBar[i][27], 1);
		TextDrawSetProportional(BolgeBar[i][27], 1);
		TextDrawSetShadow(BolgeBar[i][27], 0);

		BolgeBar[i][28] = TextDrawCreate(322.633392, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][28], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][28], 1);
		TextDrawColor(BolgeBar[i][28], -1);
		TextDrawSetShadow(BolgeBar[i][28], 0);
		TextDrawSetOutline(BolgeBar[i][28], 0);
		TextDrawBackgroundColor(BolgeBar[i][28], 255);
		TextDrawFont(BolgeBar[i][28], 1);
		TextDrawSetProportional(BolgeBar[i][28], 1);
		TextDrawSetShadow(BolgeBar[i][28], 0);

		BolgeBar[i][29] = TextDrawCreate(325.133544, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][29], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][29], 1);
		TextDrawColor(BolgeBar[i][29], -1);
		TextDrawSetShadow(BolgeBar[i][29], 0);
		TextDrawSetOutline(BolgeBar[i][29], 0);
		TextDrawBackgroundColor(BolgeBar[i][29], 255);
		TextDrawFont(BolgeBar[i][29], 1);
		TextDrawSetProportional(BolgeBar[i][29], 1);
		TextDrawSetShadow(BolgeBar[i][29], 0);

		BolgeBar[i][30] = TextDrawCreate(327.533691, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][30], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][30], 1);
		TextDrawColor(BolgeBar[i][30], -1);
		TextDrawSetShadow(BolgeBar[i][30], 0);
		TextDrawSetOutline(BolgeBar[i][30], 0);
		TextDrawBackgroundColor(BolgeBar[i][30], 255);
		TextDrawFont(BolgeBar[i][30], 1);
		TextDrawSetProportional(BolgeBar[i][30], 1);
		TextDrawSetShadow(BolgeBar[i][30], 0);

		BolgeBar[i][31] = TextDrawCreate(330.033843, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][31], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][31], 1);
		TextDrawColor(BolgeBar[i][31], -1);
		TextDrawSetShadow(BolgeBar[i][31], 0);
		TextDrawSetOutline(BolgeBar[i][31], 0);
		TextDrawBackgroundColor(BolgeBar[i][31], 255);
		TextDrawFont(BolgeBar[i][31], 1);
		TextDrawSetProportional(BolgeBar[i][31], 1);
		TextDrawSetShadow(BolgeBar[i][31], 0);

		BolgeBar[i][32] = TextDrawCreate(332.834014, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][32], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][32], 1);
		TextDrawColor(BolgeBar[i][32], -1);
		TextDrawSetShadow(BolgeBar[i][32], 0);
		TextDrawSetOutline(BolgeBar[i][32], 0);
		TextDrawBackgroundColor(BolgeBar[i][32], 255);
		TextDrawFont(BolgeBar[i][32], 1);
		TextDrawSetProportional(BolgeBar[i][32], 1);
		TextDrawSetShadow(BolgeBar[i][32], 0);

		BolgeBar[i][33] = TextDrawCreate(335.634185, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][33], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][33], 1);
		TextDrawColor(BolgeBar[i][33], -1);
		TextDrawSetShadow(BolgeBar[i][33], 0);
		TextDrawSetOutline(BolgeBar[i][33], 0);
		TextDrawBackgroundColor(BolgeBar[i][33], 255);
		TextDrawFont(BolgeBar[i][33], 1);
		TextDrawSetProportional(BolgeBar[i][33], 1);
		TextDrawSetShadow(BolgeBar[i][33], 0);

		BolgeBar[i][34] = TextDrawCreate(338.534362, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][34], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][34], 1);
		TextDrawColor(BolgeBar[i][34], -1);
		TextDrawSetShadow(BolgeBar[i][34], 0);
		TextDrawSetOutline(BolgeBar[i][34], 0);
		TextDrawBackgroundColor(BolgeBar[i][34], 255);
		TextDrawFont(BolgeBar[i][34], 1);
		TextDrawSetProportional(BolgeBar[i][34], 1);
		TextDrawSetShadow(BolgeBar[i][34], 0);

		BolgeBar[i][35] = TextDrawCreate(341.634552, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][35], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][35], 1);
		TextDrawColor(BolgeBar[i][35], -1);
		TextDrawSetShadow(BolgeBar[i][35], 0);
		TextDrawSetOutline(BolgeBar[i][35], 0);
		TextDrawBackgroundColor(BolgeBar[i][35], 255);
		TextDrawFont(BolgeBar[i][35], 1);
		TextDrawSetProportional(BolgeBar[i][35], 1);
		TextDrawSetShadow(BolgeBar[i][35], 0);

		BolgeBar[i][36] = TextDrawCreate(344.334716, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][36], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][36], 1);
		TextDrawColor(BolgeBar[i][36], -1);
		TextDrawSetShadow(BolgeBar[i][36], 0);
		TextDrawSetOutline(BolgeBar[i][36], 0);
		TextDrawBackgroundColor(BolgeBar[i][36], 255);
		TextDrawFont(BolgeBar[i][36], 1);
		TextDrawSetProportional(BolgeBar[i][36], 1);
		TextDrawSetShadow(BolgeBar[i][36], 0);

		BolgeBar[i][37] = TextDrawCreate(346.934875, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][37], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][37], 1);
		TextDrawColor(BolgeBar[i][37], -1);
		TextDrawSetShadow(BolgeBar[i][37], 0);
		TextDrawSetOutline(BolgeBar[i][37], 0);
		TextDrawBackgroundColor(BolgeBar[i][37], 255);
		TextDrawFont(BolgeBar[i][37], 1);
		TextDrawSetProportional(BolgeBar[i][37], 1);
		TextDrawSetShadow(BolgeBar[i][37], 0);

		BolgeBar[i][38] = TextDrawCreate(349.735046, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][38], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][38], 1);
		TextDrawColor(BolgeBar[i][38], -1);
		TextDrawSetShadow(BolgeBar[i][38], 0);
		TextDrawSetOutline(BolgeBar[i][38], 0);
		TextDrawBackgroundColor(BolgeBar[i][38], 255);
		TextDrawFont(BolgeBar[i][38], 1);
		TextDrawSetProportional(BolgeBar[i][38], 1);
		TextDrawSetShadow(BolgeBar[i][38], 0);

		BolgeBar[i][39] = TextDrawCreate(352.635223, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][39], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][39], 1);
		TextDrawColor(BolgeBar[i][39], -1);
		TextDrawSetShadow(BolgeBar[i][39], 0);
		TextDrawSetOutline(BolgeBar[i][39], 0);
		TextDrawBackgroundColor(BolgeBar[i][39], 255);
		TextDrawFont(BolgeBar[i][39], 1);
		TextDrawSetProportional(BolgeBar[i][39], 1);
		TextDrawSetShadow(BolgeBar[i][39], 0);

		BolgeBar[i][40] = TextDrawCreate(355.435394, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][40], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][40], 1);
		TextDrawColor(BolgeBar[i][40], -1);
		TextDrawSetShadow(BolgeBar[i][40], 0);
		TextDrawSetOutline(BolgeBar[i][40], 0);
		TextDrawBackgroundColor(BolgeBar[i][40], 255);
		TextDrawFont(BolgeBar[i][40], 1);
		TextDrawSetProportional(BolgeBar[i][40], 1);
		TextDrawSetShadow(BolgeBar[i][40], 0);

		BolgeBar[i][41] = TextDrawCreate(358.135559, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][41], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][41], 1);
		TextDrawColor(BolgeBar[i][41], -1);
		TextDrawSetShadow(BolgeBar[i][41], 0);
		TextDrawSetOutline(BolgeBar[i][41], 0);
		TextDrawBackgroundColor(BolgeBar[i][41], 255);
		TextDrawFont(BolgeBar[i][41], 1);
		TextDrawSetProportional(BolgeBar[i][41], 1);
		TextDrawSetShadow(BolgeBar[i][41], 0);

		BolgeBar[i][42] = TextDrawCreate(360.635711, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][42], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][42], 1);
		TextDrawColor(BolgeBar[i][42], -1);
		TextDrawSetShadow(BolgeBar[i][42], 0);
		TextDrawSetOutline(BolgeBar[i][42], 0);
		TextDrawBackgroundColor(BolgeBar[i][42], 255);
		TextDrawFont(BolgeBar[i][42], 1);
		TextDrawSetProportional(BolgeBar[i][42], 1);
		TextDrawSetShadow(BolgeBar[i][42], 0);

		BolgeBar[i][43] = TextDrawCreate(363.335876, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][43], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][43], 1);
		TextDrawColor(BolgeBar[i][43], -1);
		TextDrawSetShadow(BolgeBar[i][43], 0);
		TextDrawSetOutline(BolgeBar[i][43], 0);
		TextDrawBackgroundColor(BolgeBar[i][43], 255);
		TextDrawFont(BolgeBar[i][43], 1);
		TextDrawSetProportional(BolgeBar[i][43], 1);
		TextDrawSetShadow(BolgeBar[i][43], 0);

		BolgeBar[i][44] = TextDrawCreate(365.836029, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][44], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][44], 1);
		TextDrawColor(BolgeBar[i][44], -1);
		TextDrawSetShadow(BolgeBar[i][44], 0);
		TextDrawSetOutline(BolgeBar[i][44], 0);
		TextDrawBackgroundColor(BolgeBar[i][44], 255);
		TextDrawFont(BolgeBar[i][44], 1);
		TextDrawSetProportional(BolgeBar[i][44], 1);
		TextDrawSetShadow(BolgeBar[i][44], 0);

		BolgeBar[i][45] = TextDrawCreate(368.536193, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][45], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][45], 1);
		TextDrawColor(BolgeBar[i][45], -1);
		TextDrawSetShadow(BolgeBar[i][45], 0);
		TextDrawSetOutline(BolgeBar[i][45], 0);
		TextDrawBackgroundColor(BolgeBar[i][45], 255);
		TextDrawFont(BolgeBar[i][45], 1);
		TextDrawSetProportional(BolgeBar[i][45], 1);
		TextDrawSetShadow(BolgeBar[i][45], 0);

		BolgeBar[i][46] = TextDrawCreate(371.336364, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][46], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][46], 1);
		TextDrawColor(BolgeBar[i][46], -1);
		TextDrawSetShadow(BolgeBar[i][46], 0);
		TextDrawSetOutline(BolgeBar[i][46], 0);
		TextDrawBackgroundColor(BolgeBar[i][46], 255);
		TextDrawFont(BolgeBar[i][46], 1);
		TextDrawSetProportional(BolgeBar[i][46], 1);
		TextDrawSetShadow(BolgeBar[i][46], 0);

		BolgeBar[i][47] = TextDrawCreate(374.236541, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][47], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][47], 1);
		TextDrawColor(BolgeBar[i][47], -1);
		TextDrawSetShadow(BolgeBar[i][47], 0);
		TextDrawSetOutline(BolgeBar[i][47], 0);
		TextDrawBackgroundColor(BolgeBar[i][47], 255);
		TextDrawFont(BolgeBar[i][47], 1);
		TextDrawSetProportional(BolgeBar[i][47], 1);
		TextDrawSetShadow(BolgeBar[i][47], 0);

		BolgeBar[i][48] = TextDrawCreate(377.136718, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][48], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][48], 1);
		TextDrawColor(BolgeBar[i][48], -1);
		TextDrawSetShadow(BolgeBar[i][48], 0);
		TextDrawSetOutline(BolgeBar[i][48], 0);
		TextDrawBackgroundColor(BolgeBar[i][48], 255);
		TextDrawFont(BolgeBar[i][48], 1);
		TextDrawSetProportional(BolgeBar[i][48], 1);
		TextDrawSetShadow(BolgeBar[i][48], 0);

		BolgeBar[i][49] = TextDrawCreate(379.836883, 350.416687, "I");
		TextDrawLetterSize(BolgeBar[i][49], 0.222898, 2.230000);
		TextDrawAlignment(BolgeBar[i][49], 1);
		TextDrawColor(BolgeBar[i][49], -1);
		TextDrawSetShadow(BolgeBar[i][49], 0);
		TextDrawSetOutline(BolgeBar[i][49], 0);
		TextDrawBackgroundColor(BolgeBar[i][49], 255);
		TextDrawFont(BolgeBar[i][49], 1);
		TextDrawSetProportional(BolgeBar[i][49], 1);
		TextDrawSetShadow(BolgeBar[i][49], 0);
	}
	return true;
}

public OnFilterScriptExit()
{
	for(new i = 0; i <= GetMaxPlayers(); i++)
	{
	    for(new x = 0; x < 50; x++)
	    {
	        TextDrawHideForPlayer(i, BolgeBar[i][x]);
	        TextDrawDestroy(BolgeBar[i][x]);
	    }
	}
	return true;
}

CMD:arttir(playerid, params[])
{
	Durum[playerid] = 0;
	for(new i = 0; i < 50; i++)
	{
	    TextDrawHideForPlayer(playerid, BolgeBar[playerid][i]);
	}
	for(new i = 0; i < 50; i++)
	{
	    TextDrawShowForPlayer(playerid, BolgeBar[playerid][i]);
	}

	KillTimer(DurumTimer[playerid]);
	DurumTimer[playerid] = SetTimerEx("art", 250, true, "d", playerid);
	return true;
}

forward art(playerid);
public art(playerid)
{
	if(Durum[playerid] == 100) return KillTimer(DurumTimer[playerid]);
	Durum[playerid]++;
	TD_Guncelle(playerid);
	return true;
}

stock TD_Guncelle(playerid)
{
	new Float: s1 = floatdiv(100, 50);
	new Float: s2 = floatdiv(Durum[playerid], s1);
	
	for(new i; i < 50; i++)
	{
	    if(i < s2)
	    {
		TextDrawColor(BolgeBar[playerid][i + 2], NEWEXPRenkleri[i]);
	    }
	    else
	    {
	        TextDrawColor(BolgeBar[playerid][i + 2], -1);
	    }
	    TextDrawShowForPlayer(playerid, BolgeBar[playerid][i + 2]);
	}
	return true;
}
