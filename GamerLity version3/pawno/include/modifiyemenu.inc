#include <a_samp>
static
	Menu:TuningMenu,
	Menu:TuningMenu1,
	Menu:Paintjobs,
	Menu:Colors,
	Menu:Colors1,
	Menu:Exhausts,
	Menu:Frontbumper,
	Menu:Rearbumper,
	Menu:Roof,
	Menu:Spoilers,
	Menu:Sideskirts,
	Menu:Bullbars,
	Menu:Wheels,
	Menu:Wheels1,
	Menu:Carstereo,
	Menu:Hydraulics,
	Menu:Nitro, 
	pvehicleid[MAX_PLAYERS],
	pmodelid[MAX_PLAYERS]
	;
forward OnGameModeInit_Mod();
public OnGameModeInit_Mod()
{
	//Modifiye menüsü______________________________________________________________
	TuningMenu = CreateMenu("ModifiyeMenu",1,400.0, 200.0, 175.0, 175.0);
    AddMenuItem(TuningMenu,0,"- ~w~Boya isleri");
    AddMenuItem(TuningMenu,0,"- ~w~Renkler");
    AddMenuItem(TuningMenu,0,"- ~w~Egzostlar");
    AddMenuItem(TuningMenu,0,"- ~w~On Tamponlar");
    AddMenuItem(TuningMenu,0,"- ~w~Arka Tamponlar");
    AddMenuItem(TuningMenu,0,"- ~w~Cati");
    AddMenuItem(TuningMenu,0,"- ~w~Ruzgarliklar");
    AddMenuItem(TuningMenu,0,"- ~w~Kenarlar");
    AddMenuItem(TuningMenu,0,"- ~w~Bullbars");
    AddMenuItem(TuningMenu,0,"- ~w~Jantlar");
    AddMenuItem(TuningMenu,0,"- ~w~Tesisat");
    AddMenuItem(TuningMenu,0,"- ~w~Sonraki Sayfa");
    Paintjobs = CreateMenu("ModifiyeMenu",1,400.0, 200.0, 175.0, 175.0);
	SetMenuColumnHeader(Paintjobs,0,"Boya isleri");
	AddMenuItem(Paintjobs,0,"- ~w~Boya 1");
	AddMenuItem(Paintjobs,0,"- ~w~Boya 2");
	AddMenuItem(Paintjobs,0,"- ~w~Boya 3");
	AddMenuItem(Paintjobs,0,"- ~w~Boya 4");
	AddMenuItem(Paintjobs,0,"- ~w~Boya 5");
	AddMenuItem(Paintjobs,0,"Ana Menu");
	Colors = CreateMenu("ModifiyeMenu",1,400.0, 200.0, 175.0, 175.0);
	SetMenuColumnHeader(Colors,0,"Renkler");
	AddMenuItem(Colors,0,"- ~w~Siyah");
	AddMenuItem(Colors,0,"- ~w~Beyaz");
	AddMenuItem(Colors,0,"- ~w~Kirmizi");
	AddMenuItem(Colors,0,"- ~w~Mavi");
	AddMenuItem(Colors,0,"- ~w~Yesil");
	AddMenuItem(Colors,0,"- ~w~Sari");
	AddMenuItem(Colors,0,"- ~w~Pembe");
	AddMenuItem(Colors,0,"- ~w~Kahve");
	AddMenuItem(Colors,0,"- ~w~Sonraki Sayfa");
	Colors1 = CreateMenu("ModifiyeMenu",1,400.0, 200.0, 175.0, 175.0);
	SetMenuColumnHeader(Colors1,0,"Colors");
    AddMenuItem(Colors1,0,"- ~w~Gri");
	AddMenuItem(Colors1,0,"- ~w~Altin");
	AddMenuItem(Colors1,0,"- ~w~Koyu Mavi");
	AddMenuItem(Colors1,0,"- ~w~Acik Mavi");
	AddMenuItem(Colors1,0,"- ~w~Yesil");
	AddMenuItem(Colors1,0,"- ~w~Acik Gri");
	AddMenuItem(Colors1,0,"- ~w~Koyu kirmizi");
	AddMenuItem(Colors1,0,"- ~w~Koyu Kahve");
	AddMenuItem(Colors1,0,"- ~w~Ana Menu");
	Exhausts = CreateMenu("ModifiyeMenu",1,400.0, 200.0, 175.0, 175.0);
	SetMenuColumnHeader(Exhausts,0,"Egzostlar");
	AddMenuItem(Exhausts,0,"- ~w~Wheel Arch Alien Egzost");
	AddMenuItem(Exhausts,0,"- ~w~Wheel Arch X-Flow Egzost");
	AddMenuItem(Exhausts,0,"- ~w~Locos Low Chromer Egzost");
	AddMenuItem(Exhausts,0,"- ~w~Locos Low Slamin Egzost");
	AddMenuItem(Exhausts,0,"Ana Menu");
	Frontbumper = CreateMenu("ModifiyeMenu",1,400.0, 200.0, 175.0, 175.0);
	SetMenuColumnHeader(Frontbumper,0,"On Tamponlar");
	AddMenuItem(Frontbumper,0,"- ~w~Wheel Arch Alien On tampon");
	AddMenuItem(Frontbumper,0,"- ~w~Wheel Arch X-Flow On tampon");
	AddMenuItem(Frontbumper,0,"- ~w~Locos Low Chromer On tampon");
	AddMenuItem(Frontbumper,0,"- ~w~Locos Low Slamin On tampon");
	AddMenuItem(Frontbumper,0,"- ~w~Ana Menu");
	Rearbumper = CreateMenu("ModifiyeMenu",1,400.0, 200.0, 175.0, 175.0);
	SetMenuColumnHeader(Rearbumper,0,"Arka Tamponlar");
	AddMenuItem(Rearbumper,0,"- ~w~Wheel Arch Alien Arka tampon");
	AddMenuItem(Rearbumper,0,"- ~w~Wheel Arch X-Flow Arka tampon");
	AddMenuItem(Rearbumper,0,"- ~w~Locos Low Chromer Arka tampon");
	AddMenuItem(Rearbumper,0,"- ~w~Locos Low Slamin Arka tampon");
	AddMenuItem(Rearbumper,0,"- ~w~Ana Menu");
	Roof = CreateMenu("ModifiyeMenu",1,400.0, 200.0, 175.0, 175.0);
	SetMenuColumnHeader(Roof,0,"Cati");
	AddMenuItem(Roof,0,"- ~w~Wheel Arch Alien Cati Havalik");
	AddMenuItem(Roof,0,"- ~w~Wheel Arch X-Flow Cati Havalik");
	AddMenuItem(Roof,0,"- ~w~Locos Low Hardtop Cati");
	AddMenuItem(Roof,0,"- ~w~Locos Low Softtop Cati");
	AddMenuItem(Roof,0,"- ~w~Ana Menu");
	Spoilers = CreateMenu("ModifiyeMenu",1,400.0, 200.0, 175.0, 175.0);
	SetMenuColumnHeader(Spoilers,0,"Ruzgarliklar");
	AddMenuItem(Spoilers,0,"- ~w~Alien Ruzgarlik");
	AddMenuItem(Spoilers,0,"- ~w~X-Flow Ruzgarlik");
	AddMenuItem(Spoilers,0,"- ~w~Ana Menu");
	Sideskirts = CreateMenu("ModifiyeMenu",1,400.0, 200.0, 175.0, 175.0);
	SetMenuColumnHeader(Sideskirts,0,"Kenarlar");
	AddMenuItem(Sideskirts,0,"- ~w~Wheel Arch Alien Kenarlik");
	AddMenuItem(Sideskirts,0,"- ~w~Wheel Arch X-Flow Kenarlik");
    AddMenuItem(Sideskirts,0,"- ~w~Locos Low Chrome Cubuk");
    AddMenuItem(Sideskirts,0,"- ~w~Locos Low Chrome Cubuk");
    AddMenuItem(Sideskirts,0,"- ~w~Locos Low Chrome Kavis");
    AddMenuItem(Sideskirts,0,"- ~w~Locos Low Chrome Doseme");
    AddMenuItem(Sideskirts,0,"- ~w~Locos Low Camurluk");
	AddMenuItem(Sideskirts,0,"Ana Menu");
	Bullbars = CreateMenu("ModifiyeMenu",1,400.0, 200.0, 175.0, 175.0);
	SetMenuColumnHeader(Bullbars,0,"Bullbars");
	AddMenuItem(Bullbars,0,"- ~w~Locos Low Chrome Grill");
	AddMenuItem(Bullbars,0,"- ~w~Locos Low Chrome Bars");
	AddMenuItem(Bullbars,0,"- ~w~Locos Low Chrome Lights");
	AddMenuItem(Bullbars,0,"- ~w~Locos Low Chrome Bullbar");
	AddMenuItem(Bullbars,0,"- ~w~Ana Menu");
	Wheels = CreateMenu("ModifiyeMenu",1,400.0, 200.0, 175.0, 175.0);
	SetMenuColumnHeader(Wheels,0,"Jantlar");
	AddMenuItem(Wheels,0,"- ~w~Offroad");
	AddMenuItem(Wheels,0,"- ~w~Mega");
	AddMenuItem(Wheels,0,"- ~w~Wires");
	AddMenuItem(Wheels,0,"- ~w~Twist");
	AddMenuItem(Wheels,0,"- ~w~Grove");
	AddMenuItem(Wheels,0,"- ~w~Import");
	AddMenuItem(Wheels,0,"- ~w~Atomic");
	AddMenuItem(Wheels,0,"- ~w~Ahab");
	AddMenuItem(Wheels,0,"- ~w~Virtual");
	AddMenuItem(Wheels,0,"- ~w~Access");
	AddMenuItem(Wheels,0,"- ~w~Sonraki Sayfa");
	AddMenuItem(Wheels,0,"- ~w~Ana Menu");
	Wheels1 = CreateMenu("ModifiyeMenu",1,400.0, 200.0, 175.0, 175.0);
	SetMenuColumnHeader(Wheels1,0,"Jantlar");
	AddMenuItem(Wheels1,0,"- ~w~Trance");
	AddMenuItem(Wheels1,0,"- ~w~Shadow");
	AddMenuItem(Wheels1,0,"- ~w~Rimshine");
	AddMenuItem(Wheels1,0,"- ~w~Classic");
	AddMenuItem(Wheels1,0,"- ~w~Cutter");
	AddMenuItem(Wheels1,0,"- ~w~Switch");
	AddMenuItem(Wheels1,0,"- ~w~Dollar");
	AddMenuItem(Wheels1,0,"- ~w~Ana Menu");
	Carstereo = CreateMenu("ModifiyeMenu",1,400.0, 200.0, 175.0, 175.0);
	SetMenuColumnHeader(Carstereo,0,"Tesisat");
	AddMenuItem(Carstereo,0,"- ~w~Bass Boost");
	AddMenuItem(Carstereo,0,"- ~w~Ana Menu");
//-------------------------Main Menu page 2 ------------------------------------

 	TuningMenu1= CreateMenu("ModifiyeMenu",1,400.0, 200.0, 175.0, 175.0);
    AddMenuItem(TuningMenu1,0,"- ~w~Hydraulics");
    AddMenuItem(TuningMenu1,0,"- ~w~Nitro");
    AddMenuItem(TuningMenu1,0,"- ~w~Repair Car");
    AddMenuItem(TuningMenu1,0,"- ~w~Ana Menu");
	Hydraulics = CreateMenu("ModifiyeMenu",1,400.0, 200.0, 175.0, 175.0);
	SetMenuColumnHeader(Hydraulics,0,"Hydraulics");
	AddMenuItem(Hydraulics,0,"- ~w~Hydraulics");
	AddMenuItem(Hydraulics,0,"- ~w~Main Menu");
	Nitro = CreateMenu("ModifiyeMenu",1,400.0, 200.0, 175.0, 175.0);
	SetMenuColumnHeader(Nitro,0,"Nitro");
	AddMenuItem(Nitro,0,"- ~w~2x Nitrous");
	AddMenuItem(Nitro,0,"- ~w~5x Nitrous");
	AddMenuItem(Nitro,0,"- ~w~10x Nitrous");
	AddMenuItem(Nitro,0,"- ~w~Ana Menu");
//_____________________________________________________________________________
	return 1;
}
forward OnPlayerCommandText_Mod(playerid,cmdtext[]);
public OnPlayerCommandText_Mod(playerid,cmdtext[])
{//{3333FF}mavi{15FF00}yeþil{0040FF}mavi{99CCCC}grimavikariþimi{FFFF00}sarý{FF0015}kýrmýzý{996633}kahverengi{993366}morumsu{A53232}kahverengimorumsukarýþýk{FFFFFF}beyaz{0049FF}«{FFFF00}®{0049FF}»{FFFFFF}
	if(strcmp("/tune", cmdtext, true, 10) == 0 || strcmp("/modifiye", cmdtext, true, 10) == 0)
	{
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {02C4BB}/modifiye - /tune {FFFFFF}özelliðini sadece sürücüler kullanabilir.");
		{
  		return ModCar(playerid);
		}
	}
	return 0;
}
forward ModCar(playerid);
public ModCar(playerid) {
	switch(pmodelid[playerid]) {
        case 562,565,559,561,560,575,534,567,536,535,576,411,579,602,496,518,527,589,597,419,
		533,526,474,545,517,410,600,436,580,439,549,491,445,604,507,585,587,466,492,546,551,516,
		426, 547, 405, 409, 550, 566, 540, 421,	529,431,438,437,420,525,552,416,433,427,490,528,
		407,544,470,598,596,599,601,428,499,609,524,578,486,406,573,455,588,403,514,423,
		414,443,515,456,422,482,530,418,572,413,440,543,583,478,554,402,542,603,475,568,504,457,
        483,508,429,541,415,480,434,506,451,555,477,400,404,489,479,442,458,467,558: {
  		ShowMenuForPlayer(TuningMenu, playerid);
	    TogglePlayerControllable(playerid,0);
 		return SendClientMessage(playerid, 0xFFFFFFAA, "{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Modifiye parçasýný seçtikten sonra Space tuþu ile ekleyebilirsiniz.");
		}
		default: return SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu aracý modifiye edemezsin.");
	}
	return 1;
}//{3333FF}mavi{15FF00}yeþil{0040FF}mavi{99CCCC}grimavikariþimi{FFFF00}sarý{FF0015}kýrmýzý{996633}kahverengi{993366}morumsu{A53232}kahverengimorumsukarýþýk{FFFFFF}beyaz{0049FF}«{FFFF00}®{0049FF}»{FFFFFF}
public OnPlayerExitedMenu(playerid)
{
	new Menu:Current = GetPlayerMenu(playerid);
	HideMenuForPlayer(Current, playerid);
	TogglePlayerControllable(playerid, true);
	if (funcidx("MAG_OnPlayerExitedMenu") != -1)
	{
		return CallLocalFunction("MAG_OnPlayerExitedMenu", "d",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerExitedMenu
	#undef OnPlayerExitedMenu
#else
	#define _ALS_OnPlayerExitedMenu
#endif
#define OnPlayerExitedMenu MAG_OnPlayerExitedMenu
forward MAG_OnPlayerExitedMenu(playerid);


public OnPlayerSelectedMenuRow(playerid, row)
{
	new Menu:Current = GetPlayerMenu(playerid);
 	if(Current == TuningMenu) {
	    switch(row){
	        case 0:	ShowMenuForPlayer(Paintjobs, playerid);
	        case 1:	ShowMenuForPlayer(Colors, playerid);
	        case 2: ShowMenuForPlayer(Exhausts, playerid);
	        case 3: ShowMenuForPlayer(Frontbumper, playerid);
	        case 4: ShowMenuForPlayer(Rearbumper, playerid);
	        case 5: ShowMenuForPlayer(Roof, playerid);
	        case 6: ShowMenuForPlayer(Spoilers, playerid);
	        case 7: ShowMenuForPlayer(Sideskirts, playerid);
			case 8: ShowMenuForPlayer(Bullbars, playerid);
	        case 9: ShowMenuForPlayer(Wheels, playerid);
	        case 10: ShowMenuForPlayer(Carstereo, playerid);
	        case 11: ShowMenuForPlayer(TuningMenu1, playerid);
		}
	}
	if(Current == Paintjobs) {
		switch(row){
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560 ||
				pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 || // Broadway
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 535 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 558)
		        {
					new car = GetPlayerVehicleID(playerid);
					ChangeVehiclePaintjob(car,0);
					SetPVarInt(playerid, "paintjob",0);
					SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýna Boya iþi eklendi.");
					ShowMenuForPlayer(Paintjobs, playerid);
				}
				else
				{
				   SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Boya iþleri sadece: Wheel Arch Angrls ve Loco Low Co uyumlu araçlara yapýlmaktadýr..");
			       ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 1:
			    if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560 ||
				pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 || // Broadway
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 535 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 558)
			    {
	                new car = GetPlayerVehicleID(playerid);
					ChangeVehiclePaintjob(car,1);
					SetPVarInt(playerid, "paintjob",1);
					SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýna Boya iþi eklendi.");
					ShowMenuForPlayer(Paintjobs, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Boya iþleri sadece:  Wheel Arch Angrls ve Loco Low Co uyumlu araçlara yapýlmaktadýr..");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
	      		if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560 ||
				pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 || // Broadway
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 535 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 558)
			    {
	                new car = GetPlayerVehicleID(playerid);
					ChangeVehiclePaintjob(car,2);
					SetPVarInt(playerid, "paintjob",2);
					SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýna Boya iþi eklendi.");
					ShowMenuForPlayer(Paintjobs, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Boya iþleri sadece: Wheel Arch Angrls ve Loco Low Co uyumlu araçlara yapýlmaktadýr..");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:
			    if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560 ||
				pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 || // Broadway
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 535 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 558)
			    {
	                new car = GetPlayerVehicleID(playerid);
					ChangeVehiclePaintjob(car,3);
					SetPVarInt(playerid, "paintjob",3);
					SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýna Boya iþi eklendi.");
					ShowMenuForPlayer(Paintjobs, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Boya iþleri sadece: Wheel Arch Angrls ve Loco Low Co uyumlu araçlara yapýlmaktadýr..");
				    ShowMenuForPlayer(TuningMenu, playerid);
			}

			case 4:
		    if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560 ||
				pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 || // Broadway
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 535 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 558)
			    {
	                new car = GetPlayerVehicleID(playerid);
					ChangeVehiclePaintjob(car,4);
					SetPVarInt(playerid, "paintjob",4);
					SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýna Boya iþi eklendi.");
					ShowMenuForPlayer(Paintjobs, playerid);
				}
				else
				{
	            	SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Boya iþleri sadece: Wheel Arch Angrls ve Loco Low Co uyumlu araçlara yapýlmaktadýr..");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
				case 5:
			{
		    	ShowMenuForPlayer(TuningMenu, playerid);
			}

		}
		}

	if(Current == Colors) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            ChangeVehicleColor(car,0,0);
		            //GivePlayerMoney(playerid,-150);
		            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýna boya yapýldý.");
		            ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,-1,"Boya yapicak paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 1:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,1,1);
			    //    GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýný baþarýyla tamir ettin.");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,-1,"Tamir yapicak paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,3,3);
			      //  GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýný baþarýyla tekrar boyadýn.");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
	      		 	SendClientMessage(playerid,-1,"Tekrar boyama için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,79,79);
			     //   GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýný baþarýyla tekrar boyadýn.");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,-1,"Tekrar boyama için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 4:
				if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,86,86);
			     //   GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýný baþarýyla tekrar boyadýn.");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,-1,"Tekrar boyama için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 5:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,6,6);
			      //  GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýný baþarýyla tekrar boyadýn.");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Tekrar boyama için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	            case 6:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,126,126);
			  //      GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýný baþarýyla tekrar boyadýn.");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Tekrar boyama için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 7:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,66,66);
			    //    GivePlayerMoney(playerid,-150);
	          		SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýný baþarýyla tekrar boyadýn.");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Tekrar boyama için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 8:ShowMenuForPlayer(Colors1, playerid);
	 }
	 }

	if(Current == Colors1) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            ChangeVehicleColor(car,24,24);
		            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýný baþarýyla tekrar boyadýn.");
		            ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Tekrar boyama için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	         case 1:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,123,123);
	          		SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýný baþarýyla tekrar boyadýn.");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Tekrar boyama için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,53,53);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýný baþarýyla tekrar boyadýn.");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Tekrar boyama için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,93,93);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýný baþarýyla tekrar boyadýn.");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Tekrar boyama için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 4:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,83,83);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýný baþarýyla tekrar boyadýn.");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Tekrar boyama için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 5:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,60,60);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýný baþarýyla tekrar boyadýn.");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Tekrar boyama için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	            case 6:
	      		if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,126,126);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýný baþarýyla tekrar boyadýn.");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Tekrar boyama için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 7:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,110,110);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýný baþarýyla tekrar boyadýn.");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Tekrar boyama için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 8:ShowMenuForPlayer(TuningMenu, playerid);
	 }
	 }


	if(Current == Exhausts) {
		switch(row){



	//-------------------Alien Exausts-Wheel Arch Cars----------------------------------------------------------

		    case 0:

		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562)
		            {
		            	AddVehicleComponent(car,1034);
		            	SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Egzost, Elegy Aracýna eklendi.");
		            	ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 565)
					{
					    AddVehicleComponent(car,1046);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Egzost, Flash Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 559)
					{
					    AddVehicleComponent(car,1065);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Egzost, Jester Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 561)
					{
					    AddVehicleComponent(car,1064);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Egzost, Stratum Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 560)
					{
					    AddVehicleComponent(car,1028);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Egzost, Sultan Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 558)
					{
					    AddVehicleComponent(car,1089);
				 	    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Egzost, Uranus Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
	    			}
					}
	  			 	else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Wheel Arch Angels uyumlu araçlara yapýlmaktadýr..");
					ShowMenuForPlayer(TuningMenu, playerid);
					}



	//-------------------X-Flow Exausts-Wheel Arch Cars----------------------------------------------------------
			case 1:
			    if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562)
			        {
			            AddVehicleComponent(car,1037);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Egzost, Elegy Aracýna eklendi.");
			            ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 565)
					{
					    AddVehicleComponent(car,1045);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Egzost, Flash Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 559)
					{
					    AddVehicleComponent(car,1066);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Egzost, Jester Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 561)
					{
					    AddVehicleComponent(car,1059);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Egzost, Stratum Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 560)
					{
					    AddVehicleComponent(car,1029);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Egzost, Sultan Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 558)
					{
					    AddVehicleComponent(car,1092);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Egzost, Uranus Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Wheel Arch Angels uyumlu araçlara yapýlmaktadýr..");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
//{3333FF}mavi{15FF00}yeþil{0040FF}mavi{99CCCC}grimavikariþimi{FFFF00}sarý{FF0015}kýrmýzý{996633}kahverengi{993366}morumsu{A53232}kahverengimorumsukarýþýk{FFFFFF}beyaz{0049FF}«{FFFF00}®{0049FF}»{FFFFFF}
	//-------------------Locos Low Chromer Exausts----------------------------------------------------------
			case 2:
			    if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 535)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponent(car,1044);
		             	SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer Egzost, Broadway Aracýna eklendi.");
			            ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponent(car,1126);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer Egzost, Remington Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponent(car,1129);
	                    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer Egzost, Savanna Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1104);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer Egzost, Blade Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponent(car,1113);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer Egzost, Slamvan Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponent(car,1136);
					   	SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer Egzost, Tornado Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Locos Low Co uyumlu araçlara yapilir");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------Locos Low Salmin Exausts----------------------------------------------------------
			case 3:
			    if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 535)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponent(car,1043);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin Egzost, Broadway Aracýna eklendi.");
			            ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponent(car,1127);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin Egzost, Remington Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponent(car,1132);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin Egzost, Savanna Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1105);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin Egzost, Blade Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}

					else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponent(car,1114);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin Egzost, Slamvan Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}

					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponent(car,1135);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin Egzost, Tornado Aracýna eklendi.");
					    ShowMenuForPlayer(Exhausts, playerid);
					}

					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Locos Low Co uyumlu araçlara yapýlabilir.");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

			case 4:ShowMenuForPlayer(TuningMenu, playerid);
		}
		}

	if(Current == Frontbumper) {
		switch(row){


	//-------------------Alien Front Bumper-Wheel Arch Cars----------------------------------------------------------
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
				{
		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562) // Elegy
		            {
		            	AddVehicleComponent(car,1171);
	              		SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien on tampon, Elegy Aracýna eklendi.");
		            	ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1153);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien on tampon, Flash Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jester
					{
					    AddVehicleComponent(car,1160);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien on tampon, Jester Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1155);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien on tampon, Stratum Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1169);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien on tampon, Sultan Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 558) // Uranus
					{
					    AddVehicleComponent(car,1166);
				 	    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien on tampon, Uranus Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Wheel Arch Angels uyumlu araçlara yapýlabilir.");
					ShowMenuForPlayer(TuningMenu, playerid);
					}


	//-------------------X-Flow Front Bumper-Wheel Arch Cars----------------------------------------------------------
			case 1:

				if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {

			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562) // Elegy
			        {
			            AddVehicleComponent(car,1172);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow on tampon, Elegy Aracýna eklendi.");
			            ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1152);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow on tampon, Flash Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jetser
					{
					    AddVehicleComponent(car,1173);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow on tampon, Jester Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1157);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow on tampon, Stratum Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1170);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow on tampon, Sultan Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 558)  // Uranus
					{
					    AddVehicleComponent(car,1165);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow on tampon, Uranus Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Wheel Arch Angels uyumlu araçlara yapýlabilir.");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------Locos Low Chromer Front Bumper----------------------------------------------------------
			case 2:

	      		if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 535)
				{
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponent(car,1174);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer on tampon, Broadway Aracýna eklendi.");
			            ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponent(car,1179);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer on tampon, Remington Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponent(car,1189);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer on tampon, Savanna Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1182);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer on tampon, Blade Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponent(car,1115);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer on tampon, Slamvan Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponent(car,1191);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer on tampon, Tornado Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Locos Low Co uyumlu araçlara yapýlabilir.");
					ShowMenuForPlayer(TuningMenu, playerid);
					}



	//-------------------Locos Low Salmin Front Bumper----------------------------------------------------------
			case 3:

			    if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
	            pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 576)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponent(car,1175);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin on tampon, Broadway Aracýna eklendi.");
			            ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponent(car,1185);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin on tampon, Remington Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponent(car,1188);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin on tampon, Savanna Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1181);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin on tampon, Blade Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}

				    else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponent(car,1116);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin on tampon, Slamvan Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponent(car,1190);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin on tampon, Tornado Aracýna eklendi.");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}

					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Locos Low Co uyumlu araçlara yapýlmaktadýr..");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

			case 4:ShowMenuForPlayer(TuningMenu, playerid);
		}
		}


	if(Current == Rearbumper) {
		switch(row){


	//-------------------Alien Rear Bumper-Wheel Arch Cars----------------------------------------------------------
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {

		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562) // Elegy
		            {
		            	AddVehicleComponent(car,1149);
	              		SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien arka tampon, Elegy Aracýna eklendi.");
		            	ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1150);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien arka tampon, Flash Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jester
					{
					    AddVehicleComponent(car,1159);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien arka tampon, Jester Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1154);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien arka tampon, Stratum Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1141);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien arka tampon, Sultan Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 558) // Uranus
					{
					    AddVehicleComponent(car,1168);
				 	    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien arka tampon, Uranus Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Wheel Arch Angels Co uyumlu araçlara yapýlmaktadýr.");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------X-Flow Rear Bumper-Wheel Arch Cars----------------------------------------------------------
			case 1:

				if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {


			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562) // Elegy
			        {
			            AddVehicleComponent(car,1148);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch  X-Flow arka tampon, Elegy Aracýna eklendi.");
			            ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1151);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch  X-Flow arka tampon, Flash Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jetser
					{
					    AddVehicleComponent(car,1161);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch  X-Flow arka tampon, Jester Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1156);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch  X-Flow arka tampon, Stratum Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1140);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch  X-Flow arka tampon, Sultan Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 558)  // Uranus
					{
					    AddVehicleComponent(car,1167);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch  X-Flow arka tampon, Uranus Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Wheel Arch Angels uyumlu araçlara yapýlmaktadýr.");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Chromer rear Bumper----------------------------------------------------------
			case 2:
			    if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 535)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponent(car,1176);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer arka tampon, Broadway Aracýna eklendi.");
			            ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponent(car,1180);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer arka tampon, Reminton Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponent(car,1187);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer arka tampon, Savanna Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1184);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer arka tampon, Blade Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponent(car,1109);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer arka tampon, Slamvan Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponent(car,1192);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chromer arka tampon, Tornado Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Locos Low Co uyumlu araçlara yapýlmaktadýr.");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Salmin Rear Bumper----------------------------------------------------------
			case 3:
			    if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 535)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponent(car,1177);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin arka tampon, Broadway Aracýna eklendi.");
			            ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponent(car,1178);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin arka tampon, Remington Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponent(car,1186);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin arka tampon, Savanna Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1183);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin arka tampon, Blade Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}

					else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponent(car,1110);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin arka tampon, Slamvan Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}

					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponent(car,1193);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Slamin arka tampon, Tornado Aracýna eklendi.");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}

					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Locos Low Co uyumlu araçlara yapýlmaktadýr.");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

			case 4:ShowMenuForPlayer(TuningMenu, playerid);
		}
		}



	if(Current == Roof) {
		switch(row){


	//-------------------Alien Roof Vent-Wheel Arch Cars----------------------------------------------------------
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {

		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562) // Elegy
		            {
		            	AddVehicleComponent(car,1035);
	              		SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien cati havalik, Elegy Aracýna eklendi.");
		            	ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1054);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien cati havalik, Flash Aracýna eklendi.");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jester
					{
					    AddVehicleComponent(car,1067);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien cati havalik, Jester Aracýna eklendi.");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1055);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien cati havalik, Stratum Aracýna eklendi.");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1032);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien cati havalik, Sultan Aracýna eklendi.");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 558) // Uranus
					{
					    AddVehicleComponent(car,1088);
				 	    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien cati havalik, Uranus Aracýna eklendi.");
					    ShowMenuForPlayer(Roof, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Wheel Arch Angels uyumlu araçlara yapýlmaktadýr.");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------X-Flow Roof Vent-Wheel Arch Cars----------------------------------------------------------
			case 1:

				if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {


			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562) // Elegy
			        {
			            AddVehicleComponent(car,1035);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow cati havalik, Elegy Aracýna eklendi.");
			            ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1053);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow cati havalik, Flash Aracýna eklendi.");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jetser
					{
					    AddVehicleComponent(car,1068);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow cati havalik, Jester Aracýna eklendi.");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1061);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow cati havalik, Stratum Aracýna eklendi.");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1033);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow cati havalik, Sultan Aracýna eklendi.");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 558)  // Uranus
					{
					    AddVehicleComponent(car,1091);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow cati havalik, Uranus Aracýna eklendi.");
					    ShowMenuForPlayer(Roof, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Wheel Arch Angels Co uyumlu araçlara yapýlmaktadýr.");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Hardtop Roof ----------------------------------------------------------
			case 2:
			    if(pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 567) // Savanna
			        {
			            AddVehicleComponent(car,1130);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Hardtop cati, Broadway Aracýna eklendi.");
			            ShowMenuForPlayer(Roof, playerid);
					}
	   				else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1128);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Hardtop cati, Blade Aracýna eklendi.");
					    ShowMenuForPlayer(Roof, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Locos Low Co uyumlu Savanna ve Blade araclarina yapýlmaktadýr..");
					ShowMenuForPlayer(Roof, playerid);
					}
	//-------------------Locos Low Softtop Roof ----------------------------------------------------------
			case 3:
			    if(pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 567) // Savanna
			        {
			            AddVehicleComponent(car,1131);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Softtop cati, Broadway Aracýna eklendi.");
			            ShowMenuForPlayer(Roof, playerid);
					}
	   				else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1103);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Softtop cati, Blade Aracýna eklendi.");
					    ShowMenuForPlayer(Roof, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Locos Low Co uyumlu Savanna ve Blade araclarina yapýlmaktadýr.");
					ShowMenuForPlayer(Roof, playerid);
					}

			case 4:ShowMenuForPlayer(TuningMenu, playerid);
		}
		}


	if(Current == Spoilers) {
		switch(row){


	//-------------------Alien Spoilers-Wheel Arch Cars----------------------------------------------------------
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {

		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562) // Elegy
		            {
		            	AddVehicleComponent(car,1147);
	              		SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Ruzgarlik, Elegy Aracýna eklendi.");
		            	ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1049);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Ruzgarlik, Flash Aracýna eklendi.");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jester
					{
					    AddVehicleComponent(car,1162);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Ruzgarlik, Jester Aracýna eklendi.");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1158);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Ruzgarlik, Stratum Aracýna eklendi.");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1138);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Ruzgarlik, Sultan Aracýna eklendi.");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 558) // Uranus
					{
					    AddVehicleComponent(car,1164);
				 	    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Ruzgarlik, Uranus Aracýna eklendi.");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Wheel Arch Angels uyumlu araçlara yapýlmaktadýr.");
					ShowMenuForPlayer(TuningMenu, playerid);
					}


	//-------------------X-Flow Spoilers-Wheel Arch Cars----------------------------------------------------------
			case 1:

				if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {


			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562) // Elegy
			        {
			            AddVehicleComponent(car,1146);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Ruzgarlik, Elegy Aracýna eklendi.");
			            ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1150);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Ruzgarlik, Flash Aracýna eklendi.");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jetser
					{
					    AddVehicleComponent(car,1158);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Ruzgarlik, Jester Aracýna eklendi.");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1060);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Ruzgarlik, Stratum Aracýna eklendi.");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1139);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Ruzgarlik, Sultan Aracýna eklendi.");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 558)  // Uranus
					{
					    AddVehicleComponent(car,1163);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Ruzgarlik, Uranus Aracýna eklendi.");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece X-Flow Arch Angels uyumlu araçlara yapýlmaktadýr..");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	        	case 2:
				{
	            ShowMenuForPlayer(TuningMenu, playerid);
	            }
		}
		}


	if(Current == Sideskirts) {
		switch(row){


	//-------------------Alien Sideskirts Wheel Arch Cars----------------------------------------------------------
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {

		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562) // Elegy
		            {
		            	AddVehicleComponent(car,1036);
		            	AddVehicleComponent(car,1040);
	              		SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Kenarlik, Elegy Aracýna eklendi.");
		            	ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1047);
					    AddVehicleComponent(car,1051);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Kenarlik, Flash Aracýna eklendi.");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jester
					{
					    AddVehicleComponent(car,1069);
					    AddVehicleComponent(car,1071);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Kenarlik, Jester Aracýna eklendi.");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1056);
					    AddVehicleComponent(car,1062);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Kenarlik, Stratum Aracýna eklendi.");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1026);
					    AddVehicleComponent(car,1027);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Kenarlik, Sultan Aracýna eklendi.");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 558) // Uranus
					{
					    AddVehicleComponent(car,1090);
					    AddVehicleComponent(car,1094);
				 	    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch Alien Kenarlik, Uranus Aracýna eklendi.");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Wheel Arch Angels uyumlu araçlara yapýlmaktadýr.");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------X-Flow Sideskirts-Wheel Arch Cars----------------------------------------------------------
			case 1:

				if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {


			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562) // Elegy
			        {
			            AddVehicleComponent(car,1039);
			            AddVehicleComponent(car,1041);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Kenarlik Elegy Aracýna eklendi.");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1048);
					    AddVehicleComponent(car,1052);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Kenarlik Flash Aracýna eklendi.h");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jetser
					{
					    AddVehicleComponent(car,1070);
					    AddVehicleComponent(car,1072);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Kenarlik Jester Aracýna eklendi.");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1057);
					    AddVehicleComponent(car,1063);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Kenarlik Stratum Aracýna eklendi.");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1031);
					    AddVehicleComponent(car,1030);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Kenarlik, Sultan Aracýna eklendi.");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 558)  // Uranus
					{
					    AddVehicleComponent(car,1093);
					    AddVehicleComponent(car,1095);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wheel Arch X-Flow Kenarlik, Uranus Aracýna eklendi.");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Wheel Arch Angels uyumlu araçlara yapýlmaktadýr.");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------Locos Low Chrome Strip Side Skirts----------------------------------------------------------
			case 2:
			    if(pmodelid[playerid] == 575 ||
	               pmodelid[playerid] == 536 ||
	               pmodelid[playerid] == 576 ||
		 	       pmodelid[playerid] == 567)
	               {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
	       		        AddVehicleComponent(car,1042);
	       		        AddVehicleComponent(car,1099);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Low Chrome Strip Kenarlik, Broadway Aracýna eklendi.");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
	   				else if(pmodelid[playerid] == 567) // Savanna
					{
					    AddVehicleComponent(car,1102);
					    AddVehicleComponent(car,1133);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Low Chrome Strip Kenarlik, Savanna Aracýna eklendi.");
	    		        ShowMenuForPlayer(Sideskirts, playerid);
	                }
	                else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponent(car,1134);
					    AddVehicleComponent(car,1137);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Low Chrome Strip Kenarlik, Tornado Aracýna eklendi.");
	    		        ShowMenuForPlayer(Sideskirts, playerid);
	                }
	                else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1108);
					    AddVehicleComponent(car,1107);
					    SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Low Chrome Strip Kenarlik, Blade Aracýna eklendi.");
	                    ShowMenuForPlayer(Sideskirts, playerid);
	                }
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Locos Low araclari Brodway, Savanna Tornado ve Blade'e yapýlmaktadýr.");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Chrome Flames Side Skirts----------------------------------------------------------
			case 3:
			    if(pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 534)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 534) // Remington
			        {
			            AddVehicleComponent(car,1122);
			            AddVehicleComponent(car,1101);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chrome Kenarlik, Remington Aracýna eklendi.");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Locos Low araci Remington'a yapýlabilir. ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Chrome Arches Side Skirts----------------------------------------------------------

			case 4:
			    if(pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 534)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 534) // Remington
			        {
			            AddVehicleComponent(car,1106);
			            AddVehicleComponent(car,1124);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chrome Arches Kenarlik, Remington Aracýna eklendi.");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Locos Low araci Remington'a yapýlabilir. ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}




	//-------------------Locos Low Chrome Trim Side Skirts----------------------------------------------------------
			case 5:
			    if(pmodelid[playerid] == 535)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 535) // Slamvan
			        {
			            AddVehicleComponent(car,1118);
			            AddVehicleComponent(car,1120);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chrome Trim Kenarlik, Slamvan Aracýna eklendi.");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Locos Low araci Slamvan'a yapýlabilir. ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------Locos Low Chrome Wheelcovers Side Skirts----------------------------------------------------------
	  case 6:
			    if(pmodelid[playerid] == 535)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 535) // Slamvan
			        {
			            AddVehicleComponent(car,1119);
			            AddVehicleComponent(car,1121);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chrome Wheelcovers, Slamvan Aracýna eklendi.");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Locos Low araci Slamvan'a yapýlabilir. ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

			   case 7:ShowMenuForPlayer(TuningMenu, playerid);
		}
		}

	//-------------------Locos Low Chrome Grill ----------------------------------------------------------

	if(Current == Bullbars) {
		switch(row){

	        case 0:
			    if(pmodelid[playerid] == 534)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 534) // Remington
			        {
			            AddVehicleComponent(car,1100);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chrome Grill, Remington Aracýna eklendi.");
			            ShowMenuForPlayer(Bullbars, playerid);
			        }
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Locos Low araci Remington'a yapýlabilir. ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Chrome Bars ----------------------------------------------------------
			case 1:
			    if(pmodelid[playerid] == 534)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 534) // Remington
			        {
			            AddVehicleComponent(car,1123);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chrome Bars, Remington Aracýna eklendi.");
			            ShowMenuForPlayer(Bullbars, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Locos Low araci Remington'a yapýlabilir. ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Chrome Lights ----------------------------------------------------------


			case 2:
			    if(pmodelid[playerid] == 534)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 534) // Remington
			        {
			            AddVehicleComponent(car,1125);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chrome Lights, Remington Aracýna eklendi.");
			            ShowMenuForPlayer(Bullbars, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Locos Low araci Remington'a eklendi. ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}




	//-------------------Locos Low Chrome Bullbar ----------------------------------------------------------


	        case 3:
			    if(pmodelid[playerid] == 535)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 535) // Slamvan
			        {
			            AddVehicleComponent(car,1117);
			            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Locos Low Chrome Lights, Slamvan Aracýna eklendi.");
			            ShowMenuForPlayer(Bullbars, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,-1,"{0049FF}«{FFFF00}®{0049FF}» {ff0015}Hata: {ffffff} Bu modifiye sadece Locos Low araci Slamvan'a yapýlabilir. ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}








			case 4:ShowMenuForPlayer(TuningMenu, playerid);
		}
		}



	if(Current == Wheels) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponent(car,1025);
		            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Offroad Jant eklendi. ");
		            ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 1:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1074);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Mega Jantlar eklendi.");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
	                AddVehicleComponent(car,1076);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Wires Jantlar eklendi.");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1078);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Twist Jantlar eklendi.");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
	      		 	SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(Wheels, playerid);
				}
			case 4:
				if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1081);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Grove Jantlar eklendi.");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 5:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
	                AddVehicleComponent(car,1082);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Import Jantlar eklendi.");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	   		case 6:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1085);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Atomic Jantlar eklendi.");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 7:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1096);
	          		SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Ahab Jantlar eklendi.");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 8:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1097);
	          		SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Virtual Jantlar eklendi.");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	 		case 9:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1098);
	          		SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Access Jantlar eklendi.");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	        case 10:
				{

				    ShowMenuForPlayer(Wheels1, playerid);
				}

			case 11:
				{

				    ShowMenuForPlayer(TuningMenu, playerid);
				}

	 	}
	 }

	if(Current == Wheels1) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponent(car,1084);
		            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Trance Jantlar eklendi. ");
		            ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 1:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1073);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Shadow Jantlar eklendi.");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
	                AddVehicleComponent(car,1075);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Rimshine Jantlar eklendi.");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
	      	 		SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1077);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Classic Jantlar eklendi.");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(Wheels, playerid);
				}
			case 4:
				if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1079);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Cutter Jantlar eklendi.");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 5:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
	                AddVehicleComponent(car,1080);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Switch Jantlar eklendi.");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	   		case 6:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1083);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Dollar Jantlar eklendi.");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	        case 7:
				{

				    ShowMenuForPlayer(TuningMenu, playerid);
				}
		 }
	 }


	if(Current == Carstereo) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponent(car,1086);
		            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff}Streo Bass Tesisat eklendi. ");
		            ShowMenuForPlayer(Carstereo, playerid);
				}
				else
				{
	                SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
			    }
			case 1:

			    {
			        ShowMenuForPlayer(TuningMenu, playerid);
				}
		 }
	 }

	if(Current == Hydraulics) {
		switch(row){
		    case 0:
	            if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponent(car,1087);
		            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Hidrolik eklendi. ");
		            ShowMenuForPlayer(Hydraulics, playerid);
				}
				else
				{
	                SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
			    }

			case 1:

			    {
			        ShowMenuForPlayer(TuningMenu, playerid);
				}
		 }
	 }

	if(Current == Nitro) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponent(car,1008);
		            SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} 2x Nitro eklendi. ");
		            ShowMenuForPlayer(Nitro, playerid);
				}
				else
				{
	                SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
			    }
			case 1:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1009);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} 5x Nitro eklendi.");
			        ShowMenuForPlayer(Nitro, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
	                AddVehicleComponent(car,1010);
			        SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} 10x Nitro eklendi.");
			        ShowMenuForPlayer(Nitro, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,-1,"Jant için paran yok!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:

			    {
			        ShowMenuForPlayer(TuningMenu, playerid);
				}
	 }
}


	//--------------------------Main Menu page 2 ----------------------------------------------------------------------------
	if(Current == TuningMenu1) {
	    switch(row){
	        case 0:
				if(IsPlayerConnected(playerid))
				{
					ShowMenuForPlayer(Hydraulics, playerid);
				}
	        case 1:
				if(IsPlayerConnected(playerid))
				{
					ShowMenuForPlayer(Nitro, playerid);
				}
	       case 2:
				{
	                new car = GetPlayerVehicleID(playerid);
					SetVehicleHealth(car,1000);
				 	SendClientMessage(playerid,0xFFFFFFAA,"{0049FF}«{FFFF00}®{0049FF}» {15ff00}Bilgi: {ffffff} Aracýný Tamir Ettirdin");
					ShowMenuForPlayer(TuningMenu1, playerid);
				}

	       case 3:
				if(IsPlayerConnected(playerid))
				{
					ShowMenuForPlayer(TuningMenu, playerid);
				}
		}
	}
	if (funcidx("MAG_OnPlayerSelectedMenuRow") != -1)
	{
		return CallLocalFunction("MAG_OnPlayerSelectedMenuRow", "dd",playerid,row);
	}
	return 0;

}
forward OnPlayerStateChange_Mod(playerid,newstate,oldstate);
public OnPlayerStateChange_Mod(playerid,newstate,oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER) {
	    pvehicleid[playerid] = GetPlayerVehicleID(playerid);
	    pmodelid[playerid] = GetVehicleModel(pvehicleid[playerid]);
	}
	else {
	    pvehicleid[playerid] = 0;
	    pmodelid[playerid] = 0;
	}
	return 1;
}
#if defined _ALS_OnPlayerSelectedMenuRow
	#undef OnPlayerSelectedMenuRow
#else
	#define _ALS_OnPlayerSelectedMenuRow
#endif
#define OnPlayerSelectedMenuRow MAG_OnPlayerSelectedMenuRow
forward MAG_OnPlayerSelectedMenuRow(playerid, row);
