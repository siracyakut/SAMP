/*
					   __ _                      _   _ _   _ _   _
					  / _| |                    | \ | | \ | | \ | |
					 | |_| | __ _ _ __ ___  ___ |  \| |  \| |  \| |
					 |  _| |/ _` | '__/ _ \/ _ \| . ` | . ` | . ` |
					 | | | | (_| | | |  __/ (_) | |\  | |\  | |\  |
					 |_| |_|\__,_|_|  \___|\___/|_| \_|_| \_|_| \_|
*/

/*
		GamerLity ailesine armaðanýmdýr. Güzel günlerde kullanmanýzý umuyorum.
		Tek isteðim /credits kýsmýndaki 'flareoNNN' ibaresini silmemeniz ve
		modun GL yöneticileri harici bir kiþiye geçmemesidir.
		Görüþmek üzere (:
*/

//=-=-==-=-==-=-==-=-==-=-==-=-= INCLUDELER =-=-==-=-==-=-==-=-==-=-==-=-=

#include 								 <a_samp> // - SA:MP 0.3.7 R2
#include 								 <a_json> // - a_json (SAMPSON)
#include 								<a_mysql> // - MySQL R41-4
#include 						  <weapon-config> // - weapon-config
#include 									<SKY> // - SKY
#include 								<foreach> // - foreach
#include 							   <Pawn.CMD> // - Pawn.CMD 3.2.0
#include 							 <mSelection> // - mSelection 1.1 R2
#include 								<sscanf2> // - sscanf 2.8.2
#include 						  <OnPlayerPause> // - OnPlayerPause
#include 							   <streamer> // - streamer 2.9.2
#include 							   <fuckCleo> // - fuckCleo
#include 							   	  <gmenu> // - gmenu

//=-=-==-=-==-=-==-=-==-=-==-=-= DEFINELER =-=-==-=-==-=-==-=-==-=-==-=-=

#define Hata(%0,%1) 									format(Makro_Satir, sizeof(Makro_Satir), "{FF0000}DG Hata » {FFFFFF}%s", %1) && SendClientMessage(%0, -1, Makro_Satir)
#define AdminBilgi(%0,%1) 								format(Makro_Satir, sizeof(Makro_Satir), "{B5B5B5}DG Admin » {FFFFFF}%s", %1) && SendClientMessage(%0, -1, Makro_Satir)
#define Bilgi(%0,%1) 									format(Makro_Satir, sizeof(Makro_Satir), "{CC08AF}DG Bilgi » {FFFFFF}%s", %1) && SendClientMessage(%0, -1, Makro_Satir)
#define Kullanim(%0,%1) 								format(Makro_Satir, sizeof(Makro_Satir), "{FFBF00}DG Kullaným » {FFFFFF}/%s", %1) && SendClientMessage(%0, -1, Makro_Satir)
#define YetersizSeviye(%0,%1) 							format(Makro_Satir, sizeof(Makro_Satir), "Bu komutu kullanabilmek için ' {D11F1F}%d {FFFFFF}' level olmalýsýnýz!", %1) && Hata(%0, Makro_Satir)

#define MAX_AUTOBULLET_INFRACTIONS          			(3)
#define AUTOBULLET_RESET_DELAY              			(30)

#pragma dynamic 										(1000000)

#define MYSQL_IP 										"127.0.0.1"
#define MYSQL_KADI 										"root"
#define MYSQL_SIFRE 									"15710asirac"
#define MYSQL_VERITABANI 								"leitz"

#define CB:%0(%1)										forward %0(%1); public %0(%1)

#define RADYO_URL										"http://fenomen.listenfenomen.com/fenomen/128/icecast.audio"
#define w 												"{FFFFFF}"
#define ad 												"{00F600}"
#define r 												"{FF0000}"
#define b 												"{CC08AF}"
#define wb 												"{F82D2D}"
#define SCM 											SendClientMessage

#define DIALOG_KAYIT 									(1)
#define DIALOG_GIRIS 									(2)
#define DIALOG_ARACIM									(3)
#define DIALOG_ARACIM_SAT 								(4)
#define DIALOG_ARACIM_AL 								(5)
#define DIALOG_ISYERIM									(6)
#define DIALOG_ISYERIM_ISIM								(7)
#define DIALOG_ISYERIM_SAT								(8)
#define DIALOG_KLAN										(9)
#define DIALOG_KLAN_KUR_ISIM							(10)
#define DIALOG_KLAN_KUR_TAG								(11)
#define DIALOG_KLAN_KUR_RENK							(12)
#define DIALOG_KLAN_GENEL								(13)
#define DIALOG_KLAN_YATIR 								(14)
#define DIALOG_KLAN_YATIR_EXP							(15)
#define DIALOG_KLAN_BILGILER							(16)
#define DIALOG_KLAN_UYELER								(17)
#define DIALOG_KLAN_UYEAL								(18)
#define DIALOG_KLAN_UYEAT								(19)
#define DIALOG_KLAN_DEGERLENDIR							(20)
#define DIALOG_KLAN_AYRIL								(21)
#define DIALOG_KLAN_KAPAT								(22)
#define DIALOG_LOTTO									(23)
#define DIALOG_KLANLAR									(24)
#define DIALOG_BASARIMLARIM								(25)
#define DIALOG_BANKA									(26)
#define DIALOG_BANKA_OLUSTUR							(27)
#define DIALOG_BANKA_GIRIS								(28)
#define DIALOG_BANKA_YONETIM							(29)
#define DIALOG_ARACIM_BENZIN							(30)
#define DIALOG_BANKA_TRANSFER							(31)
#define DIALOG_BANKA_PARACEK							(32)
#define DIALOG_BANKA_TRANSFER_2							(33)
#define DIALOG_BANKA_PARAYATIR							(34)
#define DIALOG_WEAPS									(35)
#define DIALOG_SPAWNSILAHLARI							(36)
#define DIALOG_SPAWNSILAHLARI_SEC						(37)
#define DIALOG_RENKLER									(38)
#define DIALOG_ARACIM_ANAHTAR							(39)
#define DIALOG_ARACIM_ANAHTAR_VER						(40)
#define DIALOG_ARACIM_ANAHTAR_AL						(41)
#define DIALOG_KLAN_DUZENLE								(42)
#define DIALOG_KLAN_DUZENLE_RUTBE						(43)
#define DIALOG_GALERI_SATINAL							(44)
#define DIALOG_KLAN_BASVURU								(45)
#define DIALOG_KLAN_BASVURU_SECIM						(46)
#define DIALOG_KLAN_BASVURU_DEGERLENDIR					(47)
#define DIALOG_SAVEPOS									(48)
#define DIALOG_LOADPOS									(49)
#define DIALOG_ISYERI_SATINAL							(50)
#define DIALOG_EVIM 									(51)
#define DIALOG_EVIM_ISIM								(52)
#define DIALOG_EVIM_SAT									(53)
#define DIALOG_EVIM_ESYA								(54)
#define DIALOG_EVIM_ESYA_YONET							(55)
#define DIALOG_EV_SATINAL								(56)
#define DIALOG_ARKADASLARIM 							(57)
#define DIALOG_ARKADASLARIM_EKLE						(58)
#define DIALOG_ARKADASLARIM_SIL							(59)
#define DIALOG_ARKADASLARIM_DEGERLENDIR					(60)
#define DIALOG_YOUTUBE_ARAMA							(61)
#define DIALOG_TESTLER									(62)
#define DIALOG_BUGRAPORLAR								(63)
#define DIALOG_BUGRAPORLAR_OKUNDU						(64)
#define DIALOG_UNBAN									(65)
#define DIALOG_UNBAN_IP_ARA								(66)
#define DIALOG_UNBAN_NBAN_ARA							(67)
#define DIALOG_UNBAN_SBAN_ARA							(68)
#define DIALOG_UNBAN_IPLISTE							(69)
#define DIALOG_UNBAN_NBANLISTE							(70)

#define MAX_ISYERI										(500)
#define MAX_EV 											(500)
#define MAX_KLAN										(500)
#define MAX_BANKA_HESAP									(100)
#define MAX_GALERI										(500)
#define MAX_ARKADAS                                     (500)
#define MAX_YOUTUBE										(500)

#define GEO_IP_INFO_DETECT_URL 							"ip-api.com/csv/"
#define GEO_IP_INFO_DETECT_URL_FIELDS					"?fields=131793"

#define GEO_MAX_IP_LENGTH 								(16)
#define GEO_MAX_COUNTRY_NAME_LENGTH 					(32)
#define GEO_MAX_CITY_NAME_LENGTH						(32)
#define GEO_MAX_LAT_LON_LENGTH 							(12)
#define GEO_MAX_PROVIDER_NAME_LENGTH					(32)
#define GEO_MAX_PROXY_LENGTH							(6)

#define GetPlayerCountry(%0)							player_geoInfo[%0][player_country]
#define GetPlayerCity(%0)								player_geoInfo[%0][player_city]
#define GetPlayerLatitude(%0)							player_geoInfo[%0][player_lat]
#define GetPlayerLongtitude(%0)							player_geoInfo[%0][player_lon]
#define GetPlayerProvider(%0)							player_geoInfo[%0][player_provider]
#define GetPlayerProxyStatus(%0)						player_geoInfo[%0][player_proxy]

//=-=-==-=-==-=-==-=-==-=-==-=-= NEWLER =-=-==-=-==-=-==-=-==-=-==-=-=

enum komutlarVars
{
	Isim[100],
	Aciklama[500],
	Level
}
new Komutlar[][komutlarVars] = 
{
	{"aka", "Kullanýcýnýn önceki isimlerini gösterir.", 1},
	{"youtube", "Sýradaki þarkýlarý gösterir.", 0},
	{"youtubeara", "Youtube þarkýsý açmak içindir.", 5},
	{"youtubegec", "Çalýnan þarkýyý geçmek içindir.", 5},
	{"unban", "Ban kaldýrmak içindir.", 5},
	{"bugraporlar", "Bugraporlara bakmak içindir.", 6},
	{"netstats", "Kullanýcýnýn internet bilgilerini gösterir.", 4},
	{"silahlar", "Silah satýn almanýz içindir.", 0},
	{"testler", "Reaksiyon testi vs. baþlatmak içindir.", 7},
	{"arkadaslarim", "Arkadaþlarýnýzý görüntülemek içindir.", 0},
	{"evim", "Ev yönetim panelini açmanýz içindir.", 0},
	{"evimegit", "Evinize gitmek içindir.", 0},
	{"evesya", "Evinize eþya almak içindir.", 0},
	{"z", "Animasyonu durdurmak içindir.", 0},
	{"god", "Ölümsüzlük açma komutudur.", 6},
	{"savepos", "Bir bölgeyi kayýt etme komutudur.", 0},
	{"loadpos", "Kaydedilen bir bölgeye gitme komutudur.", 0},
	{"sarki", "URL ile þarký açma komutudur.", 5},
	{"galeri", "Galeri üzerindeyken araç almak içindir.", 0},
	{"galeriyarat", "Galeri yaratmak içindir.", 10},
	{"galerisil", "Galeri silmek içindir.", 10},
	{"myskin", "ID ile skin deðiþtirmek içindir.", 0},
	{"unjail", "Hapisteki oyuncuyu çýkarmak içindir.", 1},
	{"jail", "Bir oyuncuyu hapise atmak içindir.", 1},
	{"renkler", "Nick rengi satýn almak içindir.", 0},
	{"spawnsilahlari", "Spawn olduðunuzda verilecek silahlarý deðiþtirmek içindir.", 0},
	{"akill", "Bir oyuncuyu öldürmek içindir.", 3},
	{"weaps", "Bir oyuncunun silahlarýný görüntülemek içindir.", 1},
	{"warn", "Bir oyuncuyu uyarmak içindir.", 2},
	{"rac", "Araçlarý resetlemek içindir.", 7},
	{"re", "Son pm'ye cevap vermek içindir.", 0},
	{"pm", "Birine özel mesaj atmak içindir.", 0},
	{"c", "Çeteniz ile konuþmak içindir.", 0},
	{"fcmd", "Bir baþka oyuncuya komut uygulatmak içindir.", 8},
	{"fchat", "Bir baþka oyuncunun adýna chat yazýsýn gönderir.", 8},
	{"hesabim", "Bankadayken hesap iþlemlerinizi yapmanýz içindir.", 0},
	{"banka", "Bankaya gitmeniz içindir.", 0},
	{"basarimlarim", "Baþarýmlarýnýzý görüntülemeniz içindir.", 0},
	{"unmute", "Susturulmuþ bir oyuncunun cezasýný kaldýrýr.", 1},
	{"mute", "Bir oyuncuyu susturur.", 1},
	{"klanlar", "Klanlarý görüntülemenizi saðlar.", 0},
	{"lottokatil", "Lotto oyununa katýlmanýzý saðlar.", 0},
	{"setexp", "Birinin exp'ini düzenler.", 8},
	{"giveexp", "Birine exp verir.", 8},
	{"klan", "Klan kurmaya ve yönetmeye yarar.", 0},
	{"mkapat", "Müziði kapatýr.", 0},
	{"evial", "Ev satýn almanýza yarar.", 0},
	{"evyarat", "Ev yaratmaya yarar.", 10},
	{"jetpack", "Jetpack almaya yarar.", 0},
	{"isyerim", "Ýþyerinizi yönetmeye yarar.", 0},
	{"nban", "Bir oyuncuya name-ban atar.", 5},
	{"ban", "Bir oyuncuya IP ban atar.", 5},
	{"kick", "Bir oyuncuya kick atar.", 3},
	{"spawn", "Bir oyuncuyu spawn eder.", 2},
	{"kill", "Ýntihar etmenize yarar.", 0},
	{"isyerial", "Ýþyeri almanýza yarar.", 0},
	{"isyerisat", "Ýþyeri satmanýza yarar.", 0},
	{"isyerisil", "Ýþyeri silmenize yarar.", 10},
	{"isyeriekle", "Ýþyeri yaratmanýza yarar.", 10},
	{"aracekle", "Satýlýk araç yaratmanýza yarar.", 10},
	{"bugrapor", "Bir bugu bildirmenize yarar.", 0},
	{"anims", "Çevrimiçi animatörleri görmenize yarar.", 0},
	{"admins", "Çevrimiçi adminleri görmenize yarar.", 0},
	{"get", "Bir oyuncuyu yanýnýza çekmeye yarar.", 2},
	{"goto", "Bir oyuncuya ýþýnlanmanýza yarar.", 0},
	{"skinler", "Resimli menüden skin almanýza yarar.", 0},
	{"givemoney", "Bir oyuncuya para vermenize yarar.", 8},
	{"setmoney", "Bir oyuncunun parasýný düzenlemenize yarar.", 8},
	{"setscore", "Bir oyuncunun skorunu düzenlemenize yarar.", 9},
	{"givescore", "Bir oyuncuya skor vermenize yarar.", 9},
	{"setadmin", "Bir oyuncuyu admin yapmanýza yarar.", 10},
	{"setanim", "Bir oyuncuyu animatör yapmanýza yarar.", 10},
	{"local", "Etrafýnýzdakilerle konuþmanýza yarar.", 0},
	{"a", "Aracýnýzý yönetmenize yarar.", 0},
	{"aracal", "Araç satýn almanýza yarar.", 0},
	{"can", "Can satýn almanýza yarar.", 0},
	{"zirh", "Zýrh satýn almanýza yarar.", 0},
	{"cc", "Sohbet ekranýný temizlemenize yarar.", 1},
	{"mod3", "Teleport alaný", 0},
	{"gotopos", "Bir pos'a ýþýnlanmanýza yarar.", 3},
	{"credits", "Sunucu yapýmcýlarýný gösterir.", 0},
	{"giveweapon", "Bir oyuncuya silah vermenize yarar.", 3},
	{"level", "Admin komutlarýna bakmanýza yarar.", 1}
};

new IPBanListe[MAX_PLAYERS][20];
new NBanListe[MAX_PLAYERS][20];

new BugRaporID[MAX_PLAYERS][20];

new Text: tebrik0[MAX_PLAYERS];
new Text: tebrik1[MAX_PLAYERS];
new Text: tebrik2[MAX_PLAYERS];
new Text: tebrik3[MAX_PLAYERS];
new Text: tebrik4[MAX_PLAYERS];
new Text: tebrik5[MAX_PLAYERS];
new Text: tebrik6[MAX_PLAYERS];

new bool: spawnda[MAX_PLAYERS];

enum YTData
{
	Isim[100],
	Link[500],
	Donusturulen[500],
	Ekleyen[24],
	Sure,
	Timer,
	bool: Caliniyor,
	bool: Sirada,
	bool: Doldu
}
new YTInfo[MAX_YOUTUBE][YTData];
enum SEData
{
	Isim[128],
	Link[256],
	Kanal[128]
}
new Arama[MAX_PLAYERS][5][SEData];
new bool: YT_Islem;
new YT_Kullanan = -1;

new Arkadaslar[MAX_PLAYERS][MAX_ARKADAS];
new Iterator: arkadaslarim<MAX_PLAYERS, MAX_ARKADAS>;

new oturak_liste = mS_INVALID_LISTID;

new Text: AnimDurdurText0[MAX_PLAYERS];

static const _AnimsEnum[][] =
{
	"AIRPORT",      "Attractors",   "BAR",          "BASEBALL",     "BD_FIRE",
	"BEACH",        "benchpress",   "BF_injection", "BIKED",        "BIKEH",
	"BIKELEAP",     "BIKES",        "BIKEV",        "BIKE_DBZ",     "BLOWJOBZ",
	"BMX",          "BOMBER",       "BOX",          "BSKTBALL",     "BUDDY",
	"BUS",          "CAMERA",       "CAR",          "CARRY",        "CAR_CHAT",
	"CASINO",       "CHAINSAW",     "CHOPPA",       "CLOTHES",      "COACH",
	"COLT45",       "COP_AMBIENT",  "COP_DVBYZ",    "CRACK",        "CRIB",
	"DAM_JUMP",     "DANCING",      "DEALER",       "DILDO",        "DODGE",
	"DOZER",        "DRIVEBYS",     "FAT",          "FIGHT_B",      "FIGHT_C",
	"FIGHT_D",      "FIGHT_E",      "FINALE",       "FINALE2",      "FLAME",
	"Flowers",      "FOOD",         "Freeweights",  "GANGS",        "GHANDS",
	"GHETTO_DB",    "goggles",      "GRAFFITI",     "GRAVEYARD",    "GRENADE",
	"GYMNASIUM",    "HAIRCUTS",     "HEIST9",       "INT_HOUSE",    "INT_OFFICE",
	"INT_SHOP",     "JST_BUISNESS", "KART",         "KISSING",      "KNIFE",
	"LAPDAN1",      "LAPDAN2",      "LAPDAN3",      "LOWRIDER",     "MD_CHASE",
	"MD_END",       "MEDIC",        "MISC",         "MTB",          "MUSCULAR",
	"NEVADA",       "ON_LOOKERS",   "OTB",          "PARACHUTE",    "PARK",
	"PAULNMAC",     "ped",          "PLAYER_DVBYS", "PLAYIDLES",    "POLICE",
	"POOL",         "POOR",         "PYTHON",       "QUAD",         "QUAD_DBZ",
	"RAPPING",      "RIFLE",        "RIOT",         "ROB_BANK",     "ROCKET",
	"RUSTLER",      "RYDER",        "SCRATCHING",   "SHAMAL",       "SHOP",
	"SHOTGUN",      "SILENCED",     "SKATE",        "SMOKING",      "SNIPER",
	"SPRAYCAN",     "STRIP",        "SUNBATHE",     "SWAT",         "SWEET",
	"SWIM",         "SWORD",        "TANK",         "TATTOOS",      "TEC",
	"TRAIN",        "TRUCK",        "UZI",          "VAN",          "VENDING",
	"VORTEX",       "WAYFARER",     "WEAPONS",      "WUZI"
};

new Float: Poslar[MAX_PLAYERS][5][3];

new KlanBasvurular[MAX_PLAYERS][100];
new KlanlarListe[MAX_PLAYERS][MAX_KLAN];

new Plakalar[][] =
{
	{01, "Adana"},
	{02, "Adýyaman"},
	{03, "Afyon"},
	{04, "Aðrý"},
	{05, "Amasya"},
	{06, "Ankara"},
	{07, "Antalya"},
	{08, "Artvin"},
	{09, "Aydýn"},
	{10, "Balýkesir"},
	{11, "Bilecik"},
	{12, "Bingöl"},
	{13, "Bitlis"},
	{14, "Bolu"},
	{15, "Burdur"},
	{16, "Bursa"},
	{17, "Çanakkale"},
	{18, "Çankýrý"},
	{19, "Çorum"},
	{20, "Denizli"},
	{21, "Diyarbakýr"},
	{22, "Edirne"},
	{23, "Elazýð"},
	{24, "Erzincan"},
	{25, "Erzurum"},
	{26, "Eskiþehir"},
	{27, "Gaziantep"},
	{28, "Giresun"},
	{29, "Gümüþhane"},
	{30, "Hakkari"},
	{31, "Hatay"},
	{32, "Isparta"},
	{33, "Ýçel"},
	{34, "Ýstanbul"},
	{35, "Ýzmir"},
	{36, "Kars"},
	{37, "Kastamonu"},
	{38, "Kayseri"},
	{39, "Kýrklareli"},
	{40, "Kýrþehir"},
	{41, "Kocaeli"},
	{42, "Konya"},
	{43, "Kütahya"},
	{44, "Malatya"},
	{45, "Manisa"},
	{46, "K.maraþ"},
	{47, "Mardin"},
	{48, "Muðla"},
	{49, "Muþ"},
	{50, "Nevþehir"},
	{51, "Niðde"},
	{52, "Ordu"},
	{53, "Rize"},
	{54, "Sakarya"},
	{55, "Samsun"},
	{56, "Siirt"},
	{57, "Sinop"},
	{58, "Sivas"},
	{59, "Tekirdað"},
	{60, "Tokat"},
	{61, "Trabzon"},
	{62, "Tunceli"},
	{63, "Þanlýurfa"},
	{64, "Uþak"},
	{65, "Van"},
	{66, "Yozgat"},
	{67, "Zonguldak"},
	{68, "Aksaray"},
	{69, "Bayburt"},
	{70, "Karaman"},
	{71, "Kýrýkkale"},
	{72, "Batman"},
	{73, "Þýrnak"},
	{74, "Bartýn"},
	{75, "Ardahan"},
	{76, "Iðdýr"},
	{77, "Yalova"},
	{78, "Karabük"},
	{79, "Kilis"},
	{80, "Osmaniye"},
	{81, "Düzce"}
};

new galeri_liste = mS_INVALID_LISTID;

enum galeriVars
{
	gID,
	Float: gX,
	Float: gY,
	Float: gZ,
	gPickup,
	Text3D: gLabel,
	gMapIcon
}
new gData[MAX_GALERI][galeriVars];
new Iterator: galeriler<MAX_GALERI>;

new KlanOyuncuDuzenleme[MAX_PLAYERS][500];
new Iterator: Anahtarlar<MAX_PLAYERS, MAX_VEHICLES>;

new SunucuRekoru, SunucuRekoru_Tarih, SunucuIP[150];

enum silahVars
{
	sIsim[100],
	sID
}
new Silahlar[][silahVars] =
{
	{"Baseball Bat", 5},
	{"Golf Club", 2},
	{"Knife", 4},
	{"Katana", 8},
	{"NightStick", 3},
	{"Pistol", 23},
	{"Silenced Pistol", 22},
	{"Desert Eagle", 24},
	{"Tec-9", 32},
	{"Micro Uzi", 28},
	{"MP5", 29},
	{"Shotgun", 25},
	{"Combat Shotgun", 27},
	{"Sawn Of Shotgun", 26},
	{"AK-4", 30},
	{"M4", 31},
	{"Rifle", 33},
	{"Sniper Rifle", 34}
};

enum e_sazone
{
    SAZONE_NAME[28],
    Float: SAZONE_AREA[6]
};
new SAZones[][e_sazone] =
{
	{"The Big Ear",	                {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
	{"Aldea Malvada",               {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
	{"Angel Pine",                  {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
	{"Arco del Oeste",              {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
	{"Avispa Country Club",         {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
	{"Avispa Country Club",         {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
	{"Avispa Country Club",         {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
	{"Avispa Country Club",         {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
	{"Avispa Country Club",         {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
	{"Avispa Country Club",         {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
	{"Back o Beyond",               {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
	{"Battery Point",               {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
	{"Bayside",                     {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
	{"Bayside Marina",              {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
	{"Beacon Hill",                 {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
	{"Blackfield",                  {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
	{"Blackfield",                  {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
	{"Blackfield Chapel",           {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
	{"Blackfield Chapel",           {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
	{"Blackfield Intersection",     {1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
	{"Blackfield Intersection",     {1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
	{"Blackfield Intersection",     {1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
	{"Blackfield Intersection",     {1375.60,823.20,-89.00,1457.30,919.40,110.90}},
	{"Blueberry",                   {104.50,-220.10,2.30,349.60,152.20,200.00}},
	{"Blueberry",                   {19.60,-404.10,3.80,349.60,-220.10,200.00}},
	{"Blueberry Acres",             {-319.60,-220.10,0.00,104.50,293.30,200.00}},
	{"Caligula's Palace",           {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
	{"Caligula's Palace",           {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
	{"Calton Heights",              {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
	{"Chinatown",                   {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
	{"City Hall",                   {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
	{"Come-A-Lot",                  {2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
	{"Commerce",                    {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
	{"Commerce",                    {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
	{"Commerce",                    {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
	{"Commerce",                    {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
	{"Commerce",                    {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
	{"Commerce",                    {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
	{"Conference Center",           {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
	{"Conference Center",           {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
	{"Cranberry Station",           {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
	{"Creek",                       {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
	{"Dillimore",                   {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
	{"Doherty",                     {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
	{"Doherty",                     {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
	{"Downtown",                    {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
	{"Downtown",                    {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
	{"Downtown",                    {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
	{"Downtown",                    {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
	{"Downtown",                    {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
	{"Downtown",                    {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
	{"Downtown Los Santos",         {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
	{"Downtown Los Santos",         {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
	{"Downtown Los Santos",         {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
	{"Downtown Los Santos",         {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
	{"Downtown Los Santos",         {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
	{"East Beach",                  {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
	{"East Beach",                  {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
	{"East Beach",                  {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
	{"East Beach",                  {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
	{"East Los Santos",             {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
	{"East Los Santos",             {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
	{"East Los Santos",             {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
	{"East Los Santos",             {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
	{"East Los Santos",             {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
	{"East Los Santos",             {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
	{"East Los Santos",             {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
	{"Easter Basin",                {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
	{"Easter Basin",                {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
	{"Easter Bay Airport",          {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
	{"Easter Bay Airport",          {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
	{"Easter Bay Airport",          {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
	{"Easter Bay Airport",          {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
	{"Easter Bay Chemicals",        {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
	{"Easter Bay Chemicals",        {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
	{"El Castillo del Diablo",      {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
	{"El Castillo del Diablo",      {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
	{"El Castillo del Diablo",      {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
	{"El Corona",                   {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
	{"El Corona",                   {1692.60,-2179.20,-89.00,1812.60,-1842.20,110.90}},
	{"El Quebrados",                {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
	{"Esplanade East",              {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
	{"Esplanade East",              {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
	{"Esplanade East",              {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
	{"Esplanade North",             {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
	{"Esplanade North",             {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
	{"Esplanade North",             {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
	{"Fallen Tree",                 {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
	{"Fallow Bridge",               {434.30,366.50,0.00,603.00,555.60,200.00}},
	{"Fern Ridge",                  {508.10,-139.20,0.00,1306.60,119.50,200.00}},
	{"Financial",                   {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
	{"Fisher's Lagoon",             {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
	{"Flint Intersection",          {-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
	{"Flint Range",                 {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
	{"Fort Carson",                 {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
	{"Foster Valley",               {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
	{"Foster Valley",               {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
	{"Frederick Bridge",            {2759.20,296.50,0.00,2774.20,594.70,200.00}},
	{"Gant Bridge",                 {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
	{"Gant Bridge",                 {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
	{"Ganton",                      {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
	{"Ganton",                      {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
	{"Garcia",                      {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
	{"Garcia",                      {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
	{"Garver Bridge",               {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
	{"Garver Bridge",               {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
	{"Garver Bridge",               {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
	{"Glen Park",                   {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
	{"Glen Park",                   {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
	{"Glen Park",                   {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
	{"Green Palms",                 {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
	{"Greenglass College",          {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
	{"Greenglass College",          {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
	{"Hampton Barns",               {603.00,264.30,0.00,761.90,366.50,200.00}},
	{"Hankypanky Point",            {2576.90,62.10,0.00,2759.20,385.50,200.00}},
	{"Harry Gold Parkway",          {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
	{"Hashbury",                    {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
	{"Hilltop Farm",                {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
	{"Hunter Quarry",               {337.20,710.80,-115.20,860.50,1031.70,203.70}},
	{"Idlewood",                    {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
	{"Idlewood",                    {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
	{"Idlewood",                    {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
	{"Idlewood",                    {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
	{"Idlewood",                    {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
	{"Idlewood",                    {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
	{"Jefferson",                   {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
	{"Jefferson",                   {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
	{"Jefferson",                   {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
	{"Jefferson",                   {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
	{"Jefferson",                   {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
	{"Jefferson",                   {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
	{"Julius Thruway East",         {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
	{"Julius Thruway East",         {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
	{"Julius Thruway East",         {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
	{"Julius Thruway East",         {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
	{"Julius Thruway North",        {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
	{"Julius Thruway North",        {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
	{"Julius Thruway North",        {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
	{"Julius Thruway North",        {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
	{"Julius Thruway North",        {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
	{"Julius Thruway North",        {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
	{"Julius Thruway North",        {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
	{"Julius Thruway North",        {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
	{"Julius Thruway South",        {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
	{"Julius Thruway South",        {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
	{"Julius Thruway West",         {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
	{"Julius Thruway West",         {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
	{"Juniper Hill",                {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
	{"Juniper Hollow",              {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
	{"K.A.C.C. Military Fuels",     {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
	{"Kincaid Bridge",              {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
	{"Kincaid Bridge",              {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
	{"Kincaid Bridge",              {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
	{"King's",                      {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
	{"King's",                      {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
	{"King's",                      {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
	{"LVA Freight Depot",           {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
	{"LVA Freight Depot",           {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
	{"LVA Freight Depot",           {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
	{"LVA Freight Depot",           {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
	{"LVA Freight Depot",           {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
	{"Las Barrancas",               {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
	{"Las Brujas",                  {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
	{"Las Colinas",                 {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
	{"Las Colinas",                 {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
	{"Las Colinas",                 {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
	{"Las Colinas",                 {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
	{"Las Colinas",                 {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
	{"Las Colinas",                 {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
	{"Las Colinas",                 {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
	{"Las Payasadas",               {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
	{"Las Venturas Airport",        {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
	{"Las Venturas Airport",        {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
	{"Last Dime Motel",             {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
	{"Leafy Hollow",                {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
	{"Liberty City",                {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
	{"Lil' Probe Inn",              {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
	{"Linden Side",                 {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
	{"Linden Station",              {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
	{"Linden Station",              {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
	{"Little Mexico",               {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
	{"Little Mexico",               {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
	{"Los Flores",                  {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
	{"Los Flores",                  {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
	{"Los Santos International",    {1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
	{"Los Santos International",    {1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
	{"Los Santos International",    {1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
	{"Los Santos International",    {1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
	{"Los Santos International",    {1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
	{"Los Santos International",    {2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
	{"Marina",                      {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
	{"Marina",                      {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
	{"Marina",                      {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
	{"Market",                      {787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
	{"Market",                      {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
	{"Market",                      {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
	{"Market",                      {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
	{"Market Station",              {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
	{"Martin Bridge",               {-222.10,293.30,0.00,-122.10,476.40,200.00}},
	{"Missionary Hill",             {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
	{"Montgomery",                  {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
	{"Montgomery",                  {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
	{"Montgomery Intersection",     {1546.60,208.10,0.00,1745.80,347.40,200.00}},
	{"Montgomery Intersection",     {1582.40,347.40,0.00,1664.60,401.70,200.00}},
	{"Mulholland",                  {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
	{"Mulholland",                  {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
	{"Mulholland",                  {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
	{"Mulholland",                  {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
	{"Mulholland",                  {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
	{"Mulholland",                  {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
	{"Mulholland",                  {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
	{"Mulholland",                  {687.80,-860.60,-89.00,911.80,-768.00,110.90}},
	{"Mulholland",                  {737.50,-768.00,-89.00,1142.20,-674.80,110.90}},
	{"Mulholland",                  {1096.40,-910.10,-89.00,1169.10,-768.00,110.90}},
	{"Mulholland",                  {952.60,-937.10,-89.00,1096.40,-860.60,110.90}},
	{"Mulholland",                  {911.80,-860.60,-89.00,1096.40,-768.00,110.90}},
	{"Mulholland",                  {861.00,-674.80,-89.00,1156.50,-600.80,110.90}},
	{"Mulholland Intersection",     {1463.90,-1150.80,-89.00,1812.60,-768.00,110.90}},
	{"North Rock",                  {2285.30,-768.00,0.00,2770.50,-269.70,200.00}},
	{"Ocean Docks",                 {2373.70,-2697.00,-89.00,2809.20,-2330.40,110.90}},
	{"Ocean Docks",                 {2201.80,-2418.30,-89.00,2324.00,-2095.00,110.90}},
	{"Ocean Docks",                 {2324.00,-2302.30,-89.00,2703.50,-2145.10,110.90}},
	{"Ocean Docks",                 {2089.00,-2394.30,-89.00,2201.80,-2235.80,110.90}},
	{"Ocean Docks",                 {2201.80,-2730.80,-89.00,2324.00,-2418.30,110.90}},
	{"Ocean Docks",                 {2703.50,-2302.30,-89.00,2959.30,-2126.90,110.90}},
	{"Ocean Docks",                 {2324.00,-2145.10,-89.00,2703.50,-2059.20,110.90}},
	{"Ocean Flats",                 {-2994.40,277.40,-9.10,-2867.80,458.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-222.50,-0.00,-2593.40,277.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-430.20,-0.00,-2831.80,-222.50,200.00}},
	{"Octane Springs",              {338.60,1228.50,0.00,664.30,1655.00,200.00}},
	{"Old Venturas Strip",          {2162.30,2012.10,-89.00,2685.10,2202.70,110.90}},
	{"Palisades",                   {-2994.40,458.40,-6.10,-2741.00,1339.60,200.00}},
	{"Palomino Creek",              {2160.20,-149.00,0.00,2576.90,228.30,200.00}},
	{"Paradiso",                    {-2741.00,793.40,-6.10,-2533.00,1268.40,200.00}},
	{"Pershing Square",             {1440.90,-1722.20,-89.00,1583.50,-1577.50,110.90}},
	{"Pilgrim",                     {2437.30,1383.20,-89.00,2624.40,1783.20,110.90}},
	{"Pilgrim",                     {2624.40,1383.20,-89.00,2685.10,1783.20,110.90}},
	{"Pilson Intersection",         {1098.30,2243.20,-89.00,1377.30,2507.20,110.90}},
	{"Pirates in Men's Pants",      {1817.30,1469.20,-89.00,2027.40,1703.20,110.90}},
	{"Playa del Seville",           {2703.50,-2126.90,-89.00,2959.30,-1852.80,110.90}},
	{"Prickle Pine",                {1534.50,2583.20,-89.00,1848.40,2863.20,110.90}},
	{"Prickle Pine",                {1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
	{"Prickle Pine",                {1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
	{"Prickle Pine",                {1938.80,2624.20,-89.00,2121.40,2861.50,110.90}},
	{"Queens",                      {-2533.00,458.40,0.00,-2329.30,578.30,200.00}},
	{"Queens",                      {-2593.40,54.70,0.00,-2411.20,458.40,200.00}},
	{"Queens",                      {-2411.20,373.50,0.00,-2253.50,458.40,200.00}},
	{"Randolph Industrial Estate",  {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
	{"Redsands East",               {1817.30,2011.80,-89.00,2106.70,2202.70,110.90}},
	{"Redsands East",               {1817.30,2202.70,-89.00,2011.90,2342.80,110.90}},
	{"Redsands East",               {1848.40,2342.80,-89.00,2011.90,2478.40,110.90}},
	{"Redsands West",               {1236.60,1883.10,-89.00,1777.30,2142.80,110.90}},
	{"Redsands West",               {1297.40,2142.80,-89.00,1777.30,2243.20,110.90}},
	{"Redsands West",               {1377.30,2243.20,-89.00,1704.50,2433.20,110.90}},
	{"Redsands West",               {1704.50,2243.20,-89.00,1777.30,2342.80,110.90}},
	{"Regular Tom",                 {-405.70,1712.80,-3.00,-276.70,1892.70,200.00}},
	{"Richman",                     {647.50,-1118.20,-89.00,787.40,-954.60,110.90}},
	{"Richman",                     {647.50,-954.60,-89.00,768.60,-860.60,110.90}},
	{"Richman",                     {225.10,-1369.60,-89.00,334.50,-1292.00,110.90}},
	{"Richman",                     {225.10,-1292.00,-89.00,466.20,-1235.00,110.90}},
	{"Richman",                     {72.60,-1404.90,-89.00,225.10,-1235.00,110.90}},
	{"Richman",                     {72.60,-1235.00,-89.00,321.30,-1008.10,110.90}},
	{"Richman",                     {321.30,-1235.00,-89.00,647.50,-1044.00,110.90}},
	{"Richman",                     {321.30,-1044.00,-89.00,647.50,-860.60,110.90}},
	{"Richman",                     {321.30,-860.60,-89.00,687.80,-768.00,110.90}},
	{"Richman",                     {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
	{"Robada Intersection",         {-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
	{"Roca Escalante",              {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
	{"Roca Escalante",              {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
	{"Rockshore East",              {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
	{"Rockshore West",              {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
	{"Rockshore West",              {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
	{"Rodeo",                       {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
	{"Rodeo",                       {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
	{"Rodeo",                       {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
	{"Rodeo",                       {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
	{"Rodeo",                       {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
	{"Rodeo",                       {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
	{"Rodeo",                       {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
	{"Rodeo",                       {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
	{"Rodeo",                       {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
	{"Rodeo",                       {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
	{"Rodeo",                       {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
	{"Rodeo",                       {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
	{"Royal Casino",                {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
	{"San Andreas Sound",           {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
	{"Santa Flora",                 {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
	{"Santa Maria Beach",           {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
	{"Santa Maria Beach",           {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
	{"Shady Cabin",                 {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
	{"Shady Creeks",                {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
	{"Shady Creeks",                {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
	{"Sobell Rail Yards",           {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
	{"Spinybed",                    {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
	{"Starfish Casino",             {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
	{"Starfish Casino",             {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
	{"Starfish Casino",             {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
	{"Temple",                      {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
	{"Temple",                      {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
	{"Temple",                      {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
	{"Temple",                      {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
	{"Temple",                      {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
	{"Temple",                      {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
	{"The Camel's Toe",             {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
	{"The Clown's Pocket",          {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
	{"The Emerald Isle",            {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
	{"The Farm",                    {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
	{"The Four Dragons Casino",     {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
	{"The High Roller",             {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
	{"The Mako Span",               {1664.60,401.70,0.00,1785.10,567.20,200.00}},
	{"The Panopticon",              {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
	{"The Pink Swan",               {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
	{"The Sherman Dam",             {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
	{"The Strip",                   {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
	{"The Strip",                   {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
	{"The Strip",                   {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
	{"The Strip",                   {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
	{"The Visage",                  {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
	{"The Visage",                  {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
	{"Unity Station",               {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
	{"Valle Ocultado",              {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
	{"Verdant Bluffs",              {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
	{"Verdant Bluffs",              {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
	{"Verdant Bluffs",              {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
	{"Verdant Meadows",             {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
	{"Verona Beach",                {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
	{"Verona Beach",                {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
	{"Verona Beach",                {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
	{"Verona Beach",                {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
	{"Verona Beach",                {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
	{"Vinewood",                    {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
	{"Vinewood",                    {787.40,-1130.80,-89.00,952.60,-954.60,110.90}},
	{"Vinewood",                    {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
	{"Vinewood",                    {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
	{"Whitewood Estates",           {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
	{"Whitewood Estates",           {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
	{"Willowfield",                 {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
	{"Willowfield",                 {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
	{"Willowfield",                 {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
	{"Willowfield",                 {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
	{"Willowfield",                 {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
	{"Willowfield",                 {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
	{"Willowfield",                 {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
	{"Yellow Bell Station",         {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
	{"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
	{"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
	{"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
	{"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
	{"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
	{"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
	{"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
	{"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
	{"Whetstone",                   {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}}
};

new SonPM[MAX_PLAYERS];

static LastInfractionTime[MAX_PLAYERS];
static PlayerShotCounter[MAX_PLAYERS];
static AutoBulletInfractions[MAX_PLAYERS];

new DusenPara[MAX_PLAYERS];
new ParalarPickup[MAX_PLAYERS][10];
new Text3D: ParalarLabel[MAX_PLAYERS][10];
new bool: PickupuMevcut[MAX_PLAYERS];
new ParaKaldirTimer[MAX_PLAYERS];

new Text: OlayText[5], MessageStr[5][1024], EVT[5] = -1;

enum basarimVars
{
	bIsim[50],
	bAciklama[128],
	bSkor,
	bPara,
	bExp
}
new Basarimlar[][basarimVars] =
{
	{"Ilk Mesaj", "Bir adet mesaj yazýn!", 2, 2, 10},
	{"Ilk Komut", "Bir adet komut yazýn!", 2, 2, 10},
	{"Bankaya git", "Bankaya bir uðrayýn!", 2, 2, 10}
};
new Basarimlarim[MAX_PLAYERS][sizeof(Basarimlar)];

new Float: BankaPoslari[][] =
{
	{2414.6880, 1124.5837, 10.8203},
	{-2624.8325, 1410.0132, 7.0938},
	{-1697.8715, 952.3763, 24.8906},
	{1631.3008, -1170.6663, 24.0781},
	{1291.9000, 269.4450, 19.5547},
	{-183.5646, 1033.9642, 19.7422},
	{2302.5945, -16.5185, 26.4844},
	{1463.1370, -1012.5519, 26.8438}
};
enum bankaVars
{
	bId,
	bSahip,
	bBakiye,
	bSifre[100],
	bOlusturma[100]
}
new bData[MAX_BANKA_HESAP][bankaVars];
new Iterator: bankahesaplari<MAX_BANKA_HESAP>;
new bool: Bankada[MAX_PLAYERS];

new Text: Para[MAX_PLAYERS][1];

enum lottoVars
{
	lSayi,
	lPara,
	lSkor,
	lTimer,
	bool: lAktif
}
new lData[lottoVars];
new LottoSayisi[MAX_PLAYERS];

new uf_VehicleSpeeds[] = // sýrasýyla araçlarýn max hýzý. rus bir kaynaktan alýndý.
{
	160, 160, 200, 120, 150, 165, 110, 170, 110, 180, 160, 240, 160, 160, 140,
	230, 155, 200, 150, 160, 180, 180, 165, 145, 170, 200, 200, 170, 170, 200,
	190, 130, 800, 180, 200, 120, 160, 160, 160, 160, 160, 750, 150, 150, 110,
	165, 190, 200, 190, 150, 120, 240, 190, 190, 190, 140, 160, 160, 165, 160,
	200, 190, 260, 190, 750, 750, 160, 160, 190, 200, 170, 160, 190, 190, 160,
	160, 200, 200, 150, 165, 200, 120, 150, 120, 190, 160, 100, 200, 200, 170,
	170, 160, 160, 190, 220, 170, 200, 200, 140, 140, 160, 750, 260, 260, 160,
	260, 230, 165, 140, 120, 140, 200, 200, 200, 120, 120, 165, 165, 160, 340,
	340, 190, 190, 190, 110, 160, 160, 160, 170, 160, 600, 700, 140, 200, 160,
	160, 160, 110, 110, 150, 160, 230, 160, 165, 260, 160, 160, 160, 200, 160,
	160, 165, 160, 200, 170, 180, 110, 110, 200, 200, 200, 200, 200, 200, 750,
	200, 160, 160, 170, 110, 110, 900, 600, 110, 600, 160, 160, 200, 110, 160,
	165, 190, 160, 170, 120, 165, 260, 200, 140, 200, 260, 120, 200, 200, 600,
	190, 200, 200, 200, 160, 165, 110, 200, 200, 260, 260, 160, 160, 160, 140,
	160, 260
};

new Text: Hiz_Benzin[MAX_PLAYERS][68];
new	HizBarRenkleri[] =
{
	0xFFFFFFFF,
	0xFFF6F6FF,
	0xFFEDEDFF,
	0xFFE4E4FF,
	0xFFDBDBFF,
	0xFFD3D3FF,
	0xFFCACAFF,
	0xFFC1C1FF,
	0xFFB8B8FF,
	0xFFAFAFFF,
	0xFFA7A7FF,
	0xFF9E9EFF,
	0xFF9595FF,
	0xFF8C8CFF,
	0xFF8383FF,
	0xFF7B7BFF,
	0xFF7272FF,
	0xFF6969FF,
	0xFF6060FF,
	0xFF5757FF,
	0xFF4F4FFF,
	0xFF4646FF,
	0xFF3D3DFF,
	0xFF3434FF,
	0xFF2B2BFF,
	0xFF2323FF,
	0xFF1A1AFF,
	0xFF1111FF,
	0xFF0808FF,
	0xFF0000FF,
	0xFF0000FF
};

new Makro_Satir[1024];

new KlanRenkleri[] = 
{
	0xFF8C13FF, 0xC715FFFF, 0x20B2AAFF, 0xDC143CFF, 0x6495EDFF, 0xf0e68cFF, 0x778899FF, 0xFF1493FF, 0xF4A460FF, 
	0xEE82EEFF, 0xFFD720FF, 0x8b4513FF, 0x4949A0FF, 0x148b8bFF, 0x14ff7fFF, 0x556b2fFF, 0x0FD9FAFF, 0x10DC29FF, 
	0x534081FF, 0x0495CDFF, 0xEF6CE8FF, 0xBD34DAFF, 0x247C1BFF, 0x0C8E5DFF, 0x635B03FF, 0xCB7ED3FF, 0x65ADEBFF, 
	0x5C1ACCFF, 0xF2F853FF, 0x11F891FF, 0x7B39AAFF, 0x53EB10FF, 0x54137DFF, 0x275222FF, 0xF09F5BFF, 0x3D0A4FFF, 
	0x22F767FF, 0xD63034FF, 0x9A6980FF, 0xDFB935FF, 0x3793FAFF, 0x90239DFF, 0xE9AB2FFF, 0xAF2FF3FF, 0x057F94FF, 
	0xB98519FF, 0x388EEAFF, 0x028151FF, 0xA55043FF, 0x0DE018FF, 0x93AB1CFF, 0x95BAF0FF, 0x369976FF, 0x18F71FFF, 
	0x4B8987FF, 0x491B9EFF, 0x829DC7FF, 0xBCE635FF, 0xCEA6DFFF, 0x20D4ADFF, 0x2D74FDFF, 0x3C1C0DFF, 0x12D6D4FF, 
	0x48C000FF, 0x2A51E2FF, 0xE3AC12FF, 0xFC42A8FF, 0x2FC827FF, 0x1A30BFFF, 0xB740C2FF, 0x42ACF5FF, 0x2FD9DEFF, 
	0xFAFB71FF, 0x05D1CDFF, 0xC471BDFF, 0x94436EFF, 0xC1F7ECFF, 0xCE79EEFF, 0xBD1EF2FF, 0x93B7E4FF, 0x3214AAFF, 
	0x184D3BFF, 0xAE4B99FF, 0x7E49D7FF, 0x4C436EFF, 0xFA24CCFF, 0xCE76BEFF, 0xA04E0AFF, 0x9F945CFF, 0xDCDE3DFF, 
	0x10C9C5FF, 0x70524DFF, 0x0BE472FF, 0x8A2CD7FF, 0x6152C2FF, 0xCF72A9FF, 0xE59338FF, 0xEEDC2DFF, 0xD8C762FF, 
	0xD8C762FF, 0xFF8C13FF, 0xC715FFFF, 0x20B2AAFF, 0xDC143CFF, 0x6495EDFF, 0xf0e68cFF, 0x778899FF, 0xFF1493FF, 
	0xF4A460FF, 0xEE82EEFF, 0xFFD720FF, 0x8b4513FF, 0x4949A0FF, 0x148b8bFF, 0x14ff7fFF, 0x556b2fFF, 0x0FD9FAFF, 
	0x10DC29FF, 0x534081FF, 0x0495CDFF, 0xEF6CE8FF, 0xBD34DAFF, 0x247C1BFF, 0x0C8E5DFF, 0x635B03FF, 0xCB7ED3FF, 
	0x65ADEBFF, 0x5C1ACCFF, 0xF2F853FF, 0x11F891FF, 0x7B39AAFF, 0x53EB10FF, 0x54137DFF, 0x275222FF, 0xF09F5BFF, 
	0x3D0A4FFF, 0x22F767FF, 0xD63034FF, 0x9A6980FF, 0xDFB935FF, 0x3793FAFF, 0x90239DFF, 0xE9AB2FFF, 0xAF2FF3FF, 
	0x057F94FF, 0xB98519FF, 0x388EEAFF, 0x028151FF, 0xA55043FF, 0x0DE018FF, 0x93AB1CFF, 0x95BAF0FF, 0x369976FF, 
	0x18F71FFF, 0x4B8987FF, 0x491B9EFF, 0x829DC7FF, 0xBCE635FF, 0xCEA6DFFF, 0x20D4ADFF, 0x2D74FDFF, 0x3C1C0DFF, 
	0x12D6D4FF, 0x48C000FF, 0x2A51E2FF, 0xE3AC12FF, 0xFC42A8FF, 0x2FC827FF, 0x1A30BFFF, 0xB740C2FF, 0x42ACF5FF, 
	0x2FD9DEFF, 0xFAFB71FF, 0x05D1CDFF, 0xC471BDFF, 0x94436EFF, 0xC1F7ECFF, 0xCE79EEFF, 0xBD1EF2FF, 0x93B7E4FF, 
	0x3214AAFF, 0x184D3BFF, 0xAE4B99FF, 0x7E49D7FF, 0x4C436EFF, 0xFA24CCFF, 0xCE76BEFF, 0xA04E0AFF, 0x9F945CFF, 
	0xDCDE3DFF, 0x10C9C5FF, 0x70524DFF, 0x0BE472FF, 0x8A2CD7FF, 0x6152C2FF, 0xCF72A9FF, 0xE59338FF, 0xEEDC2DFF, 
	0xD8C762FF, 0xD8C762FF
};

new KlanRutbeleri[][] =
{
	{"Klan Üyesi"},
	{"Yetkili Üye"},
	{"Lider Yardýmcýsý"},
	{"Lider"}
};

enum klanVars
{
	kID,
	kIsim[50],
	kTag[10],
	kKasa,
	kRenk,
	kLevel,
	kExp,
	kMaxExp,
	kKurulus_Tarihi[100]
}
new kData[MAX_KLAN][klanVars];
new Iterator: klanlar<MAX_KLAN>;

new Text: AltText0;
new Text: AltText1;
new Text: AltText2;
new Text: AltText3;
new Text: AltText4;
new Text: AltText5;
new Text: AltText6;
new Text: AltText9;
new Text: AltText10;
new Text: AltText11;
new Text: AltText14;

enum matematikVars
{
	bool: mDurum,
	mIlkHarf,
	mIkinciHarf,
	mIslem[5],
	mCevap,
	mSkor,
	mPara,
	mTimer
}
new mData[matematikVars];

enum evVars
{
	evID,
	evIsim[100],
	evFiyat,
	evSahip,
	Float: evX,
	Float: evY,
	Float: evZ,
	Float: evCikisX,
	Float: evCikisY,
	Float: evCikisZ,
	evKilit,
	Text3D: evLabel,
	evPickup,
	evInterior,
	evMapIcon,
	Text3D: evCikisLabel,
	evCikisPickup,
	evObjeler[10],
}
new EvInfo[MAX_EV][evVars];
new Float: evObjelerPos[MAX_EV][10][6];
new evObjelerID[MAX_EV][10];
new Iterator: evler<MAX_EV>;

enum isyeriVars
{
	iID,
	iSahip,
	iFiyat,
	iIsim[128],
	Float: iX,
	Float: iY,
	Float: iZ,
	Float: iCikisX,
	Float: iCikisY,
	Float: iCikisZ,
	iKilit,
	Text3D: iLabel,
	iPickup,
	iInterior,
	iKasa,
	iLevel,
	iMapIcon,
	Text3D: iCikisLabel,
	iCikisPickup,
	iBitisZaman
}
new iData[MAX_ISYERI][isyeriVars];
new Iterator: isyerleri<MAX_ISYERI>;

new VehicleNames[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel",
	"Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
	"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection",
	"Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
	"Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
	"Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
	"Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
	"Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
	"Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale",
	"Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
	"Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
	"Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper",
	"Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
	"Blista Compact", "Police Maverick", "Boxville", "Benson", "Mesa", "RC Goblin",
	"Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT",
	"Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt",
 	"Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
 	"FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
 	"Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
 	"Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent",
    "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
	"Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
	"Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratium",
	"Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper",
	"Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
	"News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
	"Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car",
 	"Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha",
 	"Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
 	"Tiller", "Utility Trailer"
};

new iArac[MAX_VEHICLES];
new AracGostergesi_Timer[MAX_PLAYERS];
new bool: BenzinDolduruyor[MAX_PLAYERS];
new BenzinTimer[MAX_PLAYERS];
new Float: Benzinlikler[23][3] =
{
	{2109.2126, 917.5845, 10.8203}, 
	{2640.1831, 1103.9224, 10.8203}, 
	{611.8934, 1694.7921, 6.7193}, 
	{-1327.5398, 2682.9771, 49.7896}, 
	{-2413.7427, 975.9317, 45.0031}, 
	{-1672.3597, 414.2950, 6.8866}, 
	{-2244.1365, -2560.6294, 31.6276}, 
	{-1603.0166, -2709.3589, 48.2419}, 
	{1939.3275, -1767.6813, 13.2787}, 
	{-94.7651, -1174.8079, 1.9979}, 
	{1381.6699, 462.6467, 19.8540}, 
	{657.8167, -559.6507, 16.0630}, 
	{-1478.2916, 1862.8318, 32.3617}, 
	{2147.3054, 2744.9377, 10.5263}, 
	{2204.9602, 2480.3494, 10.5278}, 
	{1590.9493, 2202.2637, 10.5247}, 
	{1561.5695, 1448.6895, 10.3636}, 
	{366.4071, 2535.3784, 16.8363}, 
	{1969.3317, -2303.8423, 13.2547}, 
	{-1299.7939, -26.2385, 13.8556}, 
	{-22.2549, -55.6575, 1003.5469}, 
	{-23.0664, -90.0882, 1003.5469}, 
	{-2025.2186, -113.7171, 1035.1719}
};

new Float: Spawnlar[][] =
{
	{-687.8834, 968.1933, 12.1485, 88.7548},
	{-1469.2760, 436.3646, 7.1875, 242.5793},
	{-2622.6445, 602.6168, 14.4531, 75.5710}
};
new spawnZoneler[sizeof(Spawnlar)];
new spawnZoneler2[sizeof(Spawnlar)];

new spoiler[20][0] =
{
	{1000},
	{1001},
	{1002},
	{1003},
	{1014},
	{1015},
	{1016},
	{1023},
	{1058},
	{1060},
	{1049},
	{1050},
	{1138},
	{1139},
	{1146},
	{1147},
	{1158},
	{1162},
	{1163},
	{1164}
};

new nitro[3][0] =
{
    {1008},
    {1009},
    {1010}
};

new fbumper[23][0] =
{
    {1117},
    {1152},
    {1153},
    {1155},
    {1157},
    {1160},
    {1165},
    {1167},
    {1169},
    {1170},
    {1171},
    {1172},
    {1173},
    {1174},
    {1175},
    {1179},
    {1181},
    {1182},
    {1185},
    {1188},
    {1189},
    {1192},
    {1193}
};

new rbumper[22][0] =
{
    {1140},
    {1141},
    {1148},
    {1149},
    {1150},
    {1151},
    {1154},
    {1156},
    {1159},
    {1161},
    {1166},
    {1168},
    {1176},
    {1177},
    {1178},
    {1180},
    {1183},
    {1184},
    {1186},
    {1187},
    {1190},
    {1191}
};

new exhaust[28][0] =
{
    {1018},
    {1019},
    {1020},
    {1021},
    {1022},
    {1028},
    {1029},
    {1037},
    {1043},
    {1044},
    {1045},
    {1046},
    {1059},
    {1064},
    {1065},
    {1066},
    {1089},
    {1092},
    {1104},
    {1105},
    {1113},
    {1114},
    {1126},
    {1127},
    {1129},
    {1132},
    {1135},
    {1136}
};

new bventr[2][0] =
{
    {1042},
    {1044}
};

new bventl[2][0] =
{
    {1043},
    {1045}
};

new bscoop[4][0] =
{
	{1004},
	{1005},
	{1011},
	{1012}
};

new rscoop[13][0] =
{
    {1006},
    {1032},
    {1033},
    {1035},
    {1038},
    {1053},
    {1054},
    {1055},
    {1061},
    {1067},
    {1068},
    {1088},
    {1091}
};

new lskirt[21][0] =
{
    {1007},
    {1026},
    {1031},
    {1036},
    {1039},
    {1042},
    {1047},
    {1048},
    {1056},
    {1057},
    {1069},
    {1070},
    {1090},
    {1093},
    {1106},
    {1108},
    {1118},
    {1119},
    {1133},
    {1122},
    {1134}
};

new rskirt[21][0] =
{
    {1017},
    {1027},
    {1030},
    {1040},
    {1041},
    {1051},
    {1052},
    {1062},
    {1063},
    {1071},
    {1072},
    {1094},
    {1095},
    {1099},
    {1101},
    {1102},
    {1107},
    {1120},
    {1121},
    {1124},
    {1137}
};

new hydraulics[1][0] =
{
    {1087}
};

new yex[1][0] =
{
    {1086}
};

new rbbars[2][0] =
{
    {1109},
    {1110}
};

new fbbars[2][0] =
{
    {1115},
    {1116}
};

new wheels[17][0] =
{
    {1025},
    {1073},
    {1074},
    {1075},
    {1076},
    {1077},
    {1078},
    {1079},
    {1080},
    {1081},
    {1082},
    {1083},
    {1084},
    {1085},
    {1096},
    {1097},
    {1098}
};

new lights[2][0] =
{
	{1013},
	{1024}
};

new Iterator: araclar<MAX_VEHICLES>;

new skin_listesi = mS_INVALID_LISTID;

new Oyuncu_Renkleri[] =
{
	0xFF8C13FF, 0xC715FFFF, 0x20B2AAFF, 0xDC143CFF, 0x6495EDFF, 0xf0e68cFF, 0x778899FF, 0xFF1493FF, 0xF4A460FF, 
	0xEE82EEFF, 0xFFD720FF, 0x8b4513FF, 0x4949A0FF, 0x148b8bFF, 0x14ff7fFF, 0x556b2fFF, 0x0FD9FAFF, 0x10DC29FF, 
	0x534081FF, 0x0495CDFF, 0xEF6CE8FF, 0xBD34DAFF, 0x247C1BFF, 0x0C8E5DFF, 0x635B03FF, 0xCB7ED3FF, 0x65ADEBFF, 
	0x5C1ACCFF, 0xF2F853FF, 0x11F891FF, 0x7B39AAFF, 0x53EB10FF, 0x54137DFF, 0x275222FF, 0xF09F5BFF, 0x3D0A4FFF, 
	0x22F767FF, 0xD63034FF, 0x9A6980FF, 0xDFB935FF, 0x3793FAFF, 0x90239DFF, 0xE9AB2FFF, 0xAF2FF3FF, 0x057F94FF, 
	0xB98519FF, 0x388EEAFF, 0x028151FF, 0xA55043FF, 0x0DE018FF, 0x93AB1CFF, 0x95BAF0FF, 0x369976FF, 0x18F71FFF, 
	0x4B8987FF, 0x491B9EFF, 0x829DC7FF, 0xBCE635FF, 0xCEA6DFFF, 0x20D4ADFF, 0x2D74FDFF, 0x3C1C0DFF, 0x12D6D4FF, 
	0x48C000FF, 0x2A51E2FF, 0xE3AC12FF, 0xFC42A8FF, 0x2FC827FF, 0x1A30BFFF, 0xB740C2FF, 0x42ACF5FF, 0x2FD9DEFF, 
	0xFAFB71FF, 0x05D1CDFF, 0xC471BDFF, 0x94436EFF, 0xC1F7ECFF, 0xCE79EEFF, 0xBD1EF2FF, 0x93B7E4FF, 0x3214AAFF, 
	0x184D3BFF, 0xAE4B99FF, 0x7E49D7FF, 0x4C436EFF, 0xFA24CCFF, 0xCE76BEFF, 0xA04E0AFF, 0x9F945CFF, 0xDCDE3DFF, 
	0x10C9C5FF, 0x70524DFF, 0x0BE472FF, 0x8A2CD7FF, 0x6152C2FF, 0xCF72A9FF, 0xE59338FF, 0xEEDC2DFF, 0xD8C762FF, 
	0xD8C762FF, 0xFF8C13FF, 0xC715FFFF, 0x20B2AAFF, 0xDC143CFF, 0x6495EDFF, 0xf0e68cFF, 0x778899FF, 0xFF1493FF, 
	0xF4A460FF, 0xEE82EEFF, 0xFFD720FF, 0x8b4513FF, 0x4949A0FF, 0x148b8bFF, 0x14ff7fFF, 0x556b2fFF, 0x0FD9FAFF, 
	0x10DC29FF, 0x534081FF, 0x0495CDFF, 0xEF6CE8FF, 0xBD34DAFF, 0x247C1BFF, 0x0C8E5DFF, 0x635B03FF, 0xCB7ED3FF, 
	0x65ADEBFF, 0x5C1ACCFF, 0xF2F853FF, 0x11F891FF, 0x7B39AAFF, 0x53EB10FF, 0x54137DFF, 0x275222FF, 0xF09F5BFF, 
	0x3D0A4FFF, 0x22F767FF, 0xD63034FF, 0x9A6980FF, 0xDFB935FF, 0x3793FAFF, 0x90239DFF, 0xE9AB2FFF, 0xAF2FF3FF, 
	0x057F94FF, 0xB98519FF, 0x388EEAFF, 0x028151FF, 0xA55043FF, 0x0DE018FF, 0x93AB1CFF, 0x95BAF0FF, 0x369976FF, 
	0x18F71FFF, 0x4B8987FF, 0x491B9EFF, 0x829DC7FF, 0xBCE635FF, 0xCEA6DFFF, 0x20D4ADFF, 0x2D74FDFF, 0x3C1C0DFF, 
	0x12D6D4FF, 0x48C000FF, 0x2A51E2FF, 0xE3AC12FF, 0xFC42A8FF, 0x2FC827FF, 0x1A30BFFF, 0xB740C2FF, 0x42ACF5FF, 
	0x2FD9DEFF, 0xFAFB71FF, 0x05D1CDFF, 0xC471BDFF, 0x94436EFF, 0xC1F7ECFF, 0xCE79EEFF, 0xBD1EF2FF, 0x93B7E4FF, 
	0x3214AAFF, 0x184D3BFF, 0xAE4B99FF, 0x7E49D7FF, 0x4C436EFF, 0xFA24CCFF, 0xCE76BEFF, 0xA04E0AFF, 0x9F945CFF, 
	0xDCDE3DFF, 0x10C9C5FF, 0x70524DFF, 0x0BE472FF, 0x8A2CD7FF, 0x6152C2FF, 0xCF72A9FF, 0xE59338FF, 0xEEDC2DFF, 
	0xD8C762FF, 0xD8C762FF
};

new MySQL: db;

enum playerVars
{
	pSQLID,
	pSkor,
	pPara,
	pOldurme,
	pOlum,
	pAdmin,
	pAnim,
	bool: pAFK,
	bool: pGiris,
	pRenk,
	pSkin,
	pArac,
	pIsYeri,
	Text3D: pSpawnKorumaLabel,
	bool: pSpawnKorumasinda,
	pSpawnKorumaTimer,
	pEv,
	Text3D: pLabel,
	pOnlineSuresi,
	pAFK_Timer,
	pKlan,
	pKlanRutbe,
	pExp,
	pMaxExp,
	pLevel,
	pBankaHesap,
	pMute,
	pUyarilar,
	pSilahlar[6],
	pJail,
	bool: pGod,
	bool: pEvde
}
new pData[MAX_PLAYERS][playerVars];

enum aracVars
{
	aID,
	aSahip,
	aModel,
	aBenzin,
	aMod1,
	aMod2,
	aMod3,
	aMod4,
	aMod5,
	aMod6,
	aMod7,
	aMod8,
	aMod9,
	aMod10,
	aMod11,
	aMod12,
	aMod13,
	aMod14,
	aMod15,
	aMod16,
	aMod17,
	aPaintJob,
	aRenk1,
	aRenk2,
	Float: aX,
	Float: aY,
	Float: aZ,
	Float: aF,
	bool: aKilit,
	aPlaka[50]
}
new aData[MAX_VEHICLES][aracVars];

enum reaksiyonVars
{
	bool: rDurum,
	rHarfler[50],
	rSkor,
	rPara,
	rTimer
}
new rData[reaksiyonVars];

enum e_PLAYER_GEO_INFORMATION
{
	player_ip[GEO_MAX_IP_LENGTH + 1],
	player_country[GEO_MAX_COUNTRY_NAME_LENGTH + 1],
	player_city[GEO_MAX_CITY_NAME_LENGTH + 1],
	player_lat[GEO_MAX_LAT_LON_LENGTH + 1],
	player_lon[GEO_MAX_LAT_LON_LENGTH + 1],
	player_provider[GEO_MAX_PROVIDER_NAME_LENGTH + 1],
	player_proxy[GEO_MAX_PROXY_LENGTH + 1]
};
new
	player_geoInfo[MAX_PLAYERS][e_PLAYER_GEO_INFORMATION];

//=-=-==-=-==-=-==-=-==-=-==-=-= MAIN =-=-==-=-==-=-==-=-==-=-==-=-=

main(){}

native gpci(playerid, serial[], maxlen);

stock ShowPlayerDialog_(playerid, dialogid, style, caption[], info[], button1[], button2[])
{
	new baslikk[500];
	format(baslikk, sizeof(baslikk), "{FF6161}GamerLity {FFFFFF}%s", caption);
	ShowPlayerDialog(playerid, dialogid, style, baslikk, info, button1, button2);
	return true;
}
#define ShowPlayerDialog ShowPlayerDialog_

stock GivePlayerMoney_R(playerid, para) return GivePlayerMoney(playerid, para);
stock GivePlayerMoney_M(playerid, para)
{
	new str[50];
	if(para < 0)
	{
		format(str, sizeof(str), "~r~~h~~h~%s TL", FormatMoney(para));
		TextDrawSetString(Para[playerid][0], str);
		TextDrawShowForPlayer(playerid, Para[playerid][0]);
		SetTimerEx("ParaKapat", 3500, false, "d", playerid);
	}
	else
	{
		format(str, sizeof(str), "~g~~h~~h~+%s TL", FormatMoney(para));
		TextDrawSetString(Para[playerid][0], str);
		TextDrawShowForPlayer(playerid, Para[playerid][0]);
		SetTimerEx("ParaKapat", 3500, false, "d", playerid);
	}
	pData[playerid][pPara] += para;
	GivePlayerMoney(playerid, para);
}
#define GivePlayerMoney GivePlayerMoney_M
stock ResetPlayerMoney_M(playerid)
{
	pData[playerid][pPara] = 0;
	return ResetPlayerMoney(playerid);
}
#define ResetPlayerMoney ResetPlayerMoney_M
stock SetPlayerMoney(playerid, para)
{
    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, para);
}
stock GetPlayerMoney_M(playerid)
{
	return pData[playerid][pPara];
}
#define GetPlayerMoney GetPlayerMoney_M

//=-=-==-=-==-=-==-=-==-=-==-=-= PUBLICLER =-=-==-=-==-=-==-=-==-=-==-=-=

public OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA areaid)
{
	for(new i; i < sizeof(Spawnlar); i++)
	{
		if(areaid == spawnZoneler2[i])
		{
			spawnda[playerid] = true;
			AdminBilgi(playerid, "Spawn bölgesine girdiniz, ne hasar alabilirsiniz ne de hasar verebilirsiniz!");
			break;
		}
	}
	return true;
}

public OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA areaid)
{
	for(new i; i < sizeof(Spawnlar); i++)
	{
		if(areaid == spawnZoneler2[i])
		{
			spawnda[playerid] = false;
			AdminBilgi(playerid, "Spawn bölgesinden ayrýldýnýz, artýk hasar verebilirsiniz!");
			break;
		}
	}
	return true;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(GetPVarInt(playerid, "BenzinCP") == 1) DisablePlayerCheckpoint(playerid), SetPVarInt(playerid, "BenzinCP", 0);
	return true;
}

public OnPlayerCleoDetected(playerid, cleoid)
{
	switch(cleoid)
	{
		case CLEO_PLAYERBUGGER:
		{
			SistemKick(playerid, "Player Bugger");
		}
		case CLEO_CARWARP:
		{
			SistemKick(playerid, "God of Cars");
		}
		case CLEO_CARSWING:
		{
			SistemKick(playerid, "Car Speed/Fly");
		}
		case CLEO_CAR_PARTICLE_SPAM:
		{
			SistemKick(playerid, "Car Particle Spam");
		}
	}
	return true;
}

public OnPlayerUpdate(playerid)
{
	static lastweapon;
	new currentweapon = GetPlayerWeapon(playerid);

	if(lastweapon != currentweapon)
	{
		PlayerShotCounter[playerid] = 0;
		lastweapon = currentweapon;
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		new Float: vec[3];
		GetPlayerCameraFrontVector(playerid, vec[0], vec[1], vec[2]);
		for(new i = 0; i < sizeof(vec); i++)
			if(floatabs(vec[i]) > 10.0) return false;
	}
	new keys[3];
	GetPlayerKeys(playerid, keys[0], keys[1], keys[2]);
	if(keys[0] & KEY_FIRE)
	{
	    new Float: cPos[3];
	    GetPlayerCameraPos(playerid, cPos[0], cPos[1], cPos[2]);
	    if(floatabs(cPos[0]) > 99999.0 || floatabs(cPos[1]) > 99999.0 || floatabs(cPos[2]) > 99999.0)
	    {
	        SistemKick(playerid, "Weapon Crash");
	        return false;
	    }
	}

	new vehid = GetPlayerVehicleID(playerid);
	if(vehid > 0 && vehid != INVALID_VEHICLE_ID)
	{
	    if(vehid != GetPVarInt(playerid, "LastVehID"))
	    {
	        if(GetTickCount() - GetPVarInt(playerid, "VehChangeTime") < 1000)
	        {
	            SetPVarInt(playerid, "VehChange", GetPVarInt(playerid, "VehChange") + 1);
	            if(GetPVarInt(playerid, "VehChange") > 5)
	            {
					SetPVarInt(playerid, "suphe7", GetPVarInt(playerid, "suphe7") + 1);
					if(GetPVarInt(playerid, "suphe7") >= 6) SistemKick(playerid, "Troll Hack");
					SetPVarInt(playerid, "VehChange", 1);
	                return false;
	            }
	        }
	        else SetPVarInt(playerid, "VehChange", 1);
			SetPVarInt(playerid, "LastVehID", vehid);
			return true;
	    }
	    SetPVarInt(playerid, "VehChangeTime", GetTickCount());
	} else SetPVarInt(playerid, "VehChangeTime", GetTickCount());

	if(GetPlayerCameraMode(playerid) == 53)
	{
		new Float: kLibPos[3];
		GetPlayerCameraPos(playerid, kLibPos[0], kLibPos[1], kLibPos[2]);
		if(kLibPos[2] < -50000.0 || kLibPos[2] > 50000.0)
		{
			SistemKick(playerid, "Weapon Crasher");
			return false;
		}
	}
    return true;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float: fX, Float: fY, Float: fZ)
{
	if(hitid == playerid) return false;
	if(fX != fX || fY != fY || fZ != fZ)
	{
	    SistemKick(playerid, "Crash to Weapon");
	    return false;
	}
    if(!IsPlayerInAnyVehicle(playerid))
	{
		switch(weaponid)
		{
			case 27, 23, 25, 29, 30, 31, 33, 24, 38:
			{
				if(CheckSpeed(playerid))
				{
					if(gettime() - LastInfractionTime[playerid] >= AUTOBULLET_RESET_DELAY) AutoBulletInfractions[playerid] = 1;
					else AutoBulletInfractions[playerid]++;
					LastInfractionTime[playerid] = gettime();

					if(AutoBulletInfractions[playerid] == MAX_AUTOBULLET_INFRACTIONS)
					{
                        AutoBulletInfractions[playerid] = 0;
						CallLocalFunction("OnAntiCheatAutoBullet", "ii", playerid, weaponid);
						return false;
					}
				}
			}
		}
	}
    if(hittype != BULLET_HIT_TYPE_NONE)
    {
		if((fX <= -1000.0 || fX >= 1000.0) || (fY <= -1000.0 || fY >= 1000.0) || (fZ <= -1000.0 || fZ >= 1000.0) || ((hittype != BULLET_HIT_TYPE_PLAYER) && (hittype != BULLET_HIT_TYPE_VEHICLE) && (hittype != BULLET_HIT_TYPE_OBJECT) && (hittype != BULLET_HIT_TYPE_PLAYER_OBJECT)))
		{
			SistemKick(playerid, "Bullet Crash");
			return false;
		}
    }
	else
	{
        if(weaponid <= 0 || weaponid > 46) {SistemKick(playerid, "Bullet Crash 2"); return false; }
    }

	if(GetServerTickRate() < 100)
		return true;

	if(weaponid == 38 || weaponid == 36 || weaponid == 35) return SetPlayerArmedWeapon(playerid, 0), false;
	if(weaponid < 22 || weaponid > 38) return false, SistemKick(playerid, "Crasher");
	new Float: zzz; GetPlayerPos(playerid, zzz, zzz, zzz);
	if(!(-20000.0 <= zzz <= 20000.0)) return false, SistemKick(playerid, "Crasher 2");
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
		if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER && GetPlayerWeapon(playerid) != weaponid) return false, SistemKick(playerid, "Crasher 3");
    }
    if((!(BULLET_HIT_TYPE_NONE <= hittype <= BULLET_HIT_TYPE_PLAYER_OBJECT) || weaponid != 38 && !(22 <= weaponid <= 34))) return false, SistemKick(playerid, "Crasher 4");

	if(hittype != BULLET_HIT_TYPE_NONE)
	{
        if(!(-1000.0 <= fX <= 1000.0) || !(-1000.0 <= fY <= 1000.0) || !(-1000.0 <= fZ <= 1000.0))
		{
			SistemKick(playerid, "Crasher 5");
			return false;
		}
	}

	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
	    if(!DriverCheck(GetPlayerVehicleID(playerid)))
	    {
	        GameTextForPlayer(playerid, "~r~~h~~h~Drive by yasaktir!", 3000, 3);
            SetPlayerArmedWeapon(playerid, 0);
	    }
	}
    return true;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	foreach(new i: Player)
	{
		if(pickupid == ParalarPickup[i][0])
		{
			GivePlayerMoney(playerid, DusenPara[i] / 50);
		    if(IsValidDynamicPickup(pickupid)) DestroyDynamicPickup(pickupid);
		    if(IsValidDynamic3DTextLabel(ParalarLabel[i][0])) DestroyDynamic3DTextLabel(ParalarLabel[i][0]);
		}
		if(pickupid == ParalarPickup[i][1])
		{
			GivePlayerMoney(playerid, DusenPara[i] / 50);
		    if(IsValidDynamicPickup(pickupid)) DestroyDynamicPickup(pickupid);
		    if(IsValidDynamic3DTextLabel(ParalarLabel[i][1])) DestroyDynamic3DTextLabel(ParalarLabel[i][1]);
		}
		if(pickupid == ParalarPickup[i][2])
		{
			GivePlayerMoney(playerid, DusenPara[i] / 50);
		    if(IsValidDynamicPickup(pickupid)) DestroyDynamicPickup(pickupid);
		    if(IsValidDynamic3DTextLabel(ParalarLabel[i][2])) DestroyDynamic3DTextLabel(ParalarLabel[i][2]);
		}
		if(pickupid == ParalarPickup[i][3])
		{
			GivePlayerMoney(playerid, DusenPara[i] / 50);
		    if(IsValidDynamicPickup(pickupid)) DestroyDynamicPickup(pickupid);
		    if(IsValidDynamic3DTextLabel(ParalarLabel[i][3])) DestroyDynamic3DTextLabel(ParalarLabel[i][3]);
		}
		if(pickupid == ParalarPickup[i][4])
		{
			GivePlayerMoney(playerid, DusenPara[i] / 50);
		    if(IsValidDynamicPickup(pickupid)) DestroyDynamicPickup(pickupid);
		    if(IsValidDynamic3DTextLabel(ParalarLabel[i][4])) DestroyDynamic3DTextLabel(ParalarLabel[i][4]);
		}
		if(pickupid == ParalarPickup[i][5])
		{
			GivePlayerMoney(playerid, DusenPara[i] / 50);
		    if(IsValidDynamicPickup(pickupid)) DestroyDynamicPickup(pickupid);
		    if(IsValidDynamic3DTextLabel(ParalarLabel[i][5])) DestroyDynamic3DTextLabel(ParalarLabel[i][5]);
		}
		if(pickupid == ParalarPickup[i][6])
		{
			GivePlayerMoney(playerid, DusenPara[i] / 50);
		    if(IsValidDynamicPickup(pickupid)) DestroyDynamicPickup(pickupid);
		    if(IsValidDynamic3DTextLabel(ParalarLabel[i][6])) DestroyDynamic3DTextLabel(ParalarLabel[i][6]);
		}
		if(pickupid == ParalarPickup[i][7])
		{
			GivePlayerMoney(playerid, DusenPara[i] / 50);
		    if(IsValidDynamicPickup(pickupid)) DestroyDynamicPickup(pickupid);
		    if(IsValidDynamic3DTextLabel(ParalarLabel[i][7])) DestroyDynamic3DTextLabel(ParalarLabel[i][7]);
		}
		if(pickupid == ParalarPickup[i][8])
		{
			GivePlayerMoney(playerid, DusenPara[i] / 50);
		    if(IsValidDynamicPickup(pickupid)) DestroyDynamicPickup(pickupid);
		    if(IsValidDynamic3DTextLabel(ParalarLabel[i][8])) DestroyDynamic3DTextLabel(ParalarLabel[i][8]);
		}
		if(pickupid == ParalarPickup[i][9])
		{
			GivePlayerMoney(playerid, DusenPara[i] / 50);
		    if(IsValidDynamicPickup(pickupid)) DestroyDynamicPickup(pickupid);
		    if(IsValidDynamic3DTextLabel(ParalarLabel[i][9])) DestroyDynamic3DTextLabel(ParalarLabel[i][9]);
		}
	}
	return true;
}

public OnPlayerClickMap(playerid, Float: fX, Float: fY, Float: fZ)
{
	if(pData[playerid][pAdmin] > 0 || pData[playerid][pAnim] > 0)
	{
		SetPlayerPosFindZ(playerid, fX, fY, fZ);
	}
	return true;
}

public OnGameModeInit()
{
	db = mysql_connect(MYSQL_IP, MYSQL_KADI, MYSQL_SIFRE, MYSQL_VERITABANI);
	mysql_log(ALL);

	if(mysql_errno(db) != 0)
	{
		printf("<< MySQL >> %s sunucusuna MySQL baðlantýsý baþarýsýz!", MYSQL_IP);
		SendRconCommand("exit");
		return false;
	}
	else
	{
		printf("<< MySQL >> %s sunucusuna MySQL baðlantýsý baþarýyla kuruldu.", MYSQL_IP);
	}

	SetVehiclePassengerDamage(true);
    SetDisableSyncBugs(true);

	SendRconCommand("hostname [OPENBETA] GamerLity™ - www.gamerlity.com");
	SendRconCommand("language Turkce");
	SendRconCommand("weburl www.gamerlity.com");
	SetGameModeText("GamerLity v1.0.0");
	SendRconCommand("password 313162_");

	if(!fexist("/skinler.txt")) return print("<< HATA >> \"scriptfiles/skinler.txt\" bulunamadý. Sunucu kapatýlýyor."), SendRconCommand("exit");
	if(!fexist("/galeri.txt")) return print("<< HATA >> \"scriptfiles/galeri.txt\" bulunamadý. Sunucu kapatýlýyor."), SendRconCommand("exit");
	if(!fexist("/oturaklar.txt")) return print("<< HATA >> \"scriptfiles/oturaklar.txt\" bulunamadý. Sunucu kapatýlýyor."), SendRconCommand("exit");

	skin_listesi = LoadModelSelectionMenu("skinler.txt");
	galeri_liste = LoadModelSelectionMenu("galeri.txt");
	oturak_liste = LoadModelSelectionMenu("oturaklar.txt");

	for(new i = 0; i < sizeof(Spawnlar); i++)
	{
		new string[512];
		format(string, sizeof(string), "{ffa500}GamerLity™ {f8fafb}»»» {ffa500}Spawn Bölgesi %d {999999}(%s)\n\
			{ff00a7}Sunucumuzda güzel vakit geçirmenizi temenni ederiz!\n\
			{ffff00}Web Adresimiz {f8fafb}www.gamerlity.com{ffff00}!", i + 1, GetZoneName(Spawnlar[i][0], Spawnlar[i][1], Spawnlar[i][2]));
		Create3DTextLabel(string, -1, Spawnlar[i][0], Spawnlar[i][1], Spawnlar[i][2], 35.0, 0, 0);
		spawnZoneler[i] = GangZoneCreate(Spawnlar[i][0] - 50, Spawnlar[i][1] - 50, Spawnlar[i][0] + 50, Spawnlar[i][1] + 50);
		spawnZoneler2[i]  = CreateDynamicRectangle(Spawnlar[i][0] - 50, Spawnlar[i][1] - 50, Spawnlar[i][0] + 50, Spawnlar[i][1] + 50);
	}

	for(new i = 0; i < 311; i++)
		AddPlayerClass(i, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);

	for(new i = 0; i < sizeof(Benzinlikler); i++)
	{
		new string[512];
		format(string, sizeof(string), "\
			"ad"«« BENZÝNLÝK »»\n\
			"w"Benzin doldurmak için '"wb"H"w"' tuþuna basabilirsiniz.\n\n\
			"w"(1 Litre Fiyatý: "wb"6 TL"w")");
		Create3DTextLabel(string, -1, Benzinlikler[i][0], Benzinlikler[i][1], Benzinlikler[i][2], 35.0, 0, 0);
		CreateDynamicMapIcon(Benzinlikler[i][0], Benzinlikler[i][1], Benzinlikler[i][2], 55, 0);
	}

	UsePlayerPedAnims();
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(false);
	YT_Islem = false;
	YT_Kullanan = -1;

	SetTimer("ReaksiyonTesti", 480000, true); 	// - 8 dakika
	SetTimer("MatematikTesti", 600000, true); 	// - 10 dakika
	SetTimer("Lotto", 900000, true); 			// - 15 dakika
	SetTimer("BenzinDusur", 30000, true); 		// - 30 saniye
	SetTimer("IsYeriKasa", 3600000, true); 		// - 1 saat
	SetTimer("GenelTimer", 1000, true); 		// - 1 saniye
	SetTimer("GenelTimer2", 5000, true); 		// - 5 saniye

	AraclariYukle();
	IsYerleriniYukle();
	EvleriYukle();
	KlanlariYukle();
	GalerileriYukle();
	BankaHesaplariniYukle();
	SunucuBilgileri_Yukle();

	OlayText[0] = TextDrawCreate(320.000000, 357.000000, MessageStr[0]);
	OlayText[1] = TextDrawCreate(320.000000, 371.000000, MessageStr[1]);
	OlayText[2] = TextDrawCreate(320.000000, 385.000000, MessageStr[2]);
	OlayText[3] = TextDrawCreate(320.000000, 399.000000, MessageStr[3]);
	OlayText[4] = TextDrawCreate(320.000000, 413.000000, MessageStr[4]);

	for(new ex; ex < 5; ex++)
	{
		TextDrawAlignment(OlayText[ex], 2);
		TextDrawBackgroundColor(OlayText[ex], 34);
		TextDrawFont(OlayText[ex], 1);
		TextDrawLetterSize(OlayText[ex], 0.160000, 1.000000);
		TextDrawColor(OlayText[ex], -1);
		TextDrawSetOutline(OlayText[ex], 1);
		TextDrawSetProportional(OlayText[ex], 1);
		TextDrawUseBox(OlayText[ex], 1);
		TextDrawBoxColor(OlayText[ex], 68);
		TextDrawTextSize(OlayText[ex], 12.000000, 354.000000);
		TextDrawSetSelectable(OlayText[ex], 0);
	}

	AltText0 = TextDrawCreate(663.000000, 438.922210, "usebox");
	TextDrawLetterSize(AltText0, 0.000000, 1.370371);
	TextDrawTextSize(AltText0, -29.000000, 0.000000);
	TextDrawAlignment(AltText0, 1);
	TextDrawColor(AltText0, 51);
	TextDrawUseBox(AltText0, true);
	TextDrawBoxColor(AltText0, 102);
	TextDrawSetShadow(AltText0, 0);
	TextDrawSetOutline(AltText0, 0);
	TextDrawFont(AltText0, 0);

	AltText1 = TextDrawCreate(287.500000, 424.355590, "GamerLity");
	TextDrawLetterSize(AltText1, 0.464000, 1.587555);
	TextDrawAlignment(AltText1, 1);
	TextDrawColor(AltText1, -1);
	TextDrawUseBox(AltText1, true);
	TextDrawBoxColor(AltText1, 0);
	TextDrawSetShadow(AltText1, 0);
	TextDrawSetOutline(AltText1, 1);
	TextDrawBackgroundColor(AltText1, 51);
	TextDrawFont(AltText1, 0);
	TextDrawSetProportional(AltText1, 1);

	AltText2 = TextDrawCreate(336.000000, 439.666687, "]]]]]]");
	TextDrawLetterSize(AltText2, 0.116999, 0.467555);
	TextDrawAlignment(AltText2, 1);
	TextDrawColor(AltText2, -1);
	TextDrawSetShadow(AltText2, 0);
	TextDrawSetOutline(AltText2, 1);
	TextDrawBackgroundColor(AltText2, 51);
	TextDrawFont(AltText2, 2);
	TextDrawSetProportional(AltText2, 1);

	AltText3 = TextDrawCreate(261.000000, 440.044464, "]]]]]]");
	TextDrawLetterSize(AltText3, 0.116999, 0.467555);
	TextDrawAlignment(AltText3, 1);
	TextDrawColor(AltText3, -1);
	TextDrawSetShadow(AltText3, 0);
	TextDrawSetOutline(AltText3, 1);
	TextDrawBackgroundColor(AltText3, 51);
	TextDrawFont(AltText3, 2);
	TextDrawSetProportional(AltText3, 1);

	AltText4 = TextDrawCreate(298.500000, 439.289001, "gamerlity.com");
	TextDrawLetterSize(AltText4, 0.130999, 0.753777);
	TextDrawAlignment(AltText4, 1);
	TextDrawColor(AltText4, -1);
	TextDrawSetShadow(AltText4, 0);
	TextDrawSetOutline(AltText4, 1);
	TextDrawBackgroundColor(AltText4, 51);
	TextDrawFont(AltText4, 1);
	TextDrawSetProportional(AltText4, 1);

	AltText5 = TextDrawCreate(605.500000, 439.911132, "]]]]]]]]");
	TextDrawLetterSize(AltText5, 0.116999, 0.467555);
	TextDrawAlignment(AltText5, 1);
	TextDrawColor(AltText5, -1);
	TextDrawSetShadow(AltText5, 0);
	TextDrawSetOutline(AltText5, 1);
	TextDrawBackgroundColor(AltText5, 51);
	TextDrawFont(AltText5, 2);
	TextDrawSetProportional(AltText5, 1);

	AltText6 = TextDrawCreate(2.000000, 439.666687, "]]]]]]]]");
	TextDrawLetterSize(AltText6, 0.116999, 0.467555);
	TextDrawAlignment(AltText6, 1);
	TextDrawColor(AltText6, -1);
	TextDrawSetShadow(AltText6, 0);
	TextDrawSetOutline(AltText6, 1);
	TextDrawBackgroundColor(AltText6, 51);
	TextDrawFont(AltText6, 2);
	TextDrawSetProportional(AltText6, 1);

	AltText9 = TextDrawCreate(257.000000, 439.544433, "usebox");
	TextDrawLetterSize(AltText9, 0.000000, 0.720371);
	TextDrawTextSize(AltText9, 116.500000, 0.000000);
	TextDrawAlignment(AltText9, 1);
	TextDrawColor(AltText9, 0);
	TextDrawUseBox(AltText9, true);
	TextDrawBoxColor(AltText9, 102);
	TextDrawSetShadow(AltText9, 0);
	TextDrawSetOutline(AltText9, 0);
	TextDrawFont(AltText9, 0);

	AltText10 = TextDrawCreate(125.500000, 438.666870, "/ADMINS - /ANIMS - /VIPS - /CREDITS - /SSS");
	TextDrawLetterSize(AltText10, 0.154000, 0.828444);
	TextDrawAlignment(AltText10, 1);
	TextDrawColor(AltText10, -1);
	TextDrawSetShadow(AltText10, 0);
	TextDrawSetOutline(AltText10, 1);
	TextDrawBackgroundColor(AltText10, 51);
	TextDrawFont(AltText10, 1);
	TextDrawSetProportional(AltText10, 1);

	AltText11 = TextDrawCreate(505.500000, 439.299987, "usebox");
	TextDrawLetterSize(AltText11, 0.000000, 0.720371);
	TextDrawTextSize(AltText11, 364.000000, 0.000000);
	TextDrawAlignment(AltText11, 1);
	TextDrawColor(AltText11, 0);
	TextDrawUseBox(AltText11, true);
	TextDrawBoxColor(AltText11, 102);
	TextDrawSetShadow(AltText11, 0);
	TextDrawSetOutline(AltText11, 0);
	TextDrawFont(AltText11, 0);

	AltText14 = TextDrawCreate(378.500000, 438.422515, "/STATS - /INFO - /SHOP - /TELES - /BANKA");
	TextDrawLetterSize(AltText14, 0.154000, 0.828444);
	TextDrawAlignment(AltText14, 1);
	TextDrawColor(AltText14, -1);
	TextDrawSetShadow(AltText14, 0);
	TextDrawSetOutline(AltText14, 1);
	TextDrawBackgroundColor(AltText14, 51);
	TextDrawFont(AltText14, 1);
	TextDrawSetProportional(AltText14, 1);

	print("\n====================================");
	print("\nGamerLity FR Yüklendi.\n");
	print("====================================\n");
	return true;
}

public OnGameModeExit()
{
	foreach(new i: Player)
	{
		OyuncuKaydet(i);
		if(PickupuMevcut[i] == true)
		{
			for(new n = 0; n < 10; n++)
			{
				if(IsValidDynamicPickup(ParalarPickup[i][n])) DestroyDynamicPickup(ParalarPickup[i][n]);
				if(IsValidDynamic3DTextLabel(ParalarLabel[i][n])) DestroyDynamic3DTextLabel(ParalarLabel[i][n]);
			}
			KillTimer(ParaKaldirTimer[i]);
		}
	}
	SendRconCommand("unloadfs zmaplari");
	mysql_close(db);
	return true;
}

public OnPlayerConnect(playerid)
{
	StopAudioStreamForPlayer(playerid);
	GetPlayerIp(playerid, player_geoInfo[playerid][player_ip], GEO_MAX_IP_LENGTH);
	new 
		request[31 - 2 + GEO_MAX_IP_LENGTH];
	format(request, sizeof(request), "%s%s%s", GEO_IP_INFO_DETECT_URL, player_geoInfo[playerid][player_ip], GEO_IP_INFO_DETECT_URL_FIELDS);
	HTTP(playerid, HTTP_GET, request, "", "p_geo_OnInformationRequested");

	spawnda[playerid] = false;
	pData[playerid][pLabel] = Create3DTextLabel("_", -1, -2080.4919, 242.6367, 105.8890, 25.0, 0, 0);
	SetPVarInt(playerid, "GirisHaklari", 0);
	SetPVarInt(playerid, "DegisHadi", 0);
	Bankada[playerid] = false;
	PickupuMevcut[playerid] = false;
	SonPM[playerid] = -1;
	SetPVarInt(playerid, "BenzinCP", 0);
	SetPVarInt(playerid, "ev_duzenlenen_ilk", 0);
	SetPVarInt(playerid, "sonradanduzenle", 0);
	for(new i = 0; i < 6; i++)
	{
		pData[playerid][pSilahlar][i] = -1;
	}

	LottoSayisi[playerid] = -1;
	SetPVarInt(playerid, "guncelle", 1);
	KillTimer(AracGostergesi_Timer[playerid]);

	if(IsValidDynamic3DTextLabel(pData[playerid][pSpawnKorumaLabel]))
		DestroyDynamic3DTextLabel(pData[playerid][pSpawnKorumaLabel]);

	BenzinDolduruyor[playerid] = false;
	KillTimer(BenzinTimer[playerid]);
	KillTimer(pData[playerid][pAFK_Timer]);

	pData[playerid][pGiris] = false;

	CC(playerid);
	SCM(playerid, -1, ""wb"» "w"GamerLity™ Turkish Freeroam Server - Website: "wb"www.gamerlity.com");
	SCM(playerid, -1, ""wb"» "w"Since 2018 - Version: "wb"v3.0.0: Reborn");
	SCM(playerid, -1, ""wb"» "w"Modumuz "wb"BETA "w"sürecindedir. Bulduðunuz buglarý "wb"/bugrapor "w"ile belirtebilirsiniz.");
	SCM(playerid, -1, " ");

	SetPlayerColor(playerid, Oyuncu_Renkleri[random(sizeof(Oyuncu_Renkleri))]);
	SendDeathMessage(INVALID_PLAYER_ID, playerid, 200);
	TextYukle(playerid);
	RekorCheck(playerid);
	return true;
}

public OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart)
{
	if(issuerid != INVALID_PLAYER_ID)
	{
		if(pData[playerid][pAFK] == true || Bankada[playerid] == true || pData[playerid][pSpawnKorumasinda] == true || pData[playerid][pGod] == true || pData[playerid][pJail] > 0 || spawnda[playerid] == true) return false;
		if(pData[issuerid][pSpawnKorumasinda] == true)
		{
			KillTimer(pData[issuerid][pSpawnKorumaTimer]);
			if(IsValidDynamic3DTextLabel(pData[issuerid][pSpawnKorumaLabel]))
			{
				DestroyDynamic3DTextLabel(pData[issuerid][pSpawnKorumaLabel]);
			}
			for(new i = 0; i < 6; i++)
			{
				if(pData[issuerid][pSilahlar][i] != -1) GivePlayerWeapon(issuerid, pData[issuerid][pSilahlar][i], 3131);
			}
			pData[issuerid][pSpawnKorumasinda] = false;
			AdminBilgi(issuerid, "Spawn korumasýndayken birine vurduðunuz için spawn korumasý sona erdi!");
		}
		if(weapon == 34 && bodypart == 9 && pData[issuerid][pSpawnKorumasinda] == false)
		{
			GameTextForPlayer(playerid, "~r~headshot", 2000, 3);
			GameTextForPlayer(issuerid, "~r~headshot", 2000, 3);
			
			amount = 0.0;
		}
	}
	else if(issuerid == INVALID_PLAYER_ID)
	{
		if(pData[playerid][pAFK] == true || spawnda[playerid] == true || Bankada[playerid] == true || pData[playerid][pSpawnKorumasinda] == true || pData[playerid][pGod] == true || pData[playerid][pJail] > 0) return false;
	}
	return true;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(YT_Kullanan == playerid) YT_Kullanan = -1;

	AutoBulletInfractions[playerid] = 0;
	OyuncuKaydet(playerid);
	SendDeathMessage(INVALID_PLAYER_ID, playerid, 201);
	Delete3DTextLabel(pData[playerid][pLabel]);

	if(pData[playerid][pKlan] != -1 && GetPVarInt(playerid, "DegisHadi") == 0 && pData[playerid][pGiris] == true)
	{
		new bul, tag[25], isim[24];
		GetPlayerName(playerid, isim, 24);
		format(tag, sizeof(tag), "%s", kData[pData[playerid][pKlan]][kTag]);
		bul = strfind(isim, tag);
		strdel(isim, bul - 1, bul + strlen(tag) + 1);
		SetPlayerName(playerid, isim);
		SetPVarInt(playerid, "DegisHadi", 1);
	}

	TextDrawHideForPlayer(playerid, AltText0);
	TextDrawHideForPlayer(playerid, AltText1);
	TextDrawHideForPlayer(playerid, AltText2);
	TextDrawHideForPlayer(playerid, AltText3);
	TextDrawHideForPlayer(playerid, AltText4);
	TextDrawHideForPlayer(playerid, AltText5);
	TextDrawHideForPlayer(playerid, AltText6);
	TextDrawHideForPlayer(playerid, AltText9);
	TextDrawHideForPlayer(playerid, AltText10);
	TextDrawHideForPlayer(playerid, AltText11);
	TextDrawHideForPlayer(playerid, AltText14);
	return true;
}

public OnPlayerPause(playerid)
{
	pData[playerid][pAFK] = true;
	KillTimer(pData[playerid][pAFK_Timer]);
	pData[playerid][pAFK_Timer] = SetTimerEx("AFK_Kick", 600000, false, "i", playerid);
	return true;
}

public OnPlayerUnpause(playerid)
{
	KillTimer(pData[playerid][pAFK_Timer]);
	pData[playerid][pAFK] = false;
	return true;
}

public OnPlayerText(playerid, text[])
{
	if(pData[playerid][pGiris] != true) return Hata(playerid, "Giriþ yapmadan yazý yazamazsýnýz!");
	if(GetPlayerState(playerid) == PLAYER_STATE_WASTED || GetPlayerState(playerid) == PLAYER_STATE_NONE)
	{
	    Hata(playerid, "Spawn olmadan yazý yazamazsýnýz!");
	    return false;
	}

	if(pData[playerid][pJail] > 0)
	{
		new str[512];
		format(str, sizeof(str), "Hapisteyken konuþamazsýnýz. Kalan: "wb"%s", ConvertTime(pData[playerid][pJail]));
		Hata(playerid, str);
		return false;
	}

	if(pData[playerid][pMute] > 0)
	{
		new str[512];
		format(str, sizeof(str), "Susturulmuþken konuþamazsýnýz. Kalan: "wb"%s", ConvertTime(pData[playerid][pMute]));
		Hata(playerid, str);
		return false;
	}

	BasarimVer(playerid, 0);

	new str[5000], edit_text[5000], arastr[24];
	format(edit_text, sizeof(edit_text), "%s", text);
	if(strfind(edit_text, "@") != -1)
	{
		new sayi = strcount(edit_text, '@'), xd = 0;
		basla:
		for(new i = GetPlayerPoolSize(); i != -1; i--)
		{
			format(arastr, sizeof(arastr), "@%d", i);
			if(strfind(edit_text, arastr) != -1 && IsPlayerConnected(i))
			{
				strreplace(edit_text, arastr, getName(i));
				break;
			}
		}
		if(xd < sayi)
		{
			xd++;
			goto basla;
		}
	}

	if(!strcmp(text, rData[rHarfler]) && rData[rDurum] == true)
	{
		new string[512];
		format(string, sizeof(string), "{A2FF00}DG FastFingers » {%06x}%s "w"harfleri doðru yazdý ve ödülleri kaptý!", GetPlayerColor(playerid) >>> 8, getName(playerid));
		SendClientMessageToAll(-1, string);

		SetPlayerScore(playerid, GetPlayerScore(playerid) + rData[rSkor]);
		GivePlayerMoney(playerid, rData[rPara]);

		KillTimer(rData[rTimer]);
		rData[rDurum] = false;
		rData[rPara] = -1;
		rData[rSkor] = -1;
		format(rData[rHarfler], 50, " ");
	}

	if(IsNumeric(text) && strval(text) == mData[mCevap] && mData[mDurum] == true)
	{
		new string[512];
		format(string, sizeof(string), "{E5FF00}DG Matematik » {%06x}%s "w"soruyu çözdü ve ödülleri kaptý!", GetPlayerColor(playerid) >>> 8, getName(playerid));
		SendClientMessageToAll(-1, string);

		SetPlayerScore(playerid, GetPlayerScore(playerid) + mData[mSkor]);
		GivePlayerMoney(playerid, mData[mPara]);

		KillTimer(mData[mTimer]);
		mData[mDurum] = false;
		mData[mPara] = 0;
		mData[mSkor] = 0;
		mData[mCevap] = 0;
		mData[mIlkHarf] = 0;
		mData[mIkinciHarf] = 0;
		format(mData[mIslem], 5, "");
	}

	if(edit_text[0] == '#' && pData[playerid][pAdmin] > 0)
	{
	    format(str, sizeof(str), ""ad"Admin Sohbet >> {00B000}%s(%d): "w"%s", getName(playerid), playerid, edit_text[1]);
	    foreach(new i: Player) if(pData[i][pAdmin] > 0) SCM(i, -1, str);
		return false;
	}

	if(edit_text[0] == '$' && (pData[playerid][pAdmin] > 0 || pData[playerid][pAnim] > 0))
	{
	    format(str, sizeof(str), "{D0F000}Anim Sohbet >> {AAC400}%s(%d): "w"%s", getName(playerid), playerid, edit_text[1]);
	    foreach(new i: Player) if(pData[i][pAdmin] > 0 || pData[i][pAnim] > 0) SCM(i, -1, str);
		return false;
	}

	if(edit_text[0] == '!')
	{
		new editstr_x[2048];
		format(editstr_x, sizeof(editstr_x), "/c %s", edit_text[1]);
		PC_EmulateCommand(playerid, editstr_x);
		return false;
	}

	if(pData[playerid][pAdmin] == 0 && pData[playerid][pAnim] == 0)
	{
		if(edit_text[0] == '@' && edit_text[1] == '@')
		{
			new komutstr[2048];
			format(komutstr, sizeof(komutstr), "/re %s", edit_text[2]);
			PC_EmulateCommand(playerid, komutstr);
			return false;
		}

		format(str, sizeof(str), "{%06x}%s({FFFFFF}%d{%06x}): {FFFFFF}%s", GetPlayerColor(playerid) >>> 8, getName(playerid), playerid, GetPlayerColor(playerid) >>> 8, edit_text);
		SendClientMessageToAllEx(-1, str);
		return false;
	}
	else if(pData[playerid][pAdmin] > 0)
	{
		if(edit_text[0] == '@' && edit_text[1] == '@')
		{
			new komutstr[2048];
			format(komutstr, sizeof(komutstr), "/re %s", edit_text[2]);
			PC_EmulateCommand(playerid, komutstr);
			return false;
		}

		format(str, sizeof(str), "{%06x}» {FFFFFF}GM %d {%06x}« %s({FFFFFF}%d{%06x}): {FFFFFF}%s", GetPlayerColor(playerid) >>> 8, pData[playerid][pAdmin], GetPlayerColor(playerid) >>> 8, getName(playerid), playerid, GetPlayerColor(playerid) >>> 8, edit_text);
		SendClientMessageToAllEx(-1, str);
		return false;
	}
	else if(pData[playerid][pAnim] > 0)
	{
		if(edit_text[0] == '@' && edit_text[1] == '@')
		{
			new komutstr[2048];
			format(komutstr, sizeof(komutstr), "/re %s", edit_text[2]);
			PC_EmulateCommand(playerid, komutstr);
			return false;
		}

		format(str, sizeof(str), "{%06x}» {FFFFFF}ANM %d {%06x}« %s({FFFFFF}%d{%06x}): {FFFFFF}%s", GetPlayerColor(playerid) >>> 8, pData[playerid][pAnim], GetPlayerColor(playerid) >>> 8, getName(playerid), playerid, GetPlayerColor(playerid) >>> 8, edit_text);
		SendClientMessageToAllEx(-1, str);
		return false;
	}
	return true;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	SaveComponent(playerid, pData[playerid][pArac], componentid);
	foreach(new i: araclar)
	{
		if(aData[i][aID] == vehicleid && aData[i][aSahip] == pData[playerid][pSQLID])
		{
			AracKayit(i);
		}
	}
	return true;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	SavePaintjob(playerid, pData[playerid][pArac], paintjobid);
	foreach(new i: araclar)
	{
		if(aData[i][aID] == vehicleid && aData[i][aSahip] == pData[playerid][pSQLID])
		{
			AracKayit(i);
		}
	}
	return true;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	SaveColors(playerid, pData[playerid][pArac], color1, color2);
	foreach(new i: araclar)
	{
		if(aData[i][aID] == vehicleid && aData[i][aSahip] == pData[playerid][pSQLID])
		{
			AracKayit(i);
		}
	}
	return true;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_DRIVER)
	{
		for(new q = 0; q < 68; q++)
		{
			TextDrawHideForPlayer(playerid, Hiz_Benzin[playerid][q]);
		}
		KillTimer(AracGostergesi_Timer[playerid]);
		SetPVarInt(playerid, "guncelle", 1);
	}

	if(newstate == PLAYER_STATE_DRIVER)
	{
		foreach(new i: araclar)
		{
			if(GetPlayerVehicleID(playerid) == aData[i][aID] && aData[i][aKilit] == true && aData[i][aSahip] != -1)
			{
				if(pData[playerid][pSQLID] == aData[i][aSahip])
				{
					Bilgi(playerid, "Araç sizin, hoþgeldiniz.");
					for(new q = 0; q < 68; q++)
					{
						TextDrawShowForPlayer(playerid, Hiz_Benzin[playerid][q]);
					}
					KillTimer(AracGostergesi_Timer[playerid]);
					AracGostergesi_Timer[playerid] = SetTimerEx("AracGostergesi_Guncelle", 600, true, "di", playerid, i);
				}
				else if(Iter_Contains(Anahtarlar<playerid>, i))
				{
					Bilgi(playerid, "Araç sizin deðil, anahtarlarý olduðu için bindiniz.");
					for(new q = 0; q < 68; q++)
					{
						TextDrawShowForPlayer(playerid, Hiz_Benzin[playerid][q]);
					}
					KillTimer(AracGostergesi_Timer[playerid]);
					AracGostergesi_Timer[playerid] = SetTimerEx("AracGostergesi_Guncelle", 600, true, "di", playerid, i);
				}
				else
				{
					new str[512];
					format(str, sizeof(str), "Bu araç kilitli! Sahibi: "wb"%s", SQL_Isim_Cek(aData[i][aSahip]));
					Hata(playerid, str);
					RemovePlayerFromVehicle(playerid);
				}
				break;
			}
			else if(GetPlayerVehicleID(playerid) == aData[i][aID] && aData[i][aKilit] == false && aData[i][aSahip] != -1)
			{
				if(pData[playerid][pSQLID] == aData[i][aSahip])
				{
					Bilgi(playerid, "Araç sizin, hoþgeldiniz.");
					AdminBilgi(playerid, "(Araç kilitleriniz devre dýþý, aracýnýza binebilirler.)");
					for(new q = 0; q < 68; q++)
					{
						TextDrawShowForPlayer(playerid, Hiz_Benzin[playerid][q]);
					}
					KillTimer(AracGostergesi_Timer[playerid]);
					AracGostergesi_Timer[playerid] = SetTimerEx("AracGostergesi_Guncelle", 600, true, "di", playerid, i);
				}
				else
				{
					new str[512];
					format(str, sizeof(str), "Araç kilitleri açýk, misafir olarak bindiniz. Araç Sahibi: "wb"%s", SQL_Isim_Cek(aData[i][aSahip]));
					Bilgi(playerid, str);
					for(new q = 0; q < 68; q++)
					{
						TextDrawShowForPlayer(playerid, Hiz_Benzin[playerid][q]);
					}
					KillTimer(AracGostergesi_Timer[playerid]);
					AracGostergesi_Timer[playerid] = SetTimerEx("AracGostergesi_Guncelle", 600, true, "di", playerid, i);
				}
				break;
			}
			else if(GetPlayerVehicleID(playerid) == aData[i][aID] && aData[i][aSahip] == -1)
			{
				for(new q = 0; q < 68; q++)
				{
					TextDrawShowForPlayer(playerid, Hiz_Benzin[playerid][q]);
				}
				KillTimer(AracGostergesi_Timer[playerid]);
				AracGostergesi_Timer[playerid] = SetTimerEx("AracGostergesi_Guncelle", 600, true, "di", playerid, i);

				Bilgi(playerid, "Aracýn sahibi yok, almak için "wb"/aracal "w"yazabilirsiniz.");
			}
		}
	}
	return true;
}

public OnPlayerRequestClass(playerid, classid)
{
	switch(classid)
	{
		case 0:
		{
			SetPlayerPos(playerid, 1464.6743, -910.0695, 61.1882);
			SetPlayerFacingAngle(playerid, 187.2068);
			InterpolateCameraPos(playerid, 1468.986816, -928.999450, 59.714141, 1466.137817, -916.476501, 60.689052, 4000);
			InterpolateCameraLookAt(playerid, 1467.878295, -924.138610, 60.092689, 1465.029296, -911.615661, 61.067600, 4000);
			Kayit_Giris(playerid);
		}
	}
	return true;
}

public OnPlayerRequestSpawn(playerid)
{
	if(pData[playerid][pGiris] == false)
	{
		Hata(playerid, "Giriþ yapmadan spawn olamazsýnýz!");
		Kayit_Giris(playerid);
		return false;
	}

	TextDrawShowForPlayer(playerid, AltText0);
	TextDrawShowForPlayer(playerid, AltText1);
	TextDrawShowForPlayer(playerid, AltText2);
	TextDrawShowForPlayer(playerid, AltText3);
	TextDrawShowForPlayer(playerid, AltText4);
	TextDrawShowForPlayer(playerid, AltText5);
	TextDrawShowForPlayer(playerid, AltText6);
	TextDrawShowForPlayer(playerid, AltText9);
	TextDrawShowForPlayer(playerid, AltText10);
	TextDrawShowForPlayer(playerid, AltText11);
	TextDrawShowForPlayer(playerid, AltText14);

	for(new i = 0; i < 5; i++)
	{
		TextDrawShowForPlayer(playerid, OlayText[i]);
	}

	PlayAudioStreamForPlayer(playerid, RADYO_URL);

	Attach3DTextLabelToPlayer(pData[playerid][pLabel], playerid, 0.0, 0.0, 1.2);
	return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_UNBAN_NBANLISTE)
	{
		if(!response) return PC_EmulateCommand(playerid, "/unban");
		if(response)
		{
			if(listitem != 12)
			{
				if(NBanListe[playerid][listitem] == -1) return OnDialogResponse(playerid, DIALOG_UNBAN, 1, 3, "");
				new id = NBanListe[playerid][listitem], sql[256], nick[24];
				format(sql, sizeof(sql), "SELECT * FROM `nbanlog` WHERE `id` = '%d'", id);
				mysql_query(db, sql);
				cache_get_value_name(0, "banlanan", nick);
				new str[512];
				format(str, sizeof(str), "Baþarýyla "wb"%s "w"adlý oyuncunun N-ban'ý açýldý.", nick);
				AdminBilgi(playerid, str);
				format(sql, sizeof(sql), "DELETE FROM `nbanlog` WHERE `id` = '%d'", id);
				mysql_query(db, sql);
			}
			else
			{
				mysql_query(db, "SELECT * FROM `nbanlog`");
				if(cache_num_rows() <= 0) return Hata(playerid, "Hiç N-banlý oyuncu yok!");

				new sql[256], sayi, str[10000], nick[24], gun, durum[50];

				format(sql, sizeof(sql), "SELECT * FROM `nbanlog` LIMIT %d, 12", GetPVarInt(playerid, "NBANSAYFA"));
				mysql_query(db, sql);
				cache_get_row_count(sayi);

				SetPVarInt(playerid, "NBANSAYFA", GetPVarInt(playerid, "NBANSAYFA") + 12);
				for(new i; i < 20; i++) NBanListe[playerid][i] = -1;

				strcat(str, ""w"#\t"w"Nick\t"w"Kalan Süre\n");

				for(new i; i < 12; i++)
				{
					if(i < sayi)
					{
						cache_get_value_name_int(i, "id", NBanListe[playerid][i]);
						cache_get_value_name(i, "banlanan", nick);
						cache_get_value_name_int(i, "gun", gun);
						if(gettime() > gun)
						{
							durum = ""ad"SONA ERMÝÞ";
						}
						else
						{
							format(durum, sizeof(durum), "{A9A9A9}%s", ConvertTime(gun - gettime()));
						}
						format(str, sizeof(str), "%s"wb"»\t"w"%s\t%s\n", str, nick, durum);
					}
					else
					{
						format(str, sizeof(str), "%s{A9A9A9}---\t{A9A9A9}---------------------------\t{A9A9A9}-----------------\n", str);
					}
				}

				mysql_query(db, "SELECT * FROM `nbanlog`");
				if(cache_num_rows() > GetPVarInt(playerid, "NBANSAYFA"))
				{
					strcat(str, "{A9A9A9}>> Sonraki Sayfa");
				}

				ShowPlayerDialog(playerid, DIALOG_UNBAN_NBANLISTE, DIALOG_STYLE_TABLIST_HEADERS, "Unban - NBan - Liste", str, "Aç", "Geri");
			}
		}
	}

	if(dialogid == DIALOG_UNBAN_IPLISTE)
	{
		if(!response) return PC_EmulateCommand(playerid, "/unban");
		if(response)
		{
			if(listitem != 12)
			{
				if(IPBanListe[playerid][listitem] == -1) return OnDialogResponse(playerid, DIALOG_UNBAN, 1, 0, "");
				new id = IPBanListe[playerid][listitem], sql[256], ipxs[150];
				format(sql, sizeof(sql), "SELECT * FROM `banlog` WHERE `id` = '%d'", id);
				mysql_query(db, sql);
				cache_get_value_name(0, "ip", ipxs);
				format(sql, sizeof(sql), "unbanip %s", ipxs);
				SendRconCommand(sql);
				SendRconCommand("reloadbans");
				new str[512];
				format(str, sizeof(str), "Baþarýyla "wb"%s "w"IP'sinin baný açýldý.", ipxs);
				AdminBilgi(playerid, str);
				format(sql, sizeof(sql), "DELETE FROM `banlog` WHERE `id` = '%d'", id);
				mysql_query(db, sql);
			}
			else
			{
				new sql[256], sayi, str[10000], nick[24], ip[50];

				format(sql, sizeof(sql), "SELECT * FROM `banlog` LIMIT %d, 12", GetPVarInt(playerid, "IPBANSAYFA"));
				mysql_query(db, sql);
				cache_get_row_count(sayi);

				SetPVarInt(playerid, "IPBANSAYFA", GetPVarInt(playerid, "IPBANSAYFA") + 12);
				for(new i; i < 20; i++) IPBanListe[playerid][i] = -1;

				strcat(str, ""w"#\t"w"Nick\t"w"IP\n");

				for(new i; i < 12; i++)
				{
					if(i < sayi)
					{
						cache_get_value_name_int(i, "id", IPBanListe[playerid][i]);
						cache_get_value_name(i, "banlanan", nick);
						cache_get_value_name(i, "ip", ip);
						format(str, sizeof(str), "%s"wb"»\t"ad"%s\t"w"%s\n", str, nick, ip);
					}
					else
					{
						format(str, sizeof(str), "%s{A9A9A9}---\t{A9A9A9}---------------------------\t{A9A9A9}-----------------\n", str);
					}
				}

				mysql_query(db, "SELECT * FROM `banlog`");
				if(cache_num_rows() > GetPVarInt(playerid, "IPBANSAYFA"))
				{
					strcat(str, "{A9A9A9}>> Sonraki Sayfa");
				}

				ShowPlayerDialog(playerid, DIALOG_UNBAN_IPLISTE, DIALOG_STYLE_TABLIST_HEADERS, "Unban - IPBan - Liste", str, "Aç", "Geri");
			}
		}
	}

	if(dialogid == DIALOG_UNBAN_IP_ARA)
	{
		if(!response) return PC_EmulateCommand(playerid, "/unban");
		if(response)
		{
			if(isnull(inputtext) || !strlen(inputtext)) return Hata(playerid, "Geçersiz bir isim girdiniz."), ShowPlayerDialog(playerid, DIALOG_UNBAN_IP_ARA, DIALOG_STYLE_INPUT, "Unban - IPBan - Ara", ""wb"» "w"Kullanýcý ismi giriniz:", "Ara", "Geri");
			new sql[256], sayi, str[10000], nick[24], ip[50];

			format(sql, sizeof(sql), "SELECT * FROM `banlog` WHERE `banlanan` LIKE '%s%s%s' LIMIT %d, 12", "%", inputtext, "%", GetPVarInt(playerid, "IPBANSAYFA"));
			mysql_query(db, sql);
			cache_get_row_count(sayi);

			if(sayi <= 0) return Hata(playerid, "Oyuncu bulunamadý.");

			SetPVarInt(playerid, "IPBANSAYFA", GetPVarInt(playerid, "IPBANSAYFA") + 12);
			for(new i; i < 20; i++) IPBanListe[playerid][i] = -1;

			strcat(str, ""w"#\t"w"Nick\t"w"IP\n");

			for(new i; i < 12; i++)
			{
				if(i < sayi)
				{
					cache_get_value_name_int(i, "id", IPBanListe[playerid][i]);
					cache_get_value_name(i, "banlanan", nick);
					cache_get_value_name(i, "ip", ip);
					format(str, sizeof(str), "%s"wb"»\t"ad"%s\t"w"%s\n", str, nick, ip);
				}
				else
				{
					format(str, sizeof(str), "%s{A9A9A9}---\t{A9A9A9}---------------------------\t{A9A9A9}-----------------\n", str);
				}
			}

			mysql_query(db, "SELECT * FROM `banlog`");
			if(cache_num_rows() > GetPVarInt(playerid, "IPBANSAYFA"))
			{
				strcat(str, "{A9A9A9}>> Sonraki Sayfa");
			}

			ShowPlayerDialog(playerid, DIALOG_UNBAN_IPLISTE, DIALOG_STYLE_TABLIST_HEADERS, "Unban - IPBan - Liste", str, "Aç", "Geri");
		}
	}

	if(dialogid == DIALOG_UNBAN_NBAN_ARA)
	{
		if(!response) return PC_EmulateCommand(playerid, "/unban");
		if(response)
		{
			if(isnull(inputtext) || !strlen(inputtext)) return Hata(playerid, "Geçersiz bir isim girdiniz."), ShowPlayerDialog(playerid, DIALOG_UNBAN_NBAN_ARA, DIALOG_STYLE_INPUT, "Unban - NBan - Ara", ""wb"» "w"Kullanýcý ismi giriniz:", "Ara", "Geri");

			new sql[256], sayi, str[10000], nick[24], gun, durum[50];

			format(sql, sizeof(sql), "SELECT * FROM `nbanlog` WHERE `banlanan` LIKE '%s%s%s' LIMIT %d, 12", "%", inputtext, "%", GetPVarInt(playerid, "NBANSAYFA"));
			mysql_query(db, sql);
			cache_get_row_count(sayi);

			if(sayi <= 0) return Hata(playerid, "Oyuncu bulunamadý.");

			SetPVarInt(playerid, "NBANSAYFA", GetPVarInt(playerid, "NBANSAYFA") + 12);
			for(new i; i < 20; i++) NBanListe[playerid][i] = -1;

			strcat(str, ""w"#\t"w"Nick\t"w"Kalan Süre\n");

			for(new i; i < 12; i++)
			{
				if(i < sayi)
				{
					cache_get_value_name_int(i, "id", NBanListe[playerid][i]);
					cache_get_value_name(i, "banlanan", nick);
					cache_get_value_name_int(i, "gun", gun);
					if(gettime() > gun)
					{
						durum = ""ad"SONA ERMÝÞ";
					}
					else
					{
						format(durum, sizeof(durum), "{A9A9A9}%s", ConvertTime(gun - gettime()));
					}
					format(str, sizeof(str), "%s"wb"»\t"w"%s\t%s\n", str, nick, durum);
				}
				else
				{
					format(str, sizeof(str), "%s{A9A9A9}---\t{A9A9A9}---------------------------\t{A9A9A9}-----------------\n", str);
				}
			}

			mysql_query(db, "SELECT * FROM `nbanlog`");
			if(cache_num_rows() > GetPVarInt(playerid, "NBANSAYFA"))
			{
				strcat(str, "{A9A9A9}>> Sonraki Sayfa");
			}

			ShowPlayerDialog(playerid, DIALOG_UNBAN_NBANLISTE, DIALOG_STYLE_TABLIST_HEADERS, "Unban - NBan - Liste", str, "Aç", "Geri");
		}
	}

	if(dialogid == DIALOG_UNBAN)
	{
		if(!response) return true;
		if(response)
		{
			switch(listitem)
			{
				case 2: return PC_EmulateCommand(playerid, "/unban");
				case 5: return PC_EmulateCommand(playerid, "/unban");

				case 0:
				{
					SetPVarInt(playerid, "IPBANSAYFA", 0);
					for(new i; i < 20; i++) IPBanListe[playerid][i] = -1;
					IPBanListele(playerid);
				}
				case 1:
				{
					SetPVarInt(playerid, "IPBANSAYFA", 0);
					for(new i; i < 20; i++) IPBanListe[playerid][i] = -1;
					ShowPlayerDialog(playerid, DIALOG_UNBAN_IP_ARA, DIALOG_STYLE_INPUT, "Unban - IPBan - Ara", ""wb"» "w"Kullanýcý ismi giriniz:", "Ara", "Geri");
				}

				case 3:
				{
					SetPVarInt(playerid, "NBANSAYFA", 0);
					for(new i; i < 20; i++) NBanListe[playerid][i] = -1;
					NBanListele(playerid);
				}
				case 4:
				{
					SetPVarInt(playerid, "NBANSAYFA", 0);
					for(new i; i < 20; i++) NBanListe[playerid][i] = -1;
					ShowPlayerDialog(playerid, DIALOG_UNBAN_NBAN_ARA, DIALOG_STYLE_INPUT, "Unban - NBan - Ara", ""wb"» "w"Kullanýcý ismi giriniz:", "Ara", "Geri");
				}

				case 6:
				{
					Bilgi(playerid, "Coming Soon");
					//SBanListele(playerid);
				}
				case 7:
				{
					Bilgi(playerid, "Coming Soon");
					//ShowPlayerDialog(playerid, DIALOG_UNBAN_SBAN_ARA, DIALOG_STYLE_MSGBOX, "Unban - SBan - Ara", ""wb"» "w"Kullanýcý ismi giriniz:", "Ara", "Geri");
				}
			}
		}
	}

	if(dialogid == DIALOG_BUGRAPORLAR)
	{
		if(!response) return true;
		if(response)
		{
			if(listitem == 10)
			{
				new sql[500], str[10000], raporsayi, gonderen[24], tarih[50], okundu;

				strcat(str, ""w"Sýra\t"w"Gönderen\t"w"Tarih\t"w"Durum\n");
				format(sql, sizeof(sql), "SELECT * FROM `bugrapor_log` LIMIT %d, 10", GetPVarInt(playerid, "BugRaporSayfa"));
				mysql_query(db, sql);

				for(new i; i < 20; i++) BugRaporID[playerid][i] = -1;
				SetPVarInt(playerid, "BugRaporSayfa", GetPVarInt(playerid, "BugRaporSayfa") + 10);

				cache_get_row_count(raporsayi);

				for(new i; i < 10; i++)
				{
					if(i < raporsayi)
					{
						cache_get_value_name_int(i, "id", BugRaporID[playerid][i]);
						cache_get_value_name(i, "gonderen", gonderen, 24);
						cache_get_value_name(i, "tarih", tarih, 50);
						cache_get_value_name_int(i, "okundu", okundu);
						format(str, sizeof(str), "%s"w"%d-)\t"w"%s\t"w"%s\t%s\n", str, i + 1, gonderen, tarih, (okundu == 0 ? (""ad"Okunmamýþ") : (""r"Okunmuþ")));
					}
					else
					{
						format(str, sizeof(str), "%s"w"%d-)\t{A9A9A9}---\t{A9A9A9}---\t{A9A9A9}---\n", str, i + 1);
					}
				}

				mysql_query(db, "SELECT * FROM `bugrapor_log`");
				if(cache_num_rows() > GetPVarInt(playerid, "BugRaporSayfa"))
				{
					strcat(str, ">> Sonraki Sayfa");
				}

				ShowPlayerDialog(playerid, DIALOG_BUGRAPORLAR, DIALOG_STYLE_TABLIST_HEADERS, "Bug Raporlarý", str, "Seç", "Kapat");
			}
			else if(listitem != 10)
			{
				if(BugRaporID[playerid][listitem] == -1) return PC_EmulateCommand(playerid, "/bugraporlar");

				new id = BugRaporID[playerid][listitem], sql[500], yazi[2048], dialog[2048 * 2], gonderen[24], tarih[50];

				format(sql, sizeof(sql), "SELECT * FROM `bugrapor_log` WHERE `id` = '%d'", id);
				mysql_query(db, sql);

				SetPVarInt(playerid, "raporid", id);

				cache_get_value_name(0, "mesaj", yazi, 2048);
				cache_get_value_name(0, "gonderen", gonderen, 24);
				cache_get_value_name(0, "tarih", tarih, 50);

				format(dialog, sizeof(dialog), "\
					"wb">> "w"Bugrapor ID: "wb"%d\n\
					"wb">> "w"Bugrapor Gönderen: "wb"%s\n\
					"wb">> "w"Bugrapor Tarihi: "wb"%s\n\n\
					\t"wb">> "w"Bugrapor Mesajý: "wb"%s", 
					id, gonderen, tarih, yazi);

				ShowPlayerDialog(playerid, DIALOG_BUGRAPORLAR_OKUNDU, DIALOG_STYLE_MSGBOX, "Bugrapor Gösterim", dialog, "Okundu", "Geri");
			}
		}
	}

	if(dialogid == DIALOG_BUGRAPORLAR_OKUNDU)
	{
		if(!response)
		{
			return PC_EmulateCommand(playerid, "/bugraporlar");
		}
		if(response)
		{
			new id = GetPVarInt(playerid, "raporid"), sql[500];
			format(sql, sizeof(sql), "UPDATE `bugrapor_log` SET `okundu` = '1' WHERE `id` = '%d'", id);
			mysql_query(db, sql);
			AdminBilgi(playerid, "Bugrapor okundu olarak iþaretlendi.");
			PC_EmulateCommand(playerid, "/bugraporlar");
		}
	}

	if(dialogid == DIALOG_TESTLER)
	{
		if(!response) return true;
		if(response)
		{
			AdminBilgi(playerid, "Þu anda aktif bir test yoksa baþlayacaktýr.");
			switch(listitem)
			{
				case 0: ReaksiyonTesti();
				case 1: MatematikTesti();
				case 2: Lotto();
			}
		}
	}

	if(dialogid == DIALOG_YOUTUBE_ARAMA)
	{
		if(!response)
		{
			YT_Islem = false;
			return true;
		}
		if(response)
		{
			new id = YoutubeIDCek(), url[500], link[500];
			format(url, sizeof(url), "%s", Arama[playerid][listitem][Link]);
			format(link, sizeof(link), "michaelbelgium.me/ytconverter/convert.php?youtubelink=%s", Arama[playerid][listitem][Link]);
			HTTP(id, HTTP_GET, link, "", "YT_Cal");
			printf("link: %s - id: %d", link, id);
		}
	}

	if(dialogid == DIALOG_ARKADASLARIM_EKLE)
	{
		if(!response) return PC_EmulateCommand(playerid, "/arkadaslarim");
		if(response)
		{
			new id;
			if(!strlen(inputtext) || isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_ARKADASLARIM_EKLE, DIALOG_STYLE_INPUT, "Arkadaþ Ekle", ""wb"» "w"Arkadaþ olarak eklemek istediðiniz kiþinin isim veya ID girin:\n\n"r"(Bir deðer girmelisiniz!)", "Ekle", "Geri");
			if(!IsNumeric(inputtext))
			{
				id = GetPlayerID(inputtext);
			}
			else
			{
				id = strval(inputtext);
			}
			if(!IsPlayerConnected(id)) return ShowPlayerDialog(playerid, DIALOG_ARKADASLARIM_EKLE, DIALOG_STYLE_INPUT, "Arkadaþ Ekle", ""wb"» "w"Arkadaþ olarak eklemek istediðiniz kiþinin isim veya ID girin:\n\n"r"(Oyuncu oyunda deðil!)", "Ekle", "Geri");

			SetPVarInt(id, "arkadas_istek_geldi", playerid);
			new str[512];
			format(str, sizeof(str), "\
				"wb"» {%06x}%s "w"isimli oyuncu size arkadaþlýk isteði gönderdi.\n\
				"wb"» "w"Eðer kabul ederseniz istediði zaman size ýþýnlanabilecek.\n\n\
				"wb"» "w"Kabul ediyor musunuz?", GetPlayerColor(playerid) >>> 8, getName(playerid));
			ShowPlayerDialog(id, DIALOG_ARKADASLARIM_DEGERLENDIR, DIALOG_STYLE_MSGBOX, "Arkadaþlýk Ýsteði", str, ""ad"Kabul et", ""r"Reddet");
			AdminBilgi(playerid, "Arkadaþlýk isteði gönderildi.");
		}
	}

	if(dialogid == DIALOG_ARKADASLARIM_DEGERLENDIR)
	{
		if(!response)
		{
			new id = GetPVarInt(playerid, "arkadas_istek_geldi");
			if(IsPlayerConnected(id)) AdminBilgi(id, "Arkadaþlýk isteðiniz reddedildi.");
			Bilgi(playerid, "Arkadaþlýk isteðini red ettiniz.");
		}
		if(response)
		{
			new id = GetPVarInt(playerid, "arkadas_istek_geldi"), sql[500];
			if(!IsPlayerConnected(id)) return true;
			Iter_Add(arkadaslarim<playerid>, pData[id][pSQLID]);
			Iter_Add(arkadaslarim<id>, pData[playerid][pSQLID]);
			format(sql, sizeof(sql), "INSERT INTO `arkadaslar` (`eklenen`, `ekleyen`) VALUES ('%d', '%d')", pData[playerid][pSQLID], pData[id][pSQLID]);
			mysql_query(db, sql);
			AdminBilgi(id, "Arkadaþlýk isteðiniz kabul edildi!");
			Bilgi(playerid, "Arkadaþlýk isteðini kabul ettiniz.");
		}
	}

	if(dialogid == DIALOG_ARKADASLARIM)
	{
		if(!response) return true;
		if(response)
		{
			if(listitem == 0)
			{
				ShowPlayerDialog(playerid, DIALOG_ARKADASLARIM_EKLE, DIALOG_STYLE_INPUT, "Arkadaþ Ekle", ""wb"» "w"Arkadaþ olarak eklemek istediðiniz kiþinin isim veya ID girin:\n", "Ekle", "Geri");
			}
			else if(listitem == 1)
			{
				ShowPlayerDialog(playerid, DIALOG_ARKADASLARIM_SIL, DIALOG_STYLE_INPUT, "Arkadaþ Sil", ""wb"» "w"Arkadaþlýktan çýkarmak istediðiniz kiþinin isim veya ID girin:\n", "Çýkar", "Geri");
			}
			else
			{
				new sqlid = Arkadaslar[playerid][listitem], id = GetPlayerID(SQL_Isim_Cek(sqlid));
				if(IsPlayerConnected(id))
				{
					new Float: x, Float: y, Float: z, str[512];
					GetPlayerPos(id, x, y, z);
					SetPlayerPos(playerid, x + 3, y, z);
					format(str, sizeof(str), "Arkadaþýnýz "wb"%s "w"yanýnýza ýþýnlandý.", getName(playerid));
					AdminBilgi(id, str);
					format(str, sizeof(str), ""wb"%s "w"adlý arkadaþýnýzýn yanýna ýþýnlandýnýz.", getName(id));
					AdminBilgi(playerid, str);
				}
				else
				{
					Hata(playerid, "Arkadaþýnýz oyunda deðil!");
				}
			}
		}
	}

	if(dialogid == DIALOG_EV_SATINAL)
	{
		if(!response) return true;
		if(response)
		{
			new i = GetPVarInt(playerid, "alinacak_ev");
			EvInfo[i][evSahip] = pData[playerid][pSQLID];
			GivePlayerMoney(playerid, -EvInfo[i][evFiyat]);
			EvInfo[i][evKilit] = 0;
			pData[playerid][pEv] = i;
			OyuncuKaydet(playerid);
			EvLabelGuncelle(i);

			EvKaydet(i);

			new str[512];
			format(str, sizeof(str), ""w"Evi baþarýyla satýn aldýnýz. ("wb"-%s TL"w")", FormatMoney(EvInfo[i][evFiyat]));
			return AdminBilgi(playerid, str);
		}
	}

	if(dialogid == DIALOG_EVIM_ESYA_YONET)
	{
		if(!response) return OnDialogResponse(playerid, DIALOG_EVIM, 1, 8, "");
		if(response)
		{
			new slot = GetPVarInt(playerid, "esyayonet_slot"), id = pData[playerid][pEv];
			switch(listitem)
			{
				case 0:
				{
					SetPVarInt(playerid, "sonradanduzenle", 1);
					EditDynamicObject(playerid, EvInfo[pData[playerid][pEv]][evObjeler][slot]);
				}
				case 1:
				{
					if(IsValidDynamicObject(EvInfo[pData[playerid][pEv]][evObjeler][slot])) DestroyDynamicObject(EvInfo[pData[playerid][pEv]][evObjeler][slot]);
					EvInfo[id][evObjeler][slot] = -1;
					evObjelerPos[id][slot][0] = -1.0;
					evObjelerPos[id][slot][1] = -1.0;
					evObjelerPos[id][slot][2] = -1.0;
					evObjelerPos[id][slot][3] = -1.0;
					evObjelerPos[id][slot][4] = -1.0;
					evObjelerPos[id][slot][5] = -1.0;
					evObjelerID[id][slot] = -1;
					EvObjeKaydet(id);
					AdminBilgi(playerid, "Eþya satýldý!");
				}
			}
		}
	}

	if(dialogid == DIALOG_EVIM_ESYA)
	{
		if(!response) return PC_EmulateCommand(playerid, "/evim");
		if(response)
		{
			new id = pData[playerid][pEv];
			if(evObjelerID[id][listitem] == -1)
			{
				PC_EmulateCommand(playerid, "/evesya");
			}
			else
			{
				ShowPlayerDialog(playerid, DIALOG_EVIM_ESYA_YONET, DIALOG_STYLE_LIST, "Ev Menüsü - Eþya Yönetimi", ""wb"» "w"Eþyayý Düzenle\n"wb"» "w"Eþyayý Sil", "Seç", "Geri");
				SetPVarInt(playerid, "esyayonet_slot", listitem);
			}
		}
	}

	if(dialogid == DIALOG_EVIM_ISIM)
	{
		if(!response) return PC_EmulateCommand(playerid, "/evim");
		if(response)
		{
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_EVIM_ISIM, DIALOG_STYLE_INPUT, "Ev Menüsü - Ýsim Deðiþtir", ""wb"» "w"Evinize vermek istediðiniz ismi girin:\n\n"r"(Ev isimi en az 3, en fazla 20 karakter olabilir.)", "Tamam", "Geri");
			if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_EVIM_ISIM, DIALOG_STYLE_INPUT, "Ev Menüsü - Ýsim Deðiþtir", ""wb"» "w"Evinize vermek istediðiniz ismi girin:\n\n"r"(Ev isimi en az 3, en fazla 20 karakter olabilir.)", "Tamam", "Geri");
			if(strlen(inputtext) < 3 || strlen(inputtext) > 20) return ShowPlayerDialog(playerid, DIALOG_EVIM_ISIM, DIALOG_STYLE_INPUT, "Ev Menüsü - Ýsim Deðiþtir", ""wb"» "w"Evinize vermek istediðiniz ismi girin:\n\n"r"(Ev isimi en az 3, en fazla 20 karakter olabilir.)", "Tamam", "Geri");

			new id = pData[playerid][pEv];
			format(EvInfo[id][evIsim], 100, "%s", inputtext);
			EvLabelGuncelle(id);
			AdminBilgi(playerid, "Ev ismi baþarýyla güncellendi.");
			EvKaydet(id);
		}
	}

	if(dialogid == DIALOG_EVIM_SAT)
	{
		if(!response) return PC_EmulateCommand(playerid, "/evim");
		if(response)
		{
			new id = pData[playerid][pEv];
			format(EvInfo[id][evIsim], 100, "Ev");
			pData[playerid][pEv] = -1;
			EvInfo[id][evSahip] = -1;
			EvInfo[id][evKilit] = 0;
			for(new i; i < 10; i++)
			{
				if(IsValidDynamicObject(EvInfo[id][evObjeler][i]))
				{
					DestroyDynamicObject(EvInfo[id][evObjeler][i]);
				}
				for(new x; x < 6; x++)
				{
					evObjelerPos[id][i][x] = -1.0;
				}
				evObjelerID[id][i] = -1;
			}
			EvObjeKaydet(id);
			EvLabelGuncelle(id);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, EvInfo[id][evX], EvInfo[id][evY], EvInfo[id][evZ]);
			AdminBilgi(playerid, "Evinizi baþarýyla sattýnýz.");
			GivePlayerMoney(playerid, EvInfo[id][evFiyat] / 2);
			OyuncuKaydet(playerid);
			EvKaydet(id);
		}
	}

	if(dialogid == DIALOG_EVIM)
	{
		if(!response) return true;
		if(response)
		{
			new id = pData[playerid][pEv];
			switch(listitem)
			{
				case 0..4: PC_EmulateCommand(playerid, "/evim");
				case 5:
				{
					ShowPlayerDialog(playerid, DIALOG_EVIM_ISIM, DIALOG_STYLE_INPUT, "Ev Menüsü - Ýsim Deðiþtir", ""wb"» "w"Evinize vermek istediðiniz ismi girin:\n", "Tamam", "Geri");
				}
				case 6:
				{
					switch(EvInfo[id][evKilit])
					{
						case 0:
						{
							EvInfo[id][evKilit] = 1;
							AdminBilgi(playerid, "Eviniz kitlendi. "r"Artýk sadece siz girebileceksiniz.");
						}
						case 1:
						{
							EvInfo[id][evKilit] = 0;
							AdminBilgi(playerid, "Evinizin kilidi açýldý. "ad"Artýk herkes girebilecek.");
						}
					}
					EvLabelGuncelle(id);
					EvKaydet(id);
					PC_EmulateCommand(playerid, "/evim");
				}
				case 7:
				{
					new str[2048], durum[35];
					strcat(str, ""w"#\t"w"#\n");
					for(new i; i < 10; i++)
					{
						if(evObjelerID[id][i] == -1)
						{
							durum = ""ad"BOÞ";
						}
						else
						{
							durum = ""r"DOLU";
						}
						format(str, sizeof(str), "%s"wb"» "w"Eþya slotu %d\t%s\n", str, i + 1, durum);
					}
					ShowPlayerDialog(playerid, DIALOG_EVIM_ESYA, DIALOG_STYLE_TABLIST_HEADERS, "Ev Menüsü - Eþya", str, "Seç", "Geri");
				}
				case 8:
				{
					PC_EmulateCommand(playerid, "/evim");
				}
				case 9:
				{
					new str[2048], str2[500];
					format(str2, sizeof(str2), ""wb"» "w"Ev Ýsmi: "wb"%s\n", EvInfo[id][evIsim]);
					strcat(str, str2);
					format(str2, sizeof(str2), ""wb"» "w"Ev Fiyatý: "wb"%s TL\n", FormatMoney(EvInfo[id][evFiyat]));
					strcat(str, str2);
					format(str2, sizeof(str2), ""wb"» "w"Ev Sahibi: "wb"%s\n", SQL_Isim_Cek(EvInfo[id][evSahip]));
					strcat(str, str2);
					format(str2, sizeof(str2), ""wb"» "w"Ev Bölgesi: "wb"%s\n\n", GetZoneName(EvInfo[id][evX], EvInfo[id][evY], EvInfo[id][evZ]));
					strcat(str, str2);
					format(str2, sizeof(str2), ""wb"» "w"Evi satýnca alcaðýnýz fiyat: "wb"%s TL\n", FormatMoney(EvInfo[id][evFiyat] / 2));
					strcat(str, str2);
					format(str2, sizeof(str2), ""wb"» "w"Evi gerçekten satmak istiyor musunuz?");
					strcat(str, str2);
					ShowPlayerDialog(playerid, DIALOG_EVIM_SAT, DIALOG_STYLE_MSGBOX, ""w"Ev Menüsü - Satým", str, ""ad"Evet", ""r"Hayýr");
				}
			}
		}
	}

	if(dialogid == DIALOG_ISYERI_SATINAL)
	{
		if(!response) return true;
		if(response)
		{
			new i = GetPVarInt(playerid, "alinacak_isyeri");

			if(iData[i][iSahip] != -1) return true;

			iData[i][iSahip] = pData[playerid][pSQLID];
			iData[i][iBitisZaman] = gettime() + 604800;

			IsYeriKaydet(i);

			IsYeriLabelGuncelle(i);

			GivePlayerMoney(playerid, -iData[i][iFiyat]);

			pData[playerid][pIsYeri] = i;

			OyuncuKaydet(playerid);

			return AdminBilgi(playerid, "Ýþyerini baþarýyla satýn aldýnýz.");
		}
	}

	if(dialogid == DIALOG_SAVEPOS)
	{
		if(!response) return true;
		if(response)
		{
			if(Poslar[playerid][listitem][0] != -1.0 && Poslar[playerid][listitem][0] != -1.0 && Poslar[playerid][listitem][0] != -1.0) return Hata(playerid, "Bu slot dolu!"), PC_EmulateCommand(playerid, "/savepos");
			new Float: x, Float: y, Float: z;
			GetPlayerPos(playerid, x, y, z);
			Poslar[playerid][listitem][0] = x;
			Poslar[playerid][listitem][1] = y;
			Poslar[playerid][listitem][2] = z;
			AdminBilgi(playerid, "Bölge baþarýyla kayýt altýna alýndý!");
			PosKayit(playerid);
		}
	}

	if(dialogid == DIALOG_LOADPOS)
	{
		if(!response) return true;
		if(response)
		{
			if(Poslar[playerid][listitem][0] == -1.0 && Poslar[playerid][listitem][1] == -1.0 && Poslar[playerid][listitem][2] == -1.0) return Hata(playerid, "Bu slot boþ!"), PC_EmulateCommand(playerid, "/loadpos");
			SetPlayerPV(playerid, Poslar[playerid][listitem][0], Poslar[playerid][listitem][1], Poslar[playerid][listitem][2]);
			AdminBilgi(playerid, "Kayýtlý bölgeye ýþýnlandýnýz!");
		}
	}

	if(dialogid == DIALOG_KLAN_BASVURU_SECIM)
	{
		if(!response) return PC_EmulateCommand(playerid, "/klan");
		if(response)
		{
			new sqlid = KlanBasvurular[playerid][listitem], str[512];
			SetPVarInt(playerid, "klanbasvuru_secim", sqlid);
			format(str, sizeof(str), ""wb"» %s "w"adlý oyuncunun baþvurusu kabul edilsin mi?", SQL_Isim_Cek(sqlid));
			ShowPlayerDialog(playerid, DIALOG_KLAN_BASVURU_DEGERLENDIR, DIALOG_STYLE_MSGBOX, "Klan Baþvurusu - Deðerlendir", str, ""ad"Evet", ""r"Hayýr");
		}
	}

	if(dialogid == DIALOG_KLAN_BASVURU_DEGERLENDIR)
	{
		if(!response)
		{
			new sqlid = GetPVarInt(playerid, "klanbasvuru_secim"), sql[500], id = GetPlayerID(SQL_Isim_Cek(sqlid));
			format(sql, sizeof(sql), "DELETE FROM `klan_basvurulari` WHERE `sqlid` = '%d' AND `klanid` = '%d'", sqlid, pData[playerid][pKlan]);
			mysql_query(db, sql);
			AdminBilgi(playerid, "Baþvuruyu reddettiniz.");
			if(IsPlayerConnected(id))
				AdminBilgi(id, "Klan baþvurunuz reddedildi.");
		}
		if(response)
		{
			new sqlid = GetPVarInt(playerid, "klanbasvuru_secim"), klanid, ev, isyeri, sql[1024], str[512];
			format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `sqlid` = '%d'", sqlid);
			mysql_query(db, sql);
			cache_get_value_name_int(0, "klan", klanid);
			cache_get_value_name_int(0, "ev", ev);
			cache_get_value_name_int(0, "isyeri", isyeri);
			if(klanid != -1)
			{
				Hata(playerid, "Oyuncu baþka bir klana katýlmýþ, baþvuru silindi.");
				format(sql, sizeof(sql), "DELETE FROM `klan_basvurulari` WHERE `sqlid` = '%d' AND `klanid` = '%d'", sqlid, pData[playerid][pKlan]);
				mysql_query(db, sql);
				return true;
			}
			else
			{
				new id = GetPlayerID(SQL_Isim_Cek(sqlid));
				if(IsPlayerConnected(id))
				{
					pData[id][pKlan] = pData[playerid][pKlan];
					pData[id][pKlanRutbe] = 0;
					format(str, sizeof(str), "[%s]%s", kData[pData[playerid][pKlan]][kTag], getName(id));
					SetPlayerName(id, str);
					format(str, sizeof(str), ""wb"» "w"%s klana katýldý!", getName(id));
					KlanMesaji(pData[playerid][pKlan], str);
					OyuncuKaydet(id);
					format(sql, sizeof(sql), "UPDATE `hesaplar` SET `kullaniciadi` = '%s' WHERE `sqlid` = '%d'", getName(id), pData[id][pSQLID]);
					mysql_query(db, sql);
					AdminBilgi(id, "Klan baþvurunuz kabul edildi!");
					if(pData[id][pIsYeri] != -1) IsYeriLabelGuncelle(pData[id][pIsYeri]);
					if(pData[id][pEv] != -1) EvLabelGuncelle(pData[id][pEv]);
				}
				else
				{
					format(sql, sizeof(sql), "UPDATE `hesaplar` SET `klan` = '%d', `klanrutbe` = '0' WHERE `sqlid` = '%d'", pData[playerid][pKlan], sqlid);
					mysql_query(db, sql);
					new isim[50], isim2[50];
					format(isim, sizeof(isim), "%s", SQL_Isim_Cek(sqlid));
					format(isim2, sizeof(isim2), "[%s]%s", kData[pData[playerid][pKlan]][kTag], isim);
					format(sql, sizeof(sql), "UPDATE `hesaplar` SET `kullaniciadi` = '%s' WHERE `sqlid` = '%d'", isim2, sqlid);
					mysql_query(db, sql);
					format(str, sizeof(str), ""wb"» "w"%s klana katýldý!", isim2);
					KlanMesaji(pData[playerid][pKlan], str);
					if(isyeri != -1) IsYeriLabelGuncelle(isyeri);
					if(ev != -1) EvLabelGuncelle(ev);
					AdminBilgi(playerid, "Oyuncu baþarýyla klana alýndý.");
				}
				format(sql, sizeof(sql), "DELETE FROM `klan_basvurulari` WHERE `sqlid` = '%d' AND `klanid` = '%d'", sqlid, pData[playerid][pKlan]);
				mysql_query(db, sql);
			}
		}
	}

	if(dialogid == DIALOG_KLAN_BASVURU)
	{
		if(!response) return PC_EmulateCommand(playerid, "/klanlar");
		if(response)
		{
			if(pData[playerid][pKlan] != -1) return Hata(playerid, "Bir klanýnýz varken baþvuru yapamazsýnýz!");
			new id = GetPVarInt(playerid, "klan_basvuru"), sql[500];
			if(KlanUyeSayisi(id) > kData[id][kLevel] * 10) return Hata(playerid, "Klanýn oyuncu sýnýrý aþýlmýþ!");
			format(sql, sizeof(sql), "INSERT INTO `klan_basvurulari` (`sqlid`, `klanid`) VALUES ('%d', '%d')", pData[playerid][pSQLID], id);
			mysql_query(db, sql);

			foreach(new i: Player)
			{
				if(pData[i][pKlan] == id && pData[i][pKlanRutbe] >= 1)
				{
					AdminBilgi(i, "Yeni bir klan baþvurusu geldi!");
				}
			}

			AdminBilgi(playerid, "Baþarýyla baþvuru yaptýnýz.");
		}
	}

	if(dialogid == DIALOG_GALERI_SATINAL)
	{
		if(!response) return DeletePVar(playerid, "modell"), true;
		if(response)
		{
			new rq1, rq2, id = Iter_Free(araclar), Float: x, Float: y, Float: z, Float: f, sql[1024], modelid = GetPVarInt(playerid, "modell");

			rq1 = random(255);
			rq2 = random(255);
			format(aData[id][aPlaka], 50, "%s", PlakaYarat(id, listitem + 1));
			x = 0;
			y = 0;
			z = 0;
			f = 0;
			GetPlayerFacingAngle(playerid, f);
			format(sql, sizeof(sql), "INSERT INTO `araclar` (`id`, `sahip`, `model`, `x`, `y`, `z`, `f`, `renk1`, `renk2`, `plaka`) VALUES ('%d', '-1', '%d', '%f', '%f', '%f', '%f', '%d', '%d', '%s')", id, modelid, x, y, z, f, rq1, rq2, aData[id][aPlaka]);
			mysql_query(db, sql);

			aData[id][aSahip] = -1;
			aData[id][aModel] = modelid;
			aData[id][aMod1] = 0;
			aData[id][aMod2] = 0;
			aData[id][aMod3] = 0;
			aData[id][aMod4] = 0;
			aData[id][aMod5] = 0;
			aData[id][aMod6] = 0;
			aData[id][aMod7] = 0;
			aData[id][aMod8] = 0;
			aData[id][aMod9] = 0;
			aData[id][aMod10] = 0;
			aData[id][aMod11] = 0;
			aData[id][aMod12] = 0;
			aData[id][aMod13] = 0;
			aData[id][aMod14] = 0;
			aData[id][aMod15] = 0;
			aData[id][aMod16] = 0;
			aData[id][aMod17] = 0;
			aData[id][aPaintJob] = -1;
			aData[id][aRenk1] = rq1;
			aData[id][aRenk1] = rq2;
			aData[id][aX] = 0;
			aData[id][aY] = 0;
			aData[id][aZ] = 0;
			aData[id][aF] = 0;
			aData[id][aBenzin] = 100;
			aData[id][aKilit] = true;

			aData[id][aID] = CreateVehicle(aData[id][aModel], aData[id][aX], aData[id][aY], aData[id][aZ], aData[id][aF], aData[id][aRenk1], aData[id][aRenk2], -1);
			SetVehicleNumberPlate(aData[id][aID], aData[id][aPlaka]);
			SetVehicleToRespawn(aData[id][aID]);

			Iter_Add(araclar, id);

			format(sql, sizeof(sql), "UPDATE `araclar` SET `sahip` = '%d' WHERE `id` = '%d'", pData[playerid][pSQLID], id);
			mysql_query(db, sql);

			format(sql, sizeof(sql), "UPDATE `hesaplar` SET `arac` = '%d' WHERE `sqlid` = '%d'", id, pData[playerid][pSQLID]);
			mysql_query(db, sql);

			aData[id][aSahip] = pData[playerid][pSQLID];

			pData[playerid][pArac] = id;

			GivePlayerMoney(playerid, -14000);

			AdminBilgi(playerid, "Aracýnýzý baþarýyla satýn aldýnýz! "wb"/a "w"komutu ile yönetebilirsiniz.");
		}
	}

	if(dialogid == DIALOG_KLAN_UYELER)
	{
		if(!response) return PC_EmulateCommand(playerid, "/klan");
		if(response)
		{
			if(pData[playerid][pKlanRutbe] < 2) return Hata(playerid, "Bu iþlem için yetkiniz bulunmuyor!"), OnDialogResponse(playerid, DIALOG_KLAN_GENEL, 1, 7, "");
			SetPVarInt(playerid, "Klan_Duzenlenen", KlanOyuncuDuzenleme[playerid][listitem]);
			ShowPlayerDialog(playerid, DIALOG_KLAN_DUZENLE, DIALOG_STYLE_LIST, "Üye Düzenle", ""wb"» "w"Klandan At\n"wb"» "w"Yetki Deðiþtir", "Seç", "Iptal");
		}
	}

	if(dialogid == DIALOG_KLAN_DUZENLE)
	{
		if(!response) return OnDialogResponse(playerid, DIALOG_KLAN_GENEL, 1, 7, "");
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new sqlid = GetPVarInt(playerid, "Klan_Duzenlenen"), sql[500], isimX[24], rutbesi, ev, isyeri;
					if(pData[playerid][pSQLID] == sqlid) return Hata(playerid, "Kendinizi atamazsýnýz!");
					format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `sqlid` = '%d'", sqlid);
					mysql_query(db, sql);

					cache_get_value_name(0, "kullaniciadi", isimX, 24);
					cache_get_value_name_int(0, "klanrutbe", rutbesi);
					cache_get_value_name_int(0, "ev", ev);
					cache_get_value_name_int(0, "isyeri", isyeri);

					new id = GetPlayerID(isimX);
					if(IsPlayerConnected(id))
					{
						if(pData[id][pKlan] != pData[playerid][pKlan]) return Hata(playerid, "Oyuncu sizin klanýnýzda deðil!");
						if(pData[id][pKlanRutbe] > pData[playerid][pKlanRutbe]) return Hata(playerid, "Oyuncu sizden yüksek rütbede!");
						pData[id][pKlan] = -1;
						pData[id][pKlanRutbe] = 0;
						new bul, tag[25], isim[24], str[512];
						GetPlayerName(id, isim, 24);
						format(tag, sizeof(tag), "%s", kData[pData[playerid][pKlan]][kTag]);
						bul = strfind(isim, tag);
						strdel(isim, bul - 1, bul + strlen(tag) + 1);
						SetPlayerName(id, isim);
						format(str, sizeof(str), ""wb"» "w"%s klandan atýldý!", getName(id));
						KlanMesaji(pData[playerid][pKlan], str);
						OyuncuKaydet(id);
						format(sql, sizeof(sql), "UPDATE `hesaplar` SET `kullaniciadi` = '%s' WHERE `sqlid` = '%d'", getName(id), pData[id][pSQLID]);
						mysql_query(db, sql);
						if(pData[id][pIsYeri] != -1) IsYeriLabelGuncelle(pData[id][pIsYeri]);
						if(pData[id][pEv] != -1) EvLabelGuncelle(pData[id][pEv]);
					}
					else
					{
						if(rutbesi > pData[playerid][pKlanRutbe]) return Hata(playerid, "Oyuncu sizden yüksek rütbede!");
						new bul, tag[25], str[512];
						format(tag, sizeof(tag), "%s", kData[pData[playerid][pKlan]][kTag]);
						bul = strfind(isimX, tag);
						strdel(isimX, bul - 1, bul + strlen(tag) + 1);
						format(sql, sizeof(sql), "UPDATE `hesaplar` SET `kullaniciadi` = '%s', `klan` = '-1', `klanrutbe` = '0' WHERE `sqlid` = '%d'", isimX, sqlid);
						mysql_query(db, sql);
						format(str, sizeof(str), ""wb"» "w"%s klandan atýldý!", isimX);
						KlanMesaji(pData[playerid][pKlan], str);
						if(ev != -1) EvLabelGuncelle(ev);
						if(isyeri != -1) IsYeriLabelGuncelle(isyeri);
					}
				}
				case 1:
				{
					new str[1024], sql[500], baslik[150], sqlid = GetPVarInt(playerid, "Klan_Duzenlenen"), isimX[24];
					format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `sqlid` = '%d'", sqlid);
					mysql_query(db, sql);

					cache_get_value_name(0, "kullaniciadi", isimX, 24);

					format(baslik, sizeof(baslik), "%s - Rütbe Deðiþimi", isimX);
					for(new i; i < sizeof(KlanRutbeleri); i++)
					{
						format(str, sizeof(str), "%s"wb"» "w"%s\n", str, KlanRutbeleri[i]);
					}
					ShowPlayerDialog(playerid, DIALOG_KLAN_DUZENLE_RUTBE, DIALOG_STYLE_LIST, baslik, str, "Ver", "Geri");
				}
			}
		}
	}

	if(dialogid == DIALOG_KLAN_DUZENLE_RUTBE)
	{
		if(!response) return ShowPlayerDialog(playerid, DIALOG_KLAN_DUZENLE, DIALOG_STYLE_LIST, "Üye Düzenle", ""wb"» "w"Klandan At\n"wb"» "w"Yetki Deðiþtir", "Seç", "Iptal");
		if(response)
		{
			new sql[500], sqlid = GetPVarInt(playerid, "Klan_Duzenlenen"), isim[24], rutbesi, id;
			format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `sqlid` = '%d'", sqlid);
			mysql_query(db, sql);
			cache_get_value_name(0, "kullaniciadi", isim, 24);
			cache_get_value_name_int(0, "klanrutbe", rutbesi);
			if(rutbesi > pData[playerid][pKlanRutbe]) return Hata(playerid, "Oyuncunun yetkisi sizden yüksek!");
			id = GetPlayerID(isim);
			if(IsPlayerConnected(id))
			{
				pData[id][pKlanRutbe] = listitem;
				OyuncuKaydet(id);
				AdminBilgi(id, "Klan rütbeniz düzenlendi! Kontrol ediniz.");
			}
			else
			{
				format(sql, sizeof(sql), "UPDATE `hesaplar` SET `klanrutbe` = '%d' WHERE `sqlid` = '%d'", listitem, sqlid);
				mysql_query(db, sql);
			}
			AdminBilgi(playerid, "Oyuncunun yetkisini baþarýyla düzenlediniz!");
		}
	}

	if(dialogid == DIALOG_ARACIM_ANAHTAR)
	{
		if(!response) return PC_EmulateCommand(playerid, "/a");
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialog(playerid, DIALOG_ARACIM_ANAHTAR_VER, DIALOG_STYLE_INPUT, "Anahtar Ver", ""wb"» "w"Anahtar verilecek kiþinin TAM ÝSMÝNÝ yazýn:\n", "Ver", "Geri");
				}
				case 1:
				{
					ShowPlayerDialog(playerid, DIALOG_ARACIM_ANAHTAR_AL, DIALOG_STYLE_INPUT, "Anahtar Al", ""wb"» "w"Anahtarýn alýnacaðý kiþinin TAM ÝSMÝNÝ yazýn:\n", "Al", "Geri");
				}
				default:
				{
					OnDialogResponse(playerid, DIALOG_ARACIM, 1, 5, "");
				}
			}
		}
	}

	if(dialogid == DIALOG_ARACIM_ANAHTAR_AL)
	{
		if(!response) return OnDialogResponse(playerid, DIALOG_ARACIM, 1, 5, "");
		if(response)
		{
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_ARACIM_ANAHTAR_AL, DIALOG_STYLE_INPUT, "Anahtar Al", ""wb"» "w"Anahtarýn alýnacaðý kiþinin TAM ÝSMÝNÝ yazýn:\n\n"r"(Bir deðer girmelisiniz!)", "Al", "Geri");
			if(!strcmp(inputtext, getName(playerid), true)) return ShowPlayerDialog(playerid, DIALOG_ARACIM_ANAHTAR_AL, DIALOG_STYLE_INPUT, "Anahtar Al", ""wb"» "w"Anahtarýn alýnacaðý kiþinin TAM ÝSMÝNÝ yazýn:\n\n"r"(Kendi anahtarýnýzý alamazsýnýz!)", "Al", "Geri");
			new sql[500];
			format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `kullaniciadi` = '%s'", inputtext);
			mysql_query(db, sql);
			if(!cache_num_rows()) return ShowPlayerDialog(playerid, DIALOG_ARACIM_ANAHTAR_AL, DIALOG_STYLE_INPUT, "Anahtar Al", ""wb"» "w"Anahtarýn alýnacaðý kiþinin TAM ÝSMÝNÝ yazýn:\n\n"r"(Böyle bir oyuncu yok!)", "Al", "Geri");
			new id = GetPlayerID(inputtext);
			if(IsPlayerConnected(id))
			{
				if(!Iter_Contains(Anahtarlar<id>, pData[playerid][pArac]))
				{
					ShowPlayerDialog(playerid, DIALOG_ARACIM_ANAHTAR_AL, DIALOG_STYLE_INPUT, "Anahtar Al", ""wb"» "w"Anahtarýn alýnacaðý kiþinin TAM ÝSMÝNÝ yazýn:\n\n"r"(Oyuncuda zaten aracýnýzýn anahtarý yok!)", "Al", "Geri");
					return true;
				}
				if(IsPlayerInAnyVehicle(id) && GetPlayerVehicleID(id) == iArac[aData[pData[playerid][pArac]][aID]])
				{
					RemovePlayerFromVehicle(id);
				}
				Iter_Remove(Anahtarlar<id>, pData[playerid][pArac]);
				format(sql, sizeof(sql), ""wb"%s "w"isimli oyuncu sizden "wb"%s "w"plakalý aracýn anahtarýný aldý.", getName(playerid), aData[pData[playerid][pArac]][aPlaka]);
				AdminBilgi(id, sql);
				format(sql, sizeof(sql), "DELETE FROM `anahtarlar` WHERE `sqlid` = '%d' AND `aracid` = '%d'", pData[id][pSQLID], pData[playerid][pArac]);
				mysql_query(db, sql);
			}
			else
			{
				new sqlX[500], sqlid;
				format(sqlX, sizeof(sqlX), "SELECT * FROM `hesaplar` WHERE `kullaniciadi` = '%s'", inputtext);
				mysql_query(db, sqlX);
				cache_get_value_name_int(0, "sqlid", sqlid);
				format(sqlX, sizeof(sqlX), "SELECT * FROM `anahtarlar` WHERE `sqlid` = '%d' AND `aracid` = '%d'", sqlid, pData[playerid][pArac]);
				mysql_query(db, sqlX);
				if(!cache_num_rows()) return ShowPlayerDialog(playerid, DIALOG_ARACIM_ANAHTAR_AL, DIALOG_STYLE_INPUT, "Anahtar Al", ""wb"» "w"Anahtarýn alýnacaðý kiþinin TAM ÝSMÝNÝ yazýn:\n\n"r"(Oyuncuda zaten aracýnýzýn anahtarý yok!)", "Al", "Geri");
				format(sqlX, sizeof(sqlX), "DELETE FROM `anahtarlar` WHERE `sqlid` = '%d' AND `aracid` = '%d'", sqlid, pData[playerid][pArac]);
				mysql_query(db, sqlX);
			}
			AdminBilgi(playerid, "Oyuncunun anahtarýný baþarýyla aldýnýz.");
		}
	}

	if(dialogid == DIALOG_ARACIM_ANAHTAR_VER)
	{
		if(!response) return OnDialogResponse(playerid, DIALOG_ARACIM, 1, 5, "");
		if(response)
		{
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_ARACIM_ANAHTAR_VER, DIALOG_STYLE_INPUT, "Anahtar Ver", ""wb"» "w"Anahtar verilecek kiþinin TAM ÝSMÝNÝ yazýn:\n\n"r"(Bir deðer girmelisiniz!)", "Ver", "Geri");
			if(!strcmp(inputtext, getName(playerid), true)) return ShowPlayerDialog(playerid, DIALOG_ARACIM_ANAHTAR_VER, DIALOG_STYLE_INPUT, "Anahtar Ver", ""wb"» "w"Anahtar verilecek kiþinin TAM ÝSMÝNÝ yazýn:\n\n"r"(Kendinize anahtar veremezsiniz!)", "Ver", "Geri");
			new sql[500];
			format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `kullaniciadi` = '%s'", inputtext);
			mysql_query(db, sql);
			if(!cache_num_rows()) return ShowPlayerDialog(playerid, DIALOG_ARACIM_ANAHTAR_VER, DIALOG_STYLE_INPUT, "Anahtar Ver", ""wb"» "w"Anahtar verilecek kiþinin TAM ÝSMÝNÝ yazýn:\n\n"r"(Böyle bir oyuncu yok!)", "Ver", "Geri");
			new id = GetPlayerID(inputtext);
			if(IsPlayerConnected(id))
			{
				Iter_Add(Anahtarlar<id>, pData[playerid][pArac]);
				format(sql, sizeof(sql), ""wb"%s "w"isimli oyuncu size "wb"%s "w"plakalý aracýn anahtarýný verdi!", getName(playerid), aData[pData[playerid][pArac]][aPlaka]);
				AdminBilgi(id, sql);
				format(sql, sizeof(sql), "INSERT INTO `anahtarlar` (`sqlid`, `aracid`) VALUES ('%d', '%d')", pData[id][pSQLID], pData[playerid][pArac]);
				mysql_query(db, sql);
			}
			else
			{
				new sqlX[500], sqlid;
				format(sqlX, sizeof(sqlX), "SELECT * FROM `hesaplar` WHERE `kullaniciadi` = '%s'", inputtext);
				mysql_query(db, sqlX);
				cache_get_value_name_int(0, "sqlid", sqlid);
				format(sqlX, sizeof(sqlX), "INSERT INTO `anahtarlar` (`sqlid`, `aracid`) VALUES ('%d', '%d')", sqlid, pData[playerid][pArac]);
				mysql_query(db, sqlX);
			}
			AdminBilgi(playerid, "Oyuncuya baþarýyla anahtar verdiniz.");
		}
	}

	if(dialogid == DIALOG_RENKLER)
	{
		if(!response) return true;
		if(response)
		{
			if(GetPlayerMoney(playerid) < 100) return Hata(playerid, "Renk alabilmek için 100 TL niz olmalýdýr!");
			SetPlayerColor(playerid, Oyuncu_Renkleri[listitem]);
			GivePlayerMoney(playerid, -100);
			new str[200];
			format(str, sizeof(str), "Baþarýyla {%06x}bu rengi "w"satýn aldýnýz.", Oyuncu_Renkleri[listitem] >>> 8);
			Bilgi(playerid, str);
		}
	}

	if(dialogid == DIALOG_SPAWNSILAHLARI)
	{
		if(!response) return true;
		if(response)
		{
			if(listitem == 6)
			{
				for(new i; i < 6; i++)
				{
					pData[playerid][pSilahlar][i] = -1;
				}
				AdminBilgi(playerid, "Silah seçimleri sýfýrlandý.");
			}
			else
			{
				new dia[1024];
				strcat(dia, ""wb"» "w"Silah ID\t"wb"» "w"Silah Ýsim\n");
				SetPVarInt(playerid, "spawnsilah_slot", listitem);
				for(new i = 0; i < sizeof(Silahlar); i++)
				{
					format(dia, sizeof(dia), "%s"wb"» "w"%d\t"wb"» "w"%s\n", dia, Silahlar[i][sID], GetWeaponNameEx(Silahlar[i][sID]));
				}
				ShowPlayerDialog(playerid, DIALOG_SPAWNSILAHLARI_SEC, DIALOG_STYLE_TABLIST_HEADERS, "Spawn Silahlarý - Seç", dia, "Seç", "Geri");
			}
		}
	}

	if(dialogid == DIALOG_SPAWNSILAHLARI_SEC)
	{
		if(!response) return PC_EmulateCommand(playerid, "/spawnsilahlari");
		if(response)
		{
			new slot = GetPVarInt(playerid, "spawnsilah_slot"), str[512];
			for(new i; i < 6; i++)
			{
				if(GetWeaponSlot(pData[playerid][pSilahlar][i]) == GetWeaponSlot(Silahlar[listitem][sID]))
				{
					format(str, sizeof(str), ""wb"%s "w"silahý seçiliyken bu silahý alamazsýnýz.", GetWeaponNameEx(pData[playerid][pSilahlar][i]));
					return AdminBilgi(playerid, str);
				}
			}
			pData[playerid][pSilahlar][slot] = Silahlar[listitem][sID];
			format(str, sizeof(str), ""wb"%d "w"slotlu spawn silahý "wb"%s "w"olarak seçildi!", slot + 1, GetWeaponNameEx(Silahlar[listitem][sID]));
			AdminBilgi(playerid, str);
			OyuncuKaydet(playerid);
			PC_EmulateCommand(playerid, "/spawnsilahlari");
		}
	}

	if(dialogid == DIALOG_ARACIM_BENZIN)
	{
		if(!response) return PC_EmulateCommand(playerid, "/a");
		if(response)
		{
			if(GetPVarInt(playerid, "BenzinCP") == 1) DisablePlayerCheckpoint(playerid), SetPVarInt(playerid, "BenzinCP", 0);
			new en_yakin, Float: enson = 99999999999;
			for(new i = 0; i < sizeof(Benzinlikler); i++)
			{
				if(GetPlayerDistanceFromPoint(playerid, Benzinlikler[i][0], Benzinlikler[i][1], Benzinlikler[i][2]) < enson)
				{
					enson = GetPlayerDistanceFromPoint(playerid, Benzinlikler[i][0], Benzinlikler[i][1], Benzinlikler[i][2]);
					en_yakin = i;
				}
			}
			SetPlayerCheckpoint(playerid, Benzinlikler[en_yakin][0], Benzinlikler[en_yakin][1], Benzinlikler[en_yakin][2], 10.0);
			SetPVarInt(playerid, "BenzinCP", 1);
			AdminBilgi(playerid, "En yakýn benzinlik haritanýzda iþaretlendi.");
		}
	}

	if(dialogid == DIALOG_BANKA)
	{
		if(!response) return true;
		if(response)
		{
			if(pData[playerid][pBankaHesap] == -1)
			{
				if(GetPlayerMoney(playerid) < 1000) return Hata(playerid, "Banka hesabý oluþturmanýz için "wb"1.000 TL "w"gerekli!");
				ShowPlayerDialog(playerid, DIALOG_BANKA_OLUSTUR, DIALOG_STYLE_PASSWORD, "Banka Hesabý Oluþtur", ""wb"» "w"Banka hesabýnýz için "wb"þifre "w"belirleyin:\n", "Belirle", "Iptal");
			}
			else
			{
				switch(listitem)
				{
					case 0:
					{
						ShowPlayerDialog(playerid, DIALOG_BANKA_GIRIS, DIALOG_STYLE_PASSWORD, "Banka Hesabým - Giriþ", ""wb"» "w"Hesabýnýza eriþim için lütfen "wb"þifrenizi "w"girin:\n", "Giriþ", "Iptal");
					}
				}
			}
		}
	}

	if(dialogid == DIALOG_BANKA_GIRIS)
	{
		if(!response) return PC_EmulateCommand(playerid, "/hesabim");
		if(response)
		{
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANKA_GIRIS, DIALOG_STYLE_PASSWORD, "Banka Hesabým - Giriþ", ""wb"» "w"Hesabýnýza eriþim için lütfen þifrenizi girin:\n\n"r"(Bir deðer girmelisiniz!)", "Giriþ", "Iptal");
			if(strlen(inputtext) < 3 || strlen(inputtext) > 20) return ShowPlayerDialog(playerid, DIALOG_BANKA_GIRIS, DIALOG_STYLE_PASSWORD, "Banka Hesabým - Giriþ", ""wb"» "w"Hesabýnýza eriþim için lütfen þifrenizi girin:\n\n"r"(Þifre en az 3, en fazla 20 karakter olabilir!)", "Giriþ", "Iptal");
			if(strcmp(inputtext, bData[pData[playerid][pBankaHesap]][bSifre])) return ShowPlayerDialog(playerid, DIALOG_BANKA_GIRIS, DIALOG_STYLE_PASSWORD, "Banka Hesabým - Giriþ", ""wb"» "w"Hesabýnýza eriþim için lütfen þifrenizi girin:\n\n"r"(Yanlýþ þifre giriþi yaptýnýz!)", "Giriþ", "Iptal");

			BankaAnaSayfa(playerid);
		}
	}

	if(dialogid == DIALOG_BANKA_YONETIM)
	{
		if(!response) return true;
		if(response)
		{
			switch(listitem)
			{
				case 0..5:
				{
					BankaAnaSayfa(playerid);
				}
				case 6:
				{
					ShowPlayerDialog(playerid, DIALOG_BANKA_TRANSFER, DIALOG_STYLE_INPUT, "Banka - Para Transferi (1/2)", ""wb"» "w"Para transfer etmek istediðiniz hesap ID'sini girin:\n", "Ileri", "Geri");
				}
				case 7:
				{
					ShowPlayerDialog(playerid, DIALOG_BANKA_PARAYATIR, DIALOG_STYLE_INPUT, "Banka - Para YATIR", ""wb"» "w"Yatýrmak istediðiniz miktarý giriniz:\n", "Yatýr", "Geri");
				}
				case 8:
				{
					new str[1024];
					format(str, sizeof(str), "\
						"wb">> "w"Hesabýnýzdaki Para: "wb"%s TL\n\n\
						"w"Çekmek istediðiniz miktarý aþaðýya giriniz:\n", FormatMoney(bData[pData[playerid][pBankaHesap]][bBakiye]));
					ShowPlayerDialog(playerid, DIALOG_BANKA_PARACEK, DIALOG_STYLE_INPUT, "Banka - Para Çek", str, "Çek", "Geri");
				}
			}
		}
	}

	if(dialogid == DIALOG_BANKA_PARACEK)
	{
		if(!response) return BankaAnaSayfa(playerid);
		if(response)
		{
			if(!strlen(inputtext))
			{
				new str[1024];
				format(str, sizeof(str), "\
					"wb">> "w"Hesabýnýzdaki Para: "wb"%s TL\n\n\
					"w"Çekmek istediðiniz miktarý aþaðýya giriniz:\n\n\
					"r"(Bir deðer girmelisiniz!)", FormatMoney(bData[pData[playerid][pBankaHesap]][bBakiye]));
				return ShowPlayerDialog(playerid, DIALOG_BANKA_PARACEK, DIALOG_STYLE_INPUT, "Banka - Para Çek", str, "Çek", "Geri");
			}
			if(!IsNumeric(inputtext))
			{
				new str[1024];
				format(str, sizeof(str), "\
					"wb">> "w"Hesabýnýzdaki Para: "wb"%s TL\n\n\
					"w"Çekmek istediðiniz miktarý aþaðýya giriniz:\n\n\
					"r"(Sayýsal bir deðer girmelisiniz!)", FormatMoney(bData[pData[playerid][pBankaHesap]][bBakiye]));
				return ShowPlayerDialog(playerid, DIALOG_BANKA_PARACEK, DIALOG_STYLE_INPUT, "Banka - Para Çek", str, "Çek", "Geri");
			}
			if(strval(inputtext) <= 0 || strval(inputtext) > 10000)
			{
				new str[1024];
				format(str, sizeof(str), "\
					"wb">> "w"Hesabýnýzdaki Para: "wb"%s TL\n\n\
					"w"Çekmek istediðiniz miktarý aþaðýya giriniz:\n\n\
					"r"(Tek seferde en az 1, en fazla 10.000 TL çekebilirsiniz!)", FormatMoney(bData[pData[playerid][pBankaHesap]][bBakiye]));
				return ShowPlayerDialog(playerid, DIALOG_BANKA_PARACEK, DIALOG_STYLE_INPUT, "Banka - Para Çek", str, "Çek", "Geri");
			}
			if(bData[pData[playerid][pBankaHesap]][bBakiye] < strval(inputtext))
			{
				new str[1024];
				format(str, sizeof(str), "\
					"wb">> "w"Hesabýnýzdaki Para: "wb"%s TL\n\n\
					"w"Çekmek istediðiniz miktarý aþaðýya giriniz:\n\n\
					"r"(Banka hesabýnýzda yeterli para yok!)", FormatMoney(bData[pData[playerid][pBankaHesap]][bBakiye]));
				return ShowPlayerDialog(playerid, DIALOG_BANKA_PARACEK, DIALOG_STYLE_INPUT, "Banka - Para Çek", str, "Çek", "Geri");
			}

			bData[pData[playerid][pBankaHesap]][bBakiye] -= strval(inputtext);
			GivePlayerMoney(playerid, strval(inputtext));

			AdminBilgi(playerid, "Para çekim iþlemi baþarýlý!");
		}
	}

	if(dialogid == DIALOG_BANKA_PARAYATIR)
	{
		if(!response) return BankaAnaSayfa(playerid);
		if(response)
		{
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANKA_PARAYATIR, DIALOG_STYLE_INPUT, "Banka - Para YATIR", ""wb"» "w"Yatýrmak istediðiniz miktarý giriniz:\n\n"r"(Bir deðer girmelisiniz!)", "Yatýr", "Geri");
			if(!IsNumeric(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANKA_PARAYATIR, DIALOG_STYLE_INPUT, "Banka - Para YATIR", ""wb"» "w"Yatýrmak istediðiniz miktarý giriniz:\n\n"r"(Sayýsal bir deðer girmelisiniz!)", "Yatýr", "Geri");
			if(strval(inputtext) <= 0 || strval(inputtext) > 10000) return ShowPlayerDialog(playerid, DIALOG_BANKA_PARAYATIR, DIALOG_STYLE_INPUT, "Banka - Para YATIR", ""wb"» "w"Yatýrmak istediðiniz miktarý giriniz:\n\n"r"(Tek seferde en az 1 TL, en fazla 10.000 TL yükleyebilirsiniz!)", "Yatýr", "Geri");
			if(GetPlayerMoney(playerid) < strval(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANKA_PARAYATIR, DIALOG_STYLE_INPUT, "Banka - Para YATIR", ""wb"» "w"Yatýrmak istediðiniz miktarý giriniz:\n\n"r"(Yeterli paranýz yok!)", "Yatýr", "Geri");

			new id = pData[playerid][pBankaHesap];
			bData[id][bBakiye] += strval(inputtext);
			GivePlayerMoney(playerid, -strval(inputtext));

			AdminBilgi(playerid, "Para yatýrma iþlemi baþarýlý!");
		}
	}

	if(dialogid == DIALOG_BANKA_TRANSFER)
	{
		if(!response)
		{
			return BankaAnaSayfa(playerid);
		}
		if(response)
		{
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANKA_TRANSFER, DIALOG_STYLE_INPUT, "Banka - Para Transferi (1/2)", ""wb"» "w"Para transfer etmek istediðiniz hesap ID'sini girin:\n\n"r"(Bir deðer girmelisiniz!)", "Ileri", "Geri");
			if(!IsNumeric(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANKA_TRANSFER, DIALOG_STYLE_INPUT, "Banka - Para Transferi (1/2)", ""wb"» "w"Para transfer etmek istediðiniz hesap ID'sini girin:\n\n"r"(Sayýsal bir deðer girmelisiniz!)", "Ileri", "Geri");
			new str[512];
			format(str, sizeof(str), ""wb"» "w"Para transfer etmek istediðiniz hesap ID'sini girin:\n\n"r"(Böyle bir banka hesabý yok!)");
			if(!Iter_Contains(bankahesaplari, strval(inputtext))) return ShowPlayerDialog(playerid, DIALOG_BANKA_TRANSFER, DIALOG_STYLE_INPUT, "Banka - Para Transferi (1/2)", str, "Ileri", "Geri");
			if(pData[playerid][pBankaHesap] == strval(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANKA_TRANSFER, DIALOG_STYLE_INPUT, "Banka - Para Transferi (1/2)", ""wb"» "w"Para transfer etmek istediðiniz hesap ID'sini girin:\n\n"r"(Kendi hesabýnýza transfer yapamazsýnýz!)", "Ileri", "Geri");
			SetPVarInt(playerid, "hesap_id", strval(inputtext));
			ShowPlayerDialog(playerid, DIALOG_BANKA_TRANSFER_2, DIALOG_STYLE_INPUT, "Banka - Para Transferi (2/2)", ""wb"» "w"Kaç TL göndereceðinizi giriniz:\n", "Gönder", "Geri");
		}
	}

	if(dialogid == DIALOG_BANKA_TRANSFER_2)
	{
		if(!response)
		{
			ShowPlayerDialog(playerid, DIALOG_BANKA_TRANSFER, DIALOG_STYLE_INPUT, "Banka - Para Transferi (1/2)", ""wb"» "w"Para transfer etmek istediðiniz hesap ID'sini girin:\n", "Ileri", "Geri");
		}
		if(response)
		{
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANKA_TRANSFER_2, DIALOG_STYLE_INPUT, "Banka - Para Transferi (2/2)", ""wb"» "w"Kaç TL göndereceðinizi giriniz:\n\n"r"(Bir deðer girmelisiniz!)", "Gönder", "Geri");
			if(!IsNumeric(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANKA_TRANSFER_2, DIALOG_STYLE_INPUT, "Banka - Para Transferi (2/2)", ""wb"» "w"Kaç TL göndereceðinizi giriniz:\n\n"r"(Sayýsal bir deðer girmelisiniz!)", "Gönder", "Geri");
			if(strval(inputtext) <= 0 || strval(inputtext) > 10000) return ShowPlayerDialog(playerid, DIALOG_BANKA_TRANSFER_2, DIALOG_STYLE_INPUT, "Banka - Para Transferi (2/2)", ""wb"» "w"Kaç TL göndereceðinizi giriniz:\n\n"r"(En az 1 TL, en fazla 10.000TL gönderebilirsiniz!)", "Gönder", "Geri");
			if(bData[pData[playerid][pBankaHesap]][bBakiye] < strval(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANKA_TRANSFER_2, DIALOG_STYLE_INPUT, "Banka - Para Transferi (2/2)", ""wb"» "w"Kaç TL göndereceðinizi giriniz:\n\n"r"(Banka hesabýnýzda yeterli bakiye yok!)", "Gönder", "Geri");

			new id = GetPVarInt(playerid, "hesap_id"), id2 = pData[playerid][pBankaHesap], sql[500];
			bData[id2][bBakiye] -= strval(inputtext);
			bData[id][bBakiye] += strval(inputtext);

			format(sql, sizeof(sql), "UPDATE `banka_hesaplari` SET `bakiye` = '%d' WHERE `id` = '%d'", bData[id2][bBakiye], id2);
			mysql_query(db, sql);
			format(sql, sizeof(sql), "UPDATE `banka_hesaplari` SET `bakiye` = '%d' WHERE `id` = '%d'", bData[id][bBakiye], id);
			mysql_query(db, sql);

			new id3 = GetPlayerID(SQL_Isim_Cek(bData[id][bSahip]));
			if(IsPlayerConnected(id3))
			{
				AdminBilgi(id3, "Banka hesabýnýza para transferi yapýldý!");
			}

			AdminBilgi(playerid, "Transfer baþarýyla gerçekleþti!");
		}
	}

	if(dialogid == DIALOG_BANKA_OLUSTUR)
	{
		if(!response) return PC_EmulateCommand(playerid, "/hesabim");
		if(response)
		{
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANKA_OLUSTUR, DIALOG_STYLE_PASSWORD, "Banka Hesabý Oluþtur", ""wb"» "w"Banka hesabýnýz için "wb"þifre "w"belirleyin:\n\n"r"(Bir deðer girmelisiniz!)", "Belirle", "Iptal");
			if(strlen(inputtext) < 3 || strlen(inputtext) > 20) return ShowPlayerDialog(playerid, DIALOG_BANKA_OLUSTUR, DIALOG_STYLE_PASSWORD, "Banka Hesabý Oluþtur", ""wb"» "w"Banka hesabýnýz için "wb"þifre "w"belirleyin:\n\n"r"(Þifre en az 3, en fazla 20 karakter olabilir!)", "Belirle", "Iptal");

			new sql[500], id = Iter_Free(bankahesaplari);
			if(id == -1) return Hata(playerid, "Banka hesaplarý sýnýrý dolmuþ! (100)");
			format(sql, sizeof(sql), "INSERT INTO `banka_hesaplari` (`id`, `sahip`, `bakiye`, `sifre`, `olusturulma`) VALUES ('%d', '%d', '0', '%s', '%s')", 
				id, pData[playerid][pSQLID], inputtext, convertDate(gettime()));
			mysql_query(db, sql);
			Iter_Add(bankahesaplari, id);
			pData[playerid][pBankaHesap] = id;
			bData[id][bId] = id;
			bData[id][bSahip] = pData[playerid][pSQLID];
			bData[id][bBakiye] = 0;
			format(bData[id][bSifre], 100, "%s", inputtext);
			format(bData[id][bOlusturma], 100, "%s", convertDate(gettime()));

			AdminBilgi(playerid, "Banka hesabýnýz baþarýyla oluþturuldu! Artýk giriþ yapabilirsiniz.");
			GivePlayerMoney(playerid, -1000);
			OyuncuKaydet(playerid);
		}
	}

	if(dialogid == DIALOG_KLANLAR)
	{
		if(!response) return true;
		if(response)
		{
			if(listitem == 11)
			{
				new sql[500], isim[50], tag[10], level, renk, str[10000], baslik[150];
				format(sql, sizeof(sql), "SELECT * FROM `klanlar` ORDER BY `level` DESC LIMIT %d, 10", GetPVarInt(playerid, "klanlar_sayfa"));
				mysql_query(db, sql);

				strcat(str, "{A9A9A9}Klan Ýsmi\t{A9A9A9}Klan Seviyesi\t{A9A9A9}Klan Üye Sayýsý\t{A9A9A9}Klan Giriþ Tipi\n");

				SetPVarInt(playerid, "klanlar_sayfa", GetPVarInt(playerid, "klanlar_sayfa") + 10);
				for(new i; i < 500; i++) KlanlarListe[playerid][i] = -1;

				for(new i; i < 10; i++)
				{
					if(i < cache_num_rows())
					{
						cache_get_value_name_int(i, "id", KlanlarListe[playerid][i]);
						cache_get_value_name(i, "isim", isim, 50);
						cache_get_value_name(i, "tag", tag, 10);
						cache_get_value_name_int(i, "level", level);
						cache_get_value_name_int(i, "renk", renk);
						format(str, sizeof(str), "%s{%06x}[%s] %s\t{%06x}- {FFFFFF}%d {%06x}-\t{%06x} - {FFFFFF}%02d/%d {%06x}-\t{%06x} - {FFFFFF}Herkese Açýk {%06x}-\n", 
							str, KlanRenkleri[renk] >>> 8, tag, isim, KlanRenkleri[renk] >>> 8, level, KlanRenkleri[renk] >>> 8, KlanRenkleri[renk] >>> 8, KlanUyeSayisi(KlanlarListe[playerid][i]), level * 10, KlanRenkleri[renk] >>> 8, KlanRenkleri[renk] >>> 8, KlanRenkleri[renk] >>> 8);
						format(sql, sizeof(sql), "SELECT * FROM `klanlar` ORDER BY `level` DESC LIMIT %d, 10", GetPVarInt(playerid, "klanlar_sayfa"));
						mysql_query(db, sql);
					}
					else
					{
						format(str, sizeof(str), "%s{A9A9A9}-----------------------------\t{A9A9A9}--------\t{A9A9A9}---------------\t{A9A9A9}-------------------------\n", str);
					}
				}

				mysql_query(db, "SELECT * FROM `klanlar`");
				new fstr[50];
				if(cache_num_rows() % 10 != 0)
				{
					format(fstr, sizeof(fstr), "%d.%d", cache_num_rows() / 10, cache_num_rows() % 10);
				}
				else
				{
					format(fstr, sizeof(fstr), "%d", cache_num_rows() / 10);
				}
				new toplamSyf = floatround(floatstr(fstr), floatround_ceil);
				format(baslik, sizeof(baslik), "Klanlar - (%d/%d)", GetPVarInt(playerid, "klanlar_sayfa") / 10, toplamSyf);
				if(cache_num_rows() > GetPVarInt(playerid, "klanlar_sayfa"))
				{
					strcat(str, "{A9A9A9}====================\t{A9A9A9}========\t{A9A9A9}===\t{A9A9A9}=================================\n");
					format(fstr, sizeof(fstr), "{A9A9A9}>> Sonraki Sayfa\t \t \t{A9A9A9}(%d/%d)\n", GetPVarInt(playerid, "klanlar_sayfa") / 10, toplamSyf);
					strcat(str, fstr);
					strcat(str, "{A9A9A9}====================\t{A9A9A9}========\t{A9A9A9}===\t{A9A9A9}=================================");
				}

				ShowPlayerDialog(playerid, DIALOG_KLANLAR, DIALOG_STYLE_TABLIST_HEADERS, baslik, str, "Baþvuru Yap", "Kapat");
			}
			else if(listitem == 10) return PC_EmulateCommand(playerid, "/klanlar");
			else if(listitem == 12) return PC_EmulateCommand(playerid, "/klanlar");
			else
			{
				if(pData[playerid][pKlan] != -1) return Hata(playerid, "Bir klandayken baþka bir klana baþvuru yapamazsýnýz!");
				if(KlanlarListe[playerid][listitem] == -1) return PC_EmulateCommand(playerid, "/klanlar");

				new id = KlanlarListe[playerid][listitem], str[500], str2[2048], sql[256], lider[50];

				format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `klan` = '%d' AND `klanrutbe` = '3'", id);
				mysql_query(db, sql);

				if(cache_num_rows() > 0)
				{
					cache_get_value_name(0, "kullaniciadi", lider, 50);
				}
				else
				{
					lider = "Yok";
				}

				format(str, sizeof(str), ""wb"» "w"{%06x}[%s] - %s "w"klanýna baþvuru yapmak istiyor musunuz?\n\n", KlanRenkleri[kData[id][kRenk]] >>> 8, kData[id][kTag], kData[id][kIsim]);
				strcat(str2, str);
				format(str, sizeof(str), ""wb"» "w"Isim: "wb"%s\n", kData[id][kIsim]);
				strcat(str2, str);
				format(str, sizeof(str), ""wb"» "w"Tag: "wb"%s\n", kData[id][kTag]);
				strcat(str2, str);
				format(str, sizeof(str), ""wb"» "w"Üyeler: "wb"%02d"w"/"wb"%d\n", KlanUyeSayisi(id), kData[id][kLevel] * 10);
				strcat(str2, str);
				format(str, sizeof(str), ""wb"» "w"Level: "wb"%03d\n", kData[id][kLevel]);
				strcat(str2, str);
				format(str, sizeof(str), ""wb"» "w"Lider: "wb"%s\n", lider);
				strcat(str2, str);
				format(str, sizeof(str), ""wb"» "w"Renk: {%06x}Renk Önizleme\n", KlanRenkleri[kData[id][kRenk]] >>> 8);
				strcat(str2, str);
				format(str, sizeof(str), ""wb"» "w"Kuruluþ Tarihi: "wb"%s\n", kData[id][kKurulus_Tarihi]);
				strcat(str2, str);

				SetPVarInt(playerid, "klan_basvuru", id);

				ShowPlayerDialog(playerid, DIALOG_KLAN_BASVURU, DIALOG_STYLE_MSGBOX, "Klan Baþvurusu", str2, ""ad"Evet", ""r"Hayýr");
			}
		}
	}

	if(dialogid == DIALOG_LOTTO)
	{
		if(!response) return true;
		if(response)
		{
			if(lData[lAktif] != true) return Hata(playerid, "Aktif bir lotto yok!");
			if(LottoSayisi[playerid] != -1) return Hata(playerid, "Zaten bir lotto bileti almýþsýnýz!");
			foreach(new i: Player)
			{
				if(LottoSayisi[i] == listitem) return Hata(playerid, "Bu sayý baþkasý tarafýndan alýnmýþ!");
			}
			LottoSayisi[playerid] = listitem;
			new str[500];
			format(str, sizeof(str), ""wb"%d "w"sayýlý bileti satýn aldýnýz! Þansýnýz bol olsun.", listitem);
			AdminBilgi(playerid, str);
		}
	}

	if(dialogid == DIALOG_KLAN_BILGILER) if(!response || response) return PC_EmulateCommand(playerid, "/klan");

	if(dialogid == DIALOG_KLAN_YATIR)
	{
		if(!response) return PC_EmulateCommand(playerid, "/klan");
		if(response)
		{
			if(!strlen(inputtext))
			{
				new dialog[500], id = pData[playerid][pKlan];
				format(dialog, sizeof(dialog), ""wb"» "w"Klan Bankasý: "wb"%s TL\n\n"w"Lütfen yatýrmak istediðiniz para miktarýný aþaðýya giriniz:\n\n"r"Bir deðer girmelisiniz.\n", FormatMoney(kData[id][kKasa]));
				return ShowPlayerDialog(playerid, DIALOG_KLAN_YATIR, DIALOG_STYLE_INPUT, KlanBaslik(id), dialog, "Yatýr", "Ýptal");
			}
			if(!IsNumeric(inputtext))
			{
				new dialog[500], id = pData[playerid][pKlan];
				format(dialog, sizeof(dialog), ""wb"» "w"Klan Bankasý: "wb"%s TL\n\n"w"Lütfen yatýrmak istediðiniz para miktarýný aþaðýya giriniz:\n\n"r"Sayýsal bir deðer girmelisiniz.\n", FormatMoney(kData[id][kKasa]));
				return ShowPlayerDialog(playerid, DIALOG_KLAN_YATIR, DIALOG_STYLE_INPUT, KlanBaslik(id), dialog, "Yatýr", "Ýptal");
			}
			if(strval(inputtext) > 1000000 || strval(inputtext) <= 0)
			{
				new dialog[500], id = pData[playerid][pKlan];
				format(dialog, sizeof(dialog), ""wb"» "w"Klan Bankasý: "wb"%s TL\n\n"w"Lütfen yatýrmak istediðiniz para miktarýný aþaðýya giriniz:\n\n"r"Tek seferde en az 1 TL, en fazla 1.000.000 TL yatýrabilirsiniz.\n", FormatMoney(kData[id][kKasa]));
				return ShowPlayerDialog(playerid, DIALOG_KLAN_YATIR, DIALOG_STYLE_INPUT, KlanBaslik(id), dialog, "Yatýr", "Ýptal");
			}
			if(GetPlayerMoney(playerid) < strval(inputtext))
			{
				new dialog[500], id = pData[playerid][pKlan];
				format(dialog, sizeof(dialog), ""wb"» "w"Klan Bankasý: "wb"%s TL\n\n"w"Lütfen yatýrmak istediðiniz para miktarýný aþaðýya giriniz:\n\n"r"Yatýrmak istediðiniz kadar paranýz yok.\n", FormatMoney(kData[id][kKasa]));
				return ShowPlayerDialog(playerid, DIALOG_KLAN_YATIR, DIALOG_STYLE_INPUT, KlanBaslik(id), dialog, "Yatýr", "Ýptal");
			}

			new deger = strval(inputtext), sql[500];
			GivePlayerMoney(playerid, -deger);
			kData[pData[playerid][pKlan]][kKasa] += deger;
			format(sql, sizeof(sql), "UPDATE `klanlar` SET `kasa` = '%d' WHERE `id` = '%d'", kData[pData[playerid][pKlan]][kKasa], pData[playerid][pKlan]);
			mysql_query(db, sql);
			AdminBilgi(playerid, "Para yatýrýmý baþarýlý!");
			PC_EmulateCommand(playerid, "/klan");
		}
	}

	if(dialogid == DIALOG_KLAN_YATIR_EXP)
	{
		if(!response) return PC_EmulateCommand(playerid, "/klan");
		if(response)
		{
			if(!strlen(inputtext))
			{
				new dialog[500], id = pData[playerid][pKlan];
				format(dialog, sizeof(dialog), ""wb"» "w"Klan Leveli: "wb"%d\n"wb"» "w"Klan EXP'i: "wb"%d"w"/"wb"%d\n\n"w"Lütfen yatýrmak istediðiniz EXP miktarýný aþaðýya giriniz:\n\n"r"Bir deðer girmelisiniz.\n", kData[id][kLevel], kData[id][kExp], kData[id][kMaxExp]);
				return ShowPlayerDialog(playerid, DIALOG_KLAN_YATIR_EXP, DIALOG_STYLE_INPUT, KlanBaslik(id), dialog, "Yatýr", "Ýptal");
			}
			if(!IsNumeric(inputtext))
			{
				new dialog[500], id = pData[playerid][pKlan];
				format(dialog, sizeof(dialog), ""wb"» "w"Klan Leveli: "wb"%d\n"wb"» "w"Klan EXP'i: "wb"%d"w"/"wb"%d\n\n"w"Lütfen yatýrmak istediðiniz EXP miktarýný aþaðýya giriniz:\n\n"r"Sayýsal bir deðer girmelisiniz.\n", kData[id][kLevel], kData[id][kExp], kData[id][kMaxExp]);
				return ShowPlayerDialog(playerid, DIALOG_KLAN_YATIR_EXP, DIALOG_STYLE_INPUT, KlanBaslik(id), dialog, "Yatýr", "Ýptal");
			}
			if(strval(inputtext) > 250 || strval(inputtext) <= 0)
			{
				new dialog[500], id = pData[playerid][pKlan];
				format(dialog, sizeof(dialog), ""wb"» "w"Klan Leveli: "wb"%d\n"wb"» "w"Klan EXP'i: "wb"%d"w"/"wb"%d\n\n"w"Lütfen yatýrmak istediðiniz EXP miktarýný aþaðýya giriniz:\n\n"r"Tek seferde en az 1 EXP, en fazla 250 EXP yatýrabilirsiniz.\n", kData[id][kLevel], kData[id][kExp], kData[id][kMaxExp]);
				return ShowPlayerDialog(playerid, DIALOG_KLAN_YATIR_EXP, DIALOG_STYLE_INPUT, KlanBaslik(id), dialog, "Yatýr", "Ýptal");
			}
			if(pData[playerid][pExp] < strval(inputtext))
			{
				new dialog[500], id = pData[playerid][pKlan];
				format(dialog, sizeof(dialog), ""wb"» "w"Klan Leveli: "wb"%d\n"wb"» "w"Klan EXP'i: "wb"%d"w"/"wb"%d\n\n"w"Lütfen yatýrmak istediðiniz EXP miktarýný aþaðýya giriniz:\n\n"r"Yatýrmak istediðiniz kadar EXP'iniz yok.\n", kData[id][kLevel], kData[id][kExp], kData[id][kMaxExp]);
				return ShowPlayerDialog(playerid, DIALOG_KLAN_YATIR_EXP, DIALOG_STYLE_INPUT, KlanBaslik(id), dialog, "Yatýr", "Ýptal");
			}

			new deger = strval(inputtext), sql[500];
			pData[playerid][pExp] -= deger;
			kData[pData[playerid][pKlan]][kExp] += deger;
			if(kData[pData[playerid][pKlan]][kExp] >= kData[pData[playerid][pKlan]][kMaxExp])
			{
				kData[pData[playerid][pKlan]][kLevel]++;
				kData[pData[playerid][pKlan]][kExp] -= kData[pData[playerid][pKlan]][kMaxExp];
				kData[pData[playerid][pKlan]][kMaxExp] = kData[pData[playerid][pKlan]][kLevel] * 1000;
				new str_[512];
				format(str_, sizeof(str_), ""w"Klananýz level atladý! Yeni level: "wb"%d", kData[pData[playerid][pKlan]][kLevel]);
				KlanMesaji(pData[playerid][pKlan], str_);
			}
			format(sql, sizeof(sql), "UPDATE `klanlar` SET `exp` = '%d', `maxexp` = '%d', `level` = '%d' WHERE `id` = '%d'", kData[pData[playerid][pKlan]][kExp], kData[pData[playerid][pKlan]][kMaxExp], kData[pData[playerid][pKlan]][kLevel], pData[playerid][pKlan]);
			mysql_query(db, sql);
			AdminBilgi(playerid, "EXP yatýrýmý baþarýlý!");
			PC_EmulateCommand(playerid, "/klan");
		}
	}

	if(dialogid == DIALOG_KLAN_GENEL)
	{
		if(!response) return true;
		if(response)
		{
			switch(listitem)
			{
				case 0: PC_EmulateCommand(playerid, "/klan");
				case 1: PC_EmulateCommand(playerid, "/klan");
				case 2: PC_EmulateCommand(playerid, "/klan");
				case 3: PC_EmulateCommand(playerid, "/klan");
				case 4:
				{
					new dialog[500], id = pData[playerid][pKlan];
					format(dialog, sizeof(dialog), ""wb"» "w"Klan Bankasý: "wb"%s TL\n\n"w"Lütfen yatýrmak istediðiniz para miktarýný aþaðýya giriniz:\n", FormatMoney(kData[id][kKasa]));
					ShowPlayerDialog(playerid, DIALOG_KLAN_YATIR, DIALOG_STYLE_INPUT, KlanBaslik(pData[playerid][pKlan]), dialog, "Yatýr", "Ýptal");
				}
				case 5:
				{
					new dialog[500], id = pData[playerid][pKlan];
					format(dialog, sizeof(dialog), ""wb"» "w"Klan Leveli: "wb"%d\n"wb"» "w"Klan EXP'i: "wb"%d"w"/"wb"%d\n\n"w"Lütfen yatýrmak istediðiniz EXP miktarýný aþaðýya giriniz:\n", kData[id][kLevel], kData[id][kExp], kData[id][kMaxExp]);
					ShowPlayerDialog(playerid, DIALOG_KLAN_YATIR_EXP, DIALOG_STYLE_INPUT, KlanBaslik(pData[playerid][pKlan]), dialog, "Yatýr", "Ýptal");
				}
				case 6: PC_EmulateCommand(playerid, "/klan");
				case 7:
				{
					new dialog[1000], id = pData[playerid][pKlan], lider[24], yliderler[120], sql[500], str[1000], cekk[50];
					format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `klan` = '%d' AND `klanrutbe` = '3'", id);
					mysql_query(db, sql);
					if(cache_num_rows())
					{
						cache_get_value_name(0, "kullaniciadi", lider, 24);
					}
					else
					{
						lider = "Yok";
					}

					format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `klan` = '%d' AND `klanrutbe` = '2'", id);
					mysql_query(db, sql);

					if(cache_num_rows() == 1)
					{
						cache_get_value_name(0, "kullaniciadi", yliderler, 120);
					}
					else if(cache_num_rows() > 1)
					{
						for(new i = 0; i < cache_num_rows(); i++)
						{
							cache_get_value_name(i, "kullaniciadi", cekk, 50);
							format(yliderler, sizeof(yliderler), "%s%s, ", yliderler, cekk);
						}
						new xxx = strlen(yliderler);
						yliderler[xxx - 1] = ' ';
						yliderler[xxx - 2] = ' ';
					}
					else
					{
						yliderler = "Yok";
					}

					format(str, sizeof(str), "{%06x}[%s] - %s Klaný\n\n", KlanRenkleri[kData[id][kRenk]] >>> 8, kData[id][kTag], kData[id][kIsim]);
					strcat(dialog, str);
					strcat(dialog, ""wb"» "w"Klan Lideri:\n");
					format(str, sizeof(str), "\t"wb"» "w"%s\n\n", lider);
					strcat(dialog, str);
					strcat(dialog, ""wb"» "w"Klan Yardýmcý Liderleri:\n");
					format(str, sizeof(str), "\t"wb"» "w"%s\n\n", yliderler);
					strcat(dialog, str);
					format(str, sizeof(str), ""wb"» "w"Klan Leveli: -"wb"%d"w"-\n", kData[id][kLevel]);
					strcat(dialog, str);
					format(str, sizeof(str), ""wb"» "w"Klan EXP: "wb"%d"w"/"wb"%d\n\n", kData[id][kExp], kData[id][kMaxExp]);
					strcat(dialog, str);
					format(str, sizeof(str), ""wb"» "w"Klan Üye Sayýsý: "wb"%02d"w"/"wb"%d\n", KlanUyeSayisi(id), kData[id][kLevel] * 10);
					strcat(dialog, str);
					format(str, sizeof(str), ""wb"» "w"Klan Kuruluþ Tarihi: "wb"%s\n", kData[id][kKurulus_Tarihi]);
					strcat(dialog, str);
					strcat(dialog, ""wb"» "w"Klan Giriþ Tipi: "wb"Herkese Açýk");

					ShowPlayerDialog(playerid, DIALOG_KLAN_BILGILER, DIALOG_STYLE_MSGBOX, KlanBaslik(pData[playerid][pKlan]), dialog, "Kapat", "");
				}
				case 8:
				{
					new str[1000], dialog[1000], sql[500], id = pData[playerid][pKlan], isim[24], rutbe, durum[50], sqlid;
					format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `klan` = '%d'", id);
					mysql_query(db, sql);

					strcat(dialog, ""w"#\t"w"Kullanýcý Adý\t"w"Rütbe\t"w"Durum\n");

					for(new i = 0; i < cache_num_rows(); i++)
					{
						cache_get_value_name(i, "kullaniciadi", isim, 24);
						cache_get_value_name_int(i, "sqlid", sqlid);
						KlanOyuncuDuzenleme[playerid][i] = sqlid;
						cache_get_value_name_int(i, "klanrutbe", rutbe);

						switch(IsPlayerConnected(GetPlayerID(isim)))
						{
							case 0: durum = ""r"Çevrimdýþý";
							case 1: durum = ""ad"Çevrimiçi";
						}

						format(str, sizeof(str), ""wb"»\t"w"%s\t"w"%s\t%s\n", isim, KlanRutbeleri[rutbe], durum);
						strcat(dialog, str);
					}

					ShowPlayerDialog(playerid, DIALOG_KLAN_UYELER, DIALOG_STYLE_TABLIST_HEADERS, KlanBaslik(id), dialog, "Seç", "Kapat");
				}
				case 9:
				{
					if(pData[playerid][pKlanRutbe] < 1) return Hata(playerid, "Bunun için yetkiniz yok!"), PC_EmulateCommand(playerid, "/klan");
					new sql[500], str[2048], sqlid;
					format(sql, sizeof(sql), "SELECT * FROM `klan_basvurulari` WHERE `klanid` = '%d'", pData[playerid][pKlan]);
					mysql_query(db, sql);

					if(cache_num_rows() == 0) return Hata(playerid, "Hiç baþvuru yok!"), PC_EmulateCommand(playerid, "/klan");

					strcat(str, ""w"Baþvuru Yapan\n");

					for(new i; i < cache_num_rows(); i++)
					{
						cache_get_value_name_int(i, "sqlid", sqlid);
						KlanBasvurular[playerid][i] = sqlid;
						format(str, sizeof(str), "%s"wb"» "w"%s\n", str, SQL_Isim_Cek(sqlid));
						format(sql, sizeof(sql), "SELECT * FROM `klan_basvurulari` WHERE `klanid` = '%d'", pData[playerid][pKlan]);
						mysql_query(db, sql);
					}

					ShowPlayerDialog(playerid, DIALOG_KLAN_BASVURU_SECIM, DIALOG_STYLE_TABLIST_HEADERS, "Klan Baþvurularý", str, "Kabul Et", "Geri");
				}
				case 10: PC_EmulateCommand(playerid, "/klan");
				case 11:
				{
					if(pData[playerid][pKlanRutbe] < 1) return Hata(playerid, "Bunun için yetkiniz yok!"), PC_EmulateCommand(playerid, "/klan");
					ShowPlayerDialog(playerid, DIALOG_KLAN_UYEAL, DIALOG_STYLE_INPUT, KlanBaslik(pData[playerid][pKlan]), ""wb"» "w"Klana almak istediðiniz kullanýcýnýn ID veya ismini girin:\n", "Davet Et", "Iptal");
				}
				case 12:
				{
					if(pData[playerid][pKlanRutbe] < 1) return Hata(playerid, "Bunun için yetkiniz yok!"), PC_EmulateCommand(playerid, "/klan");
					ShowPlayerDialog(playerid, DIALOG_KLAN_UYEAT, DIALOG_STYLE_INPUT, KlanBaslik(pData[playerid][pKlan]), ""wb"» "w"Klandan atmak istediðiniz kullanýcýnýn ID veya ismini girin:\n", "At", "Iptal");
				}
				case 13: PC_EmulateCommand(playerid, "/klan");
				case 14:
				{
					new str[256];
					format(str, sizeof(str), ""wb"» {%06x}[%s] - %s "w"klanýndan "ad"AYRILMAK "w"üzeresiniz.\n\n"wb"» "w"Onaylýyor musunuz?", KlanRenkleri[kData[pData[playerid][pKlan]][kRenk]] >>> 8, kData[pData[playerid][pKlan]][kTag], kData[pData[playerid][pKlan]][kIsim]);
					ShowPlayerDialog(playerid, DIALOG_KLAN_AYRIL, DIALOG_STYLE_MSGBOX, KlanBaslik(pData[playerid][pKlan]), str, ""ad"Evet", ""r"Hayýr");
				}
				case 15:
				{
					if(pData[playerid][pKlanRutbe] < 3) return Hata(playerid, "Bunun için yetkiniz yok!"), PC_EmulateCommand(playerid, "/klan");
					new str[256];
					format(str, sizeof(str), ""wb"» {%06x}[%s] - %s "w"klanýný "ad"KAPATMAK "w"üzeresiniz.\n\n"wb"» "w"Onaylýyor musunuz?", KlanRenkleri[kData[pData[playerid][pKlan]][kRenk]] >>> 8, kData[pData[playerid][pKlan]][kTag], kData[pData[playerid][pKlan]][kIsim]);
					ShowPlayerDialog(playerid, DIALOG_KLAN_KAPAT, DIALOG_STYLE_MSGBOX, KlanBaslik(pData[playerid][pKlan]), str, ""ad"Evet", ""r"Hayýr");
				}
			}
		}
	}

	if(dialogid == DIALOG_KLAN_AYRIL)
	{
		if(!response) return PC_EmulateCommand(playerid, "/klan");
		if(response)
		{
			new bul, tag[25], isim[24], str[512];
			GetPlayerName(playerid, isim, 24);
			format(tag, sizeof(tag), "%s", kData[pData[playerid][pKlan]][kTag]);
			bul = strfind(isim, tag);
			strdel(isim, bul - 1, bul + strlen(tag) + 1);
			SetPlayerName(playerid, isim);
			format(str, sizeof(str), ""wb"» "w"%s klandan ayrýldý!", getName(playerid));
			KlanMesaji(pData[playerid][pKlan], str);
			pData[playerid][pKlan] = -1;
			pData[playerid][pKlanRutbe] = 0;
			OyuncuKaydet(playerid);
			new sql[500];
			format(sql, sizeof(sql), "UPDATE `hesaplar` SET `kullaniciadi` = '%s' WHERE `sqlid` = '%d'", getName(playerid), pData[playerid][pSQLID]);
			mysql_query(db, sql);
			AdminBilgi(playerid, "Klandan baþarýyla ayrýldýnýz.");
			if(pData[playerid][pIsYeri] != -1) IsYeriLabelGuncelle(pData[playerid][pIsYeri]);
			if(pData[playerid][pEv] != -1) EvLabelGuncelle(pData[playerid][pEv]);
		}
	}

	if(dialogid == DIALOG_KLAN_KAPAT)
	{
		if(!response) return PC_EmulateCommand(playerid, "/klan");
		if(response)
		{
			KlanMesaji(pData[playerid][pKlan], ""wb"» "w"Klan, klan lideri tarafýndan kapatýldý!");
			new bul, tag[25], isim[24], sql[500], id = pData[playerid][pKlan];
			foreach(new i: Player)
			{
				if(pData[i][pKlan] == id)
				{
					GetPlayerName(i, isim, 24);
					format(tag, sizeof(tag), "%s", kData[id][kTag]);
					bul = strfind(isim, tag);
					strdel(isim, bul - 1, bul + strlen(tag) + 1);
					SetPlayerName(i, isim);
					pData[i][pKlan] = -1;
					pData[i][pKlanRutbe] = 0;
				}
			}

			format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `klan` = '%d'", id);
			mysql_query(db, sql);

			new isimxd[50], tagxd[50], bulxd, say, sqlid;
			cache_get_row_count(say);
			for(new i = 0; i < say; i++)
			{
				format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `klan` = '%d'", id);
				mysql_query(db, sql);
				cache_get_value_name(i, "kullaniciadi", isimxd, 50);
				cache_get_value_name_int(i, "sqlid", sqlid);
				format(tagxd, sizeof(tagxd), "%s", kData[id][kTag]);
				bulxd = strfind(isimxd, tagxd);
				strdel(isimxd, bulxd - 1, bulxd + strlen(tagxd) + 1);
				format(sql, sizeof(sql), "UPDATE `hesaplar` SET `kullaniciadi` = '%s' WHERE `sqlid` = '%d'", isimxd, sqlid);
				mysql_query(db, sql);
			}

			format(sql, sizeof(sql), "UPDATE `hesaplar` SET `klan` = '-1', `klanrutbe` = '0' WHERE `klan` = '%d'", id);
			mysql_query(db, sql);

			format(sql, sizeof(sql), "DELETE FROM `klanlar` WHERE `id` = '%d'", id);
			mysql_query(db, sql);

			kData[id][kID] = -1;
			format(kData[id][kIsim], 50, "");
			format(kData[id][kTag], 10, "");
			kData[id][kKasa] = 0;
			kData[id][kRenk] = -1;
			kData[id][kLevel] = 1;
			kData[id][kExp] = 0;
			kData[id][kMaxExp] = 1000;
			format(kData[id][kKurulus_Tarihi], 100, "");
			Iter_Remove(klanlar, id);

			foreach(new i: isyerleri)
			{
				IsYeriLabelGuncelle(i);
			}
			foreach(new i: evler)
			{
				EvLabelGuncelle(i);
			}

			pData[playerid][pKlan] = -1;
			pData[playerid][pKlanRutbe] = 0;
			Bilgi(playerid, "Klaný baþarýyla kapattýnýz.");
		}
	}

	if(dialogid == DIALOG_KLAN_UYEAL)
	{
		if(!response) return PC_EmulateCommand(playerid, "/klan");
		if(response)
		{
			if(KlanUyeSayisi(pData[playerid][pKlan]) > kData[pData[playerid][pKlan]][kLevel] * 10) return ShowPlayerDialog(playerid, DIALOG_KLAN_UYEAL, DIALOG_STYLE_INPUT, KlanBaslik(pData[playerid][pKlan]), ""wb"» "w"Klana almak istediðiniz kullanýcýnýn ID veya ismini girin:\n\n"r"Klanýn üye sýnýrý dolmuþ!", "Davet Et", "Iptal");
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_KLAN_UYEAL, DIALOG_STYLE_INPUT, KlanBaslik(pData[playerid][pKlan]), ""wb"» "w"Klana almak istediðiniz kullanýcýnýn ID veya ismini girin:\n\n"r"Bir deðer girmelisiniz!", "Davet Et", "Iptal");
			new id, str[500];
			if(IsNumeric(inputtext))
			{
				id = strval(inputtext);
			}
			else
			{
				id = GetPlayerID(inputtext);
			}
			if(!IsPlayerConnected(id)) return ShowPlayerDialog(playerid, DIALOG_KLAN_UYEAL, DIALOG_STYLE_INPUT, KlanBaslik(pData[playerid][pKlan]), ""wb"» "w"Klana almak atmak istediðiniz kullanýcýnýn ID veya ismini girin:\n\n"r"Oyuncu oyunda deðil!", "Davet Et", "Iptal");
			if(id == playerid) return ShowPlayerDialog(playerid, DIALOG_KLAN_UYEAL, DIALOG_STYLE_INPUT, KlanBaslik(pData[playerid][pKlan]), ""wb"» "w"Klana almak atmak istediðiniz kullanýcýnýn ID veya ismini girin:\n\n"r"Kendinizi alamazsýnýz!", "Davet Et", "Iptal");
			if(pData[id][pKlan] != -1) return ShowPlayerDialog(playerid, DIALOG_KLAN_UYEAL, DIALOG_STYLE_INPUT, KlanBaslik(pData[playerid][pKlan]), ""wb"» "w"Klana almak istediðiniz kullanýcýnýn ID veya ismini girin:\n\n"r"Oyuncu baþka bir klanda!", "Davet Et", "Iptal");
			SetPVarInt(id, "Klan_Davet_Gonderen", playerid);
			format(str, sizeof(str), ""wb"» {%06x}%s "w"sizi {%06x}[%s] - %s "w"klanýna davet ediyor!\n\n"wb"» "w"Katýlmak istiyor musunuz?", 
				GetPlayerColor(playerid) >>> 8, getName(playerid), KlanRenkleri[kData[pData[playerid][pKlan]][kRenk]] >>> 8, kData[pData[playerid][pKlan]][kTag], kData[pData[playerid][pKlan]][kIsim]);
			ShowPlayerDialog(id, DIALOG_KLAN_DEGERLENDIR, DIALOG_STYLE_MSGBOX, "Klan Daveti", str, ""ad"Evet", ""r"Hayýr");
			AdminBilgi(playerid, "Klan daveti gönderildi.");
		}
	}

	if(dialogid == DIALOG_KLAN_DEGERLENDIR)
	{
		if(!response)
		{
			new id = GetPVarInt(playerid, "Klan_Davet_Gonderen");
			Hata(id, "Oyuncu klan davetini kabul etmedi.");
			DeletePVar(playerid, "Klan_Davet_Gonderen");
		}
		if(response)
		{
			new id = GetPVarInt(playerid, "Klan_Davet_Gonderen"), str[150], sql[500];
			pData[playerid][pKlan] = pData[id][pKlan];
			pData[playerid][pKlanRutbe] = 0;
			format(str, sizeof(str), "[%s]%s", kData[pData[id][pKlan]][kTag], getName(playerid));
			SetPlayerName(playerid, str);
			format(str, sizeof(str), ""wb"» "w"%s klana katýldý!", getName(playerid));
			KlanMesaji(pData[id][pKlan], str);
			OyuncuKaydet(playerid);
			format(sql, sizeof(sql), "UPDATE `hesaplar` SET `kullaniciadi` = '%s' WHERE `sqlid` = '%d'", getName(playerid), pData[playerid][pSQLID]);
			mysql_query(db, sql);
			if(pData[playerid][pIsYeri] != -1) IsYeriLabelGuncelle(pData[playerid][pIsYeri]);
			if(pData[playerid][pEv] != -1) EvLabelGuncelle(pData[playerid][pEv]);
		}
	}

	if(dialogid == DIALOG_KLAN_UYEAT)
	{
		if(!response) return PC_EmulateCommand(playerid, "/klan");
		if(response)
		{
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_KLAN_UYEAT, DIALOG_STYLE_INPUT, KlanBaslik(pData[playerid][pKlan]), ""wb"» "w"Klandan atmak istediðiniz kullanýcýnýn ID veya ismini girin:\n\n"r"Bir deðer girmelisiniz!", "At", "Iptal");
			new id, str[50];
			if(IsNumeric(inputtext))
			{
				id = strval(inputtext);
			}
			else
			{
				id = GetPlayerID(inputtext);
			}
			if(!IsPlayerConnected(id)) return ShowPlayerDialog(playerid, DIALOG_KLAN_UYEAT, DIALOG_STYLE_INPUT, KlanBaslik(pData[playerid][pKlan]), ""wb"» "w"Klandan atmak atmak istediðiniz kullanýcýnýn ID veya ismini girin:\n\n"r"Oyuncu oyunda deðil!", "At", "Iptal");
			if(id == playerid) return ShowPlayerDialog(playerid, DIALOG_KLAN_UYEAT, DIALOG_STYLE_INPUT, KlanBaslik(pData[playerid][pKlan]), ""wb"» "w"Klandan atmak atmak istediðiniz kullanýcýnýn ID veya ismini girin:\n\n"r"Kendinizi atamazsýnýz!", "At", "Iptal");
			if(pData[id][pKlan] != pData[playerid][pKlan]) return ShowPlayerDialog(playerid, DIALOG_KLAN_UYEAT, DIALOG_STYLE_INPUT, KlanBaslik(pData[playerid][pKlan]), ""wb"» "w"Klandan atmak istediðiniz kullanýcýnýn ID veya ismini girin:\n\n"r"Oyuncu sizin klanýnýzda deðil!", "At", "Iptal");
			if(pData[id][pKlanRutbe] > pData[playerid][pKlanRutbe]) return ShowPlayerDialog(playerid, DIALOG_KLAN_UYEAT, DIALOG_STYLE_INPUT, KlanBaslik(pData[playerid][pKlan]), ""wb"» "w"Klandan atmak istediðiniz kullanýcýnýn ID veya ismini girin:\n\n"r"Oyuncu sizin rütbenizden daha yüksek!", "At", "Iptal");
			pData[id][pKlan] = -1;
			pData[id][pKlanRutbe] = 0;
			new bul, tag[25], isim[24];
			GetPlayerName(id, isim, 24);
			format(tag, sizeof(tag), "%s", kData[pData[playerid][pKlan]][kTag]);
			bul = strfind(isim, tag);
			strdel(isim, bul - 1, bul + strlen(tag) + 1);
			SetPlayerName(id, isim);
			format(str, sizeof(str), ""wb"» "w"%s klandan atýldý!", getName(id));
			KlanMesaji(pData[playerid][pKlan], str);
			OyuncuKaydet(id);
			new sql[500];
			format(sql, sizeof(sql), "UPDATE `hesaplar` SET `kullaniciadi` = '%s' WHERE `sqlid` = '%d'", getName(id), pData[id][pSQLID]);
			mysql_query(db, sql);
			if(pData[id][pIsYeri] != -1) IsYeriLabelGuncelle(pData[id][pIsYeri]);
			if(pData[id][pEv] != -1) EvLabelGuncelle(pData[id][pEv]);
		}
	}

	if(dialogid == DIALOG_KLAN)
	{
		if(!response) return true;
		if(response)
		{
			if(pData[playerid][pKlan] == -1)
			{
				ShowPlayerDialog(playerid, DIALOG_KLAN_KUR_ISIM, DIALOG_STYLE_INPUT, "Klan - Kur (1/3)", ""w"Klanýnýza bir "wb"ISIM "w"verin:\n\n"ad"(Bu isim en az 3, en fazla 20 karakter olmalýdýr.)", "Devam", "Iptal");
			}
		}
	}

	if(dialogid == DIALOG_KLAN_KUR_ISIM)
	{
		if(!response) return true;
		if(response)
		{
			if(strlen(inputtext) < 3 || strlen(inputtext) > 20) return ShowPlayerDialog(playerid, DIALOG_KLAN_KUR_ISIM, DIALOG_STYLE_INPUT, "Klan - Kur (1/3)", ""w"Klanýnýza bir isim verin:\n\n"r"(Bu isim en az 3, en fazla 20 karakter olmalýdýr.)", "Devam", "Iptal");
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_KLAN_KUR_ISIM, DIALOG_STYLE_INPUT, "Klan - Kur (1/3)", ""w"Klanýnýza bir isim verin:\n\n"r"(Bu isim en az 3, en fazla 20 karakter olmalýdýr.)", "Devam", "Iptal");
			if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_KLAN_KUR_ISIM, DIALOG_STYLE_INPUT, "Klan - Kur (1/3)", ""w"Klanýnýza bir isim verin:\n\n"r"(Bu isim en az 3, en fazla 20 karakter olmalýdýr.)", "Devam", "Iptal");
			if(strfind(inputtext, " ") != -1) return ShowPlayerDialog(playerid, DIALOG_KLAN_KUR_ISIM, DIALOG_STYLE_INPUT, "Klan - Kur (1/3)", ""w"Klanýnýza bir isim verin:\n\n"r"(Bu isim en az 3, en fazla 20 karakter olmalýdýr.)", "Devam", "Iptal");

			SetPVarString(playerid, "klan_kur_isim", inputtext);
			ShowPlayerDialog(playerid, DIALOG_KLAN_KUR_TAG, DIALOG_STYLE_INPUT, "Klan - Kur (2/3)", ""w"Klanýnýza bir "wb"TAG "w"verin:\n\n"ad"(Bu tag en az 2, en fazla 8 karakter olmalýdýr.)", "Devam", "Iptal");
		}
	}

	if(dialogid == DIALOG_KLAN_KUR_TAG)
	{
		if(!response) return true;
		if(response)
		{
			if(strlen(inputtext) < 2 || strlen(inputtext) > 8) return ShowPlayerDialog(playerid, DIALOG_KLAN_KUR_TAG, DIALOG_STYLE_INPUT, "Klan - Kur (2/3)", ""w"Klanýnýza bir "wb"TAG "w"verin:\n\n"r"(Bu tag en az 2, en fazla 8 karakter olmalýdýr.)", "Devam", "Iptal");
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_KLAN_KUR_TAG, DIALOG_STYLE_INPUT, "Klan - Kur (2/3)", ""w"Klanýnýza bir "wb"TAG "w"verin:\n\n"r"(Bu tag en az 2, en fazla 8 karakter olmalýdýr.)", "Devam", "Iptal");
			if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_KLAN_KUR_TAG, DIALOG_STYLE_INPUT, "Klan - Kur (2/3)", ""w"Klanýnýza bir "wb"TAG "w"verin:\n\n"r"(Bu tag en az 2, en fazla 8 karakter olmalýdýr.)", "Devam", "Iptal");
			if(strfind(inputtext, " ") != -1 || strfind(inputtext, " ") != -1) return ShowPlayerDialog(playerid, DIALOG_KLAN_KUR_TAG, DIALOG_STYLE_INPUT, "Klan - Kur (2/3)", ""w"Klanýnýza bir "wb"TAG "w"verin:\n\n"r"(Bu tag en az 2, en fazla 8 karakter olmalýdýr.)", "Devam", "Iptal");

			for(new i = 0; i < strlen(inputtext); i++)
			{
				if(inputtext[i] == 'Þ' || inputtext[i] == 'Ü' || inputtext[i] == 'Ý' || inputtext[i] == 'Ð' || inputtext[i] == 'Ö' || inputtext[i] == 'ý' || inputtext[i] == 'Ç' || inputtext[i] == 'þ' || inputtext[i] == 'ü' || inputtext[i] == 'ð' || inputtext[i] == 'ö')
				{
					 return ShowPlayerDialog(playerid, DIALOG_KLAN_KUR_TAG, DIALOG_STYLE_INPUT, "Klan - Kur (2/3)", ""w"Klanýnýza bir "wb"TAG "w"verin:\n\n"r"(Bu tag en az 2, en fazla 8 karakter olmalýdýr.)\n\n"r"Lütfen tag'da türkçe karakter kullanmayýn!", "Devam", "Iptal");
				}
			}

			SetPVarString(playerid, "klan_kur_tag", inputtext);
			//ShowPlayerDialog(playerid, DIALOG_KLAN_KUR_RENK, DIALOG_STYLE_LIST, "Klan - Kur (3/3)", "{FFFFFF}Beyaz\n{FFFF00}Sarý\n{FF0000}Kýrmýzý\n{BF5F00}Kahverengi\n{800080}Mor\n{FFA500}Turuncu\n{0000FF}Mavi\n{228B22}Yeþil\n{808080}Gri", "Kur", "Iptal");
			new str[100000];
			for(new i = 0; i < 100; i++)
			{
				format(str, sizeof(str), "%s{%06x}Klan Rengi %d\n", str, KlanRenkleri[i] >>> 8, i + 1);
			}
			ShowPlayerDialog(playerid, DIALOG_KLAN_KUR_RENK, DIALOG_STYLE_LIST, "Klan - Kur (3/3)", str, "Kur", "Iptal");
		}
	}

	if(dialogid == DIALOG_KLAN_KUR_RENK)
	{
		if(!response) return true;
		if(response)
		{
			new id = Iter_Free(klanlar), isim[50], tag[10], str[500], sql[500];
			if(id == -1) return Hata(playerid, "Klan sýnýrý dolmuþ! (500)");
			GetPVarString(playerid, "klan_kur_isim", isim, 50);
			GetPVarString(playerid, "klan_kur_tag", tag, 10);
			kData[id][kID] = id;
			format(kData[id][kIsim], 50, "%s", isim);
			format(kData[id][kTag], 10, "%s", tag);
			kData[id][kKasa] = 0;
			kData[id][kRenk] = listitem;
			kData[id][kLevel] = 1;
			kData[id][kExp] = 0;
			kData[id][kMaxExp] = 1000;
			format(kData[id][kKurulus_Tarihi], 100, "%s", convertDate(gettime()));

			format(str, sizeof(str), "{%06x}Klanýnýz baþarýyla kuruldu. "wb"/klan {%06x}yazarak yönetebilirsiniz.", KlanRenkleri[listitem] >>> 8, KlanRenkleri[listitem] >>> 8);
			Bilgi(playerid, str);

			format(sql, sizeof(sql), "INSERT INTO `klanlar` (`id`, `isim`, `tag`, `kasa`, `renk`, `level`, `exp`, `maxexp`, `kurulus_tarihi`) VALUES \
				('%d', '%s', '%s', '%d', '%d', '%d', '%d', '%d', '%s')", id, isim, tag, kData[id][kKasa], kData[id][kRenk], kData[id][kLevel], kData[id][kExp], kData[id][kMaxExp], kData[id][kKurulus_Tarihi]);
			mysql_query(db, sql);

			Iter_Add(klanlar, id);

			format(str, sizeof(str), "[%s]%s", tag, getName(playerid));
			SetPlayerName(playerid, str);

			format(sql, sizeof(sql), "UPDATE `hesaplar` SET `kullaniciadi` = '%s' WHERE `sqlid` = '%d'", str, pData[playerid][pSQLID]);
			mysql_query(db, sql);

			if(pData[playerid][pIsYeri] != -1)
			{
				IsYeriLabelGuncelle(pData[playerid][pIsYeri]);
			}
			if(pData[playerid][pEv] != -1)
			{
				EvLabelGuncelle(pData[playerid][pEv]);
			}

			pData[playerid][pKlan] = id;
			pData[playerid][pKlanRutbe] = 3;
			OyuncuKaydet(playerid);
		}
	}

	if(dialogid == DIALOG_KAYIT)
	{
		if(!response) return SistemKick(playerid, "Kayit olunmadi");
		if(response)
		{
			if(strlen(inputtext) < 5 || !strlen(inputtext) || strlen(inputtext) > 20)
			{
				new str[512];
				format(str, sizeof(str), "\
					{00EEFF}Sunucumuza hoþgeldin %s!\n\
					Adýna kayýtlý bir hesap {FF0000}malesef bulunmuyor!\n\n\
					{FFB300}Aþaðýdaki kutucuða þifreni girerek kayýt olabilirsin:\n\n\
					{FF0000}Þifren 5 karakterden küçük, 20 karakterden büyük olamaz!", getName(playerid));
				ShowPlayerDialog(playerid, DIALOG_KAYIT, DIALOG_STYLE_PASSWORD, "{00EEFF}Kayýt", str, "Kayýt Ol", "Çýkýþ");
			}

			new sql[500], idd;
			format(sql, sizeof(sql), "INSERT INTO `hesaplar` (`kullaniciadi`, `tagsiz_isim`, `sifre`, `kayit_tarihi`, `son_giris`) VALUES ('%s', '%s', '%s', '%s', '%s')", getName(playerid), getName(playerid), inputtext, convertDate(gettime()), convertDate(gettime()));
			mysql_query(db, sql);

			format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `tagsiz_isim` = '%s'", getName(playerid));
			mysql_query(db, sql);

			cache_get_value_name_int(0, "sqlid", idd);

			format(sql, sizeof(sql), "INSERT INTO `basarimlar` (`sqlid`) VALUES ('%d')", idd);
			mysql_query(db, sql);

			Bilgi(playerid, "Sunucumuza baþarýyla kayýt oldunuz. Keyifli oyunlar!");

			Kayit_Giris(playerid);
		}
	}

	if(dialogid == DIALOG_GIRIS)
	{
		if(!response) return SistemKick(playerid, "Giris yapilmadi");
		if(response)
		{
			new sql[500];
			format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `tagsiz_isim` = '%s' AND BINARY `sifre` = '%s'", getName(playerid), inputtext);
			mysql_query(db, sql);

			if(cache_num_rows() > 0)
			{
				pData[playerid][pGiris] = true;
				cache_get_value_name_int(0, "sqlid", pData[playerid][pSQLID]);
				cache_get_value_name_int(0, "skor", pData[playerid][pSkor]);
				SetPlayerScore(playerid, pData[playerid][pSkor]);
				cache_get_value_name_int(0, "para", pData[playerid][pPara]);
				GivePlayerMoney_R(playerid, pData[playerid][pPara]);
				cache_get_value_name_int(0, "olum", pData[playerid][pOlum]);
				cache_get_value_name_int(0, "oldurme", pData[playerid][pOldurme]);
				cache_get_value_name_int(0, "renk", pData[playerid][pRenk]);
				cache_get_value_name_int(0, "skin", pData[playerid][pSkin]);
				cache_get_value_name_int(0, "admin", pData[playerid][pAdmin]);
				cache_get_value_name_int(0, "anim", pData[playerid][pAnim]);
				cache_get_value_name_int(0, "arac", pData[playerid][pArac]);
				cache_get_value_name_int(0, "isyeri", pData[playerid][pIsYeri]);
				cache_get_value_name_int(0, "ev", pData[playerid][pEv]);
				cache_get_value_name_int(0, "online_suresi", pData[playerid][pOnlineSuresi]);
				cache_get_value_name_int(0, "klan", pData[playerid][pKlan]);
				cache_get_value_name_int(0, "klanrutbe", pData[playerid][pKlanRutbe]);
				cache_get_value_name_int(0, "exp", pData[playerid][pExp]);
				cache_get_value_name_int(0, "maxexp", pData[playerid][pMaxExp]);
				cache_get_value_name_int(0, "level", pData[playerid][pLevel]);
				cache_get_value_name_int(0, "bankahesap", pData[playerid][pBankaHesap]);
				cache_get_value_name_int(0, "mute", pData[playerid][pMute]);
				new xd_str[150];
				cache_get_value_name(0, "spawnsilahlari", xd_str);
				sscanf(xd_str, "p<|>iiiiii", pData[playerid][pSilahlar][0], pData[playerid][pSilahlar][1], pData[playerid][pSilahlar][2], pData[playerid][pSilahlar][3], pData[playerid][pSilahlar][4], pData[playerid][pSilahlar][5]);
				cache_get_value_name_int(0, "jail", pData[playerid][pJail]);
				pData[playerid][pUyarilar] = 0;
				pData[playerid][pGod] = false;
				pData[playerid][pEvde] = false;

				AnahtarYukle(playerid);
				BasarimYukle(playerid);
				PosYukle(playerid);
				ArkadasYukle(playerid);

				if(pData[playerid][pKlan] != -1)
				{
					new str__[50];
					format(str__, sizeof(str__), "[%s]%s", kData[pData[playerid][pKlan]][kTag], getName(playerid));
					SetPlayerName(playerid, str__);
				}

				Bilgi(playerid, "Hesabýnýza baþarýyla giriþ yaptýnýz, bilgileriniz yüklendi. Ýyi oyunlar.");
				format(sql, sizeof(sql), "UPDATE `hesaplar` SET `son_giris` = '%s' WHERE `sqlid` = '%d'", convertDate(gettime()), pData[playerid][pSQLID]);
				mysql_query(db, sql);

				NBanKontrol(playerid);
				AkaOlustur(playerid);
			}
			else
			{
				Hata(playerid, "Yanlýþ þifre giriþi yaptýnýz. Lütfen tekrar deneyin.");
				SetPVarInt(playerid, "GirisHaklari", GetPVarInt(playerid, "GirisHaklari") + 1);
				if(GetPVarInt(playerid, "GirisHaklari") >= 3)
				{
					SistemKick(playerid, "Giris Hakki Doldu");
					return false;
				}
				Kayit_Giris(playerid);
			}
		}
	}

	if(dialogid == DIALOG_ARACIM)
	{
		if(!response) return true;
		if(response)
		{
			switch(listitem)
			{
				case 6..11: return PC_EmulateCommand(playerid, "/a");
				case 0:
				{
					if(IsPlayerInAnyVehicle(playerid))
					{
						foreach(new i: araclar)
						{
							if(GetPlayerVehicleID(playerid) == aData[i][aID] && aData[i][aSahip] == pData[playerid][pSQLID])
							{
								return Hata(playerid, "Zaten aracýnýzdasýnýz!");
							}
						}
					}

					if(IsPlayerInAnyVehicle(playerid))
					{
						return Hata(playerid, "Önce araçtan inmelisiniz!");
					}

					new Float: x, Float: y, Float: z, Float: f;

					GetPlayerPos(playerid, x, y, z);
					GetPlayerFacingAngle(playerid, f);

					SetVehiclePos(aData[pData[playerid][pArac]][aID], x, y, z);
					SetVehicleZAngle(aData[pData[playerid][pArac]][aID], f);
					ModVehicle_Yeni(pData[playerid][pArac]);
					PutPlayerInVehicle(playerid, aData[pData[playerid][pArac]][aID], 0);
					AdminBilgi(playerid, "Aracýnýz baþarýyla çaðýrýldý.");
				}
				case 1:
				{
					new en_yakin, Float: enson = 99999999999;
					for(new i = 0; i < sizeof(Benzinlikler); i++)
					{
						if(GetPlayerDistanceFromPoint(playerid, Benzinlikler[i][0], Benzinlikler[i][1], Benzinlikler[i][2]) < enson)
						{
							enson = GetPlayerDistanceFromPoint(playerid, Benzinlikler[i][0], Benzinlikler[i][1], Benzinlikler[i][2]);
							en_yakin = i;
						}
					}
					new str[512];
					format(str, sizeof(str), ""w"En yakýn benzinlik haritada iþaretlensin mi?\n\n\
						"wb"» "w"Koordinatlar: "wb"%f, %f, %f\n\
						"wb"» "w"Uzaklýðýnýz: "wb"%d metre\n\
						"wb"» "w"Litre Fiyatý: "wb"6 TL", Benzinlikler[en_yakin][0], Benzinlikler[en_yakin][1], Benzinlikler[en_yakin][2], floatround(enson));
					ShowPlayerDialog(playerid, DIALOG_ARACIM_BENZIN, DIALOG_STYLE_MSGBOX, "Aracým - Benzin", str, ""ad"Evet", ""r"Hayýr");
				}
				case 2:
				{
					if(IsPlayerInAnyVehicle(playerid))
					{
						foreach(new i: araclar)
						{
							if(GetPlayerVehicleID(playerid) == aData[i][aID] && pData[playerid][pSQLID] != aData[i][aSahip])
							{
								return Hata(playerid, "Bunu yapabilmek için kendi aracýnýzda olmalýsýnýz!");
							}
						}
					}

					if(!IsPlayerInAnyVehicle(playerid))
					{
						return Hata(playerid, "Bunu yapabilmek için aracýnýzda olmalýsýnýz!");
					}

					if(aData[pData[playerid][pArac]][aKilit] == true)
					{
						aData[pData[playerid][pArac]][aKilit] = false;
						Bilgi(playerid, "Kapý kilitleri "ad"açýldý. "w"Arabanýza binebilirler.");
					}
					else if(aData[pData[playerid][pArac]][aKilit] == false)
					{
						aData[pData[playerid][pArac]][aKilit] = true;
						Bilgi(playerid, "Kapý kilitleri "r"kapatýldý. "w"Arabanýza kimse binemez.");
					}
				}
				case 3:
				{
					new string[512];
					format(string, sizeof(string), "\
						"w"Aracýnýzý satmak istediðinize emin misiniz?\n\n\
						"w"Model: "wb"%s\n\
						"w"Plaka: "wb"%s\n\
						"w"Alacaðýnýz Fiyat: "wb"%d", GetVehicleName(aData[pData[playerid][pArac]][aID]), aData[pData[playerid][pArac]][aPlaka], 7000);
					ShowPlayerDialog(playerid, DIALOG_ARACIM_SAT, DIALOG_STYLE_MSGBOX, ""w"Araç Satým", string, ""ad"Evet", ""wb"Hayýr");
				}
				case 4:
				{
					if(IsPlayerInAnyVehicle(playerid))
					{
						foreach(new i: araclar)
						{
							if(GetPlayerVehicleID(playerid) == aData[i][aID] && pData[playerid][pSQLID] != aData[i][aSahip])
							{
								return Hata(playerid, "Bunu yapabilmek için kendi aracýnýzda olmalýsýnýz!");
							}
						}
					}

					if(!IsPlayerInAnyVehicle(playerid))
					{
						return Hata(playerid, "Bunu yapabilmek için aracýnýzda olmalýsýnýz!");
					}

					new Float: x, Float: y, Float: z, Float: f;

					GetVehiclePos(aData[pData[playerid][pArac]][aID], x, y, z);
					GetVehicleZAngle(aData[pData[playerid][pArac]][aID], f);

					new id = pData[playerid][pArac];
					aData[id][aX] = x;
					aData[id][aY] = y;
					aData[id][aZ] = z;
					aData[id][aF] = f;

					new sql[500];
					format(sql, sizeof(sql), "UPDATE `araclar` SET `x` = '%f', `y` = '%f', `z` = '%f', `f` = '%f' WHERE `sahip` = '%d'",
						x, y, z, f, pData[playerid][pSQLID]);
					mysql_query(db, sql);

					AdminBilgi(playerid, "Aracýnýzýn park yeri kayýt edildi, artýk burada bulabilirsiniz.");
				}
				case 5:
				{
					new str[1024], sql[500], sahipid;
					format(sql, sizeof(sql), "SELECT * FROM `anahtarlar` WHERE `aracid` = '%d'", pData[playerid][pArac]);
					mysql_query(db, sql);

					strcat(str, "{FFFFFF}#\t{FFFFFF}#\n");
					strcat(str, ""wb"»\t{FFFFFF}Anahtar Ver\n"wb"»\t{FFFFFF}Anahtar Al\n");

					for(new i; i < cache_num_rows(); i++)
					{
						format(sql, sizeof(sql), "SELECT * FROM `anahtarlar` WHERE `aracid` = '%d'", pData[playerid][pArac]);
						mysql_query(db, sql);
						cache_get_value_name_int(i, "sqlid", sahipid);
						format(str, sizeof(str), "%s"ad"[ANAHTARI VAR]\t{FFFFFF}%s\n", str, SQL_Isim_Cek(sahipid));
						format(sql, sizeof(sql), "SELECT * FROM `anahtarlar` WHERE `aracid` = '%d'", pData[playerid][pArac]);
						mysql_query(db, sql);
					}
					ShowPlayerDialog(playerid, DIALOG_ARACIM_ANAHTAR, DIALOG_STYLE_TABLIST_HEADERS, "Araç Anahtarlarý", str, "Seç", "Kapat");
				}
			}
		}
	}

	if(dialogid == DIALOG_ARACIM_SAT)
	{
		if(!response) return true;
		if(response)
		{
			new id = pData[playerid][pArac], sql[500];

			new Float: x, Float: y, Float: z;
			GetPlayerPos(playerid, x, y, z);
			SetPlayerPos(playerid, x, y, z + 3);

			SetVehicleToRespawn(aData[id][aID]);
			aData[id][aSahip] = -1;
			aData[id][aBenzin] = 100;
			aData[id][aMod1] = 0;
			aData[id][aMod2] = 0;
			aData[id][aMod3] = 0;
			aData[id][aMod4] = 0;
			aData[id][aMod5] = 0;
			aData[id][aMod6] = 0;
			aData[id][aMod7] = 0;
			aData[id][aMod8] = 0;
			aData[id][aMod9] = 0;
			aData[id][aMod10] = 0;
			aData[id][aMod11] = 0;
			aData[id][aMod12] = 0;
			aData[id][aMod13] = 0;
			aData[id][aMod14] = 0;
			aData[id][aMod15] = 0;
			aData[id][aMod16] = 0;
			aData[id][aMod17] = 0;
			aData[id][aRenk1] = 1;
			aData[id][aRenk2] = 1;
			aData[id][aPaintJob] = -1;
			aData[id][aKilit] = true;

			ModVehicle_Yeni(id);
			format(sql, sizeof(sql), "UPDATE `araclar` SET `sahip` = '-1' WHERE `id` = '%d'", id);
			mysql_query(db, sql);

			pData[playerid][pArac] = -1;

			AracKayit(id);

			format(sql, sizeof(sql), "UPDATE `hesaplar` SET `arac` = '-1' WHERE `sqlid` = '%d'", pData[playerid][pSQLID]);
			mysql_query(db, sql);

			GivePlayerMoney(playerid, 7000);

			Bilgi(playerid, "Aracýnýzý baþarýyla sattýnýz.");
		}
	}

	if(dialogid == DIALOG_ARACIM_AL)
	{
		if(!response) return true;
		if(response)
		{
			foreach(new i: araclar)
			{
				if(GetPlayerVehicleID(playerid) == aData[i][aID] && aData[i][aSahip] == -1)
				{
					if(GetPlayerMoney(playerid) < 14000)
					{
						return Hata(playerid, "Araç satýn alabilmek için 14.000 TL paranýz olmalýdýr.");
					}

					new sql[500];

					format(sql, sizeof(sql), "UPDATE `araclar` SET `sahip` = '%d' WHERE `id` = '%d'", pData[playerid][pSQLID], i);
					mysql_query(db, sql);

					format(sql, sizeof(sql), "UPDATE `hesaplar` SET `arac` = '%d' WHERE `sqlid` = '%d'", i, pData[playerid][pSQLID]);
					mysql_query(db, sql);

					aData[i][aSahip] = pData[playerid][pSQLID];
					aData[i][aMod1] = 0;
					aData[i][aMod2] = 0;
					aData[i][aMod3] = 0;
					aData[i][aMod4] = 0;
					aData[i][aMod5] = 0;
					aData[i][aMod6] = 0;
					aData[i][aMod7] = 0;
					aData[i][aMod8] = 0;
					aData[i][aMod9] = 0;
					aData[i][aMod10] = 0;
					aData[i][aMod11] = 0;
					aData[i][aMod12] = 0;
					aData[i][aMod13] = 0;
					aData[i][aMod14] = 0;
					aData[i][aMod15] = 0;
					aData[i][aMod16] = 0;
					aData[i][aMod17] = 0;
					aData[i][aPaintJob] = -1;
					aData[i][aKilit] = true;

					pData[playerid][pArac] = i;

					GivePlayerMoney(playerid, -14000);

					Bilgi(playerid, "Aracýnýzý baþarýyla satýn aldýnýz.");
					break;
				}
			}
		}
	}

	if(dialogid == DIALOG_ISYERIM_SAT)
	{
		if(!response) return PC_EmulateCommand(playerid, "/isyerim");
		if(response)
		{
			return PC_EmulateCommand(playerid, "/isyerisat");
		}
	}

	if(dialogid == DIALOG_ISYERIM)
	{
		if(!response) return true;
		if(response)
		{
			new id = pData[playerid][pIsYeri];
			switch(listitem)
			{
				case 0..8: return PC_EmulateCommand(playerid, "/isyerim");
				case 9:
				{
					ShowPlayerDialog(playerid, DIALOG_ISYERIM_ISIM, DIALOG_STYLE_INPUT, ""w"Ýþyeri Menüsü - Ýsim", ""w"Yeni ismi giriniz:\n", ""w"Deðiþtir", ""w"Ýptal");
				}
				case 10:
				{
					if(iData[id][iKasa] <= 0) return Hata(playerid, "Kasada yeterli para yok!"), PC_EmulateCommand(playerid, "/isyerim");

					GivePlayerMoney(playerid, iData[id][iKasa]);

					new string[512];
					format(string, sizeof(string), "Ýþyeri kasanýzdaki parayý çektiniz! ("wb"+%s TL"w")", FormatMoney(iData[id][iKasa]));
					Bilgi(playerid, string);

					iData[id][iKasa] = 0;
				}
				case 11:
				{
					if(iData[id][iLevel] == 3)
					{
						return Hata(playerid, "Ýþyeriniz zaten maksimum seviyede!");
					}
					if(iData[id][iLevel] == 1)
					{
						if(GetPlayerMoney(playerid) < 25000) return Hata(playerid, "Ýþyerinizi 2 level yapmak için 25.000 TL'ye ihtiyacýnýz var!");
						iData[id][iLevel]++;
						GivePlayerMoney(playerid, -25000);
						new string[512];
						format(string, sizeof(string), ""w"("wb"-25.000 TL"w") Ýþyerinizin levelini baþarýyla arttýrdýnýz! Yeni level: "wb"%d", iData[id][iLevel]);
						Bilgi(playerid, string);
						IsYeriLabelGuncelle(id);
					}
					else if(iData[id][iLevel] == 2)
					{
						if(GetPlayerMoney(playerid) < 50000) return Hata(playerid, "Ýþyerinizi 3 level yapmak için 50.000 TL'ye ihtiyacýnýz var!");
						iData[id][iLevel]++;
						GivePlayerMoney(playerid, -50000);
						new string[512];
						format(string, sizeof(string), ""w"("wb"-50.000 TL"w") Ýþyerinizin levelini baþarýyla arttýrdýnýz! Yeni level: "wb"%d", iData[id][iLevel]);
						Bilgi(playerid, string);
						IsYeriLabelGuncelle(id);
					}
					IsYeriKaydet(id);
				}
				case 12:
				{
					switch(iData[id][iKilit])
					{
						case 0:
						{
							iData[id][iKilit] = 1;
							IsYeriLabelGuncelle(id);
							IsYeriKaydet(id);
							PC_EmulateCommand(playerid, "/isyerim");
						}
						case 1:
						{
							iData[id][iKilit] = 0;
							IsYeriLabelGuncelle(id);
							IsYeriKaydet(id);
							PC_EmulateCommand(playerid, "/isyerim");
						}
					}
				}
				case 13: return PC_EmulateCommand(playerid, "/isyerim");
				case 14:
				{
					new str[2048], str2[500];
					format(str2, sizeof(str2), ""wb"» "w"Ýþyeri Ýsmi: "wb"%s\n", iData[id][iIsim]);
					strcat(str, str2);
					format(str2, sizeof(str2), ""wb"» "w"Ýþyeri Fiyatý: "wb"%s TL\n", FormatMoney(iData[id][iFiyat]));
					strcat(str, str2);
					format(str2, sizeof(str2), ""wb"» "w"Ýþyeri Leveli: "wb"%d\n", iData[id][iLevel]);
					strcat(str, str2);
					format(str2, sizeof(str2), ""wb"» "w"Ýþyeri Bölgesi: "wb"%s\n", GetZoneName(iData[id][iX], iData[id][iY], iData[id][iZ]));
					strcat(str, str2);
					format(str2, sizeof(str2), ""wb"» "w"Ýþyeri Kasasý: "wb"%s TL\n\n", FormatMoney(iData[id][iKasa]));
					strcat(str, str2);
					format(str2, sizeof(str2), ""wb"» "w"Ýþyeri Bitiþ Tarihi: "wb"%s\n", convertDate(iData[id][iBitisZaman]));
					strcat(str, str2);
					format(str2, sizeof(str2), ""wb"» "w"Ýþyeri Bitmesine Kalan: "wb"%s\n\n", ConvertTime(iData[id][iBitisZaman] - gettime()));
					strcat(str, str2);
					format(str2, sizeof(str2), ""wb"» "w"Ýþyerini satýnca alcaðýnýz fiyat: "wb"%s TL\n", FormatMoney(iData[id][iFiyat] / 2));
					strcat(str, str2);
					format(str2, sizeof(str2), ""wb"» "w"Ýþyerini gerçekten satmak istiyor musunuz?");
					strcat(str, str2);
					ShowPlayerDialog(playerid, DIALOG_ISYERIM_SAT, DIALOG_STYLE_MSGBOX, ""w"Ýþyeri Menüsü - Satým", str, ""ad"Evet", ""r"Hayýr");
				}
			}
		}
	}

	if(dialogid == DIALOG_ISYERIM_ISIM)
	{
		if(!response) return PC_EmulateCommand(playerid, "/isyerim");
		if(response)
		{
			if(!strlen(inputtext)) return PC_EmulateCommand(playerid, "/isyerim"), Hata(playerid, "Bir deðer girmelisiniz!");
			if(strlen(inputtext) < 3 || strlen(inputtext) > 20) return PC_EmulateCommand(playerid, "/isyerim"), Hata(playerid, "Deðer en az 3, en fazla 20 karakter olabilir!");

			new id = pData[playerid][pIsYeri];

			format(iData[id][iIsim], 128, "%s", inputtext);

			IsYeriLabelGuncelle(id);

			IsYeriKaydet(id);
		}
	}
	return true;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(playerid != INVALID_PLAYER_ID && killerid != INVALID_PLAYER_ID)
	{
		SetPlayerScore(killerid, GetPlayerScore(killerid) + 1);
		GivePlayerMoney(killerid, 10);
		SendDeathMessage(killerid, playerid, reason);
		pData[killerid][pOldurme]++;
		pData[playerid][pOlum]++;
		pData[killerid][pExp] += randomEx(10, 20);

		DusenPara[playerid] = GetPlayerMoney(playerid) / 50;
	    GivePlayerMoney(playerid, -DusenPara[playerid]);
		new Float: X, Float: Y, Float: Z;
		GetPlayerPos(playerid, X, Y, Z);
		if(PickupuMevcut[playerid] == true)
		{
			for(new n = 0; n < 10; n++)
			{
				if(IsValidDynamicPickup(ParalarPickup[playerid][n]))
					DestroyDynamicPickup(ParalarPickup[playerid][n]);
				if(IsValidDynamic3DTextLabel(ParalarLabel[playerid][n]))
					DestroyDynamic3DTextLabel(ParalarLabel[playerid][n]);
			}
			KillTimer(ParaKaldirTimer[playerid]);
			PickupuMevcut[playerid] = false;
		}
		
		if(DusenPara[playerid] != 0)
		{
			new strxx[150], xr, yr;
			format(strxx, sizeof(strxx), ""w"("ad"%d TL"w")", DusenPara[playerid] / 50);
			for(new p = 0; p < 10; p++)
			{
				xr = random(3) - random(3);
				yr = random(3) - random(3);
				ParalarPickup[playerid][p] = CreateDynamicPickup(1212, 3, X + xr, Y + yr, Z - 0.6);
				ParalarLabel[playerid][p] = CreateDynamic3DTextLabel(strxx, -1, X + xr, Y + yr, Z - 0.6, 10.0);
			}
			ParaKaldirTimer[playerid] = SetTimerEx("ParalariSil", 10000, 0, "i", playerid);
			PickupuMevcut[playerid] = true;
		}
	}
	return true;
}

public OnPlayerSpawn(playerid)
{
	new rasgele = random(sizeof(Spawnlar));
	SetPlayerPos(playerid, Spawnlar[rasgele][0], Spawnlar[rasgele][1], Spawnlar[rasgele][2]);
	SetPlayerFacingAngle(playerid, Spawnlar[rasgele][3]);
	SetCameraBehindPlayer(playerid);

	SetPlayerMaxHealth(playerid, 100.0);
	SetPlayerHealth(playerid, 100.0);
	SetPlayerArmour(playerid, 0.0);
	KillTimer(pData[playerid][pSpawnKorumaTimer]);
	AdminBilgi(playerid, "10 saniyelik spawn korumanýz baþladý!");
	ResetPlayerWeapons(playerid);
	pData[playerid][pSpawnKorumasinda] = true;
	if(IsValidDynamic3DTextLabel(pData[playerid][pSpawnKorumaLabel]))
		DestroyDynamic3DTextLabel(pData[playerid][pSpawnKorumaLabel]);
	pData[playerid][pSpawnKorumaLabel] = CreateDynamic3DTextLabel("=== "wb"Spawn Korumasýnda "w"===", -1, 0.0, 0.0, 0.6, 30.0, playerid);
	pData[playerid][pSpawnKorumaTimer] = SetTimerEx("KorumaBitir", 10000, false, "d", playerid);
	TogglePlayerControllable(playerid, true);

	for(new i; i < sizeof(_AnimsEnum); i++)
	{
		ApplyAnimation(playerid, _AnimsEnum[i], "null", 0.0, 0, 0, 0, 0, 0, 0);
	}

	for(new i; i < sizeof(Spawnlar); i++)
	{
		GangZoneShowForPlayer(playerid, spawnZoneler[i], 0x33FF00AA);
	}
	return true;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
	if(result == -1)
	{
		new str[512];
		format(str, sizeof(str), "Sunucumuzda "wb"/%s "w"komutu bulunmamakta.", cmd);
		Hata(playerid, str);
		return false;
	}
	BasarimVer(playerid, 1);
	return true;
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	if(pData[playerid][pGiris] != true) return Hata(playerid, "Giriþ yapmadan komut kullanamazsýnýz!");
	if(GetPlayerState(playerid) == PLAYER_STATE_WASTED || GetPlayerState(playerid) == PLAYER_STATE_NONE) return Hata(playerid, "Spawn olmadan komut kullanamazsýnýz.");
	if(pData[playerid][pJail] > 0)
	{
		new str[512];
		format(str, sizeof(str), "Hapisteyken komut kullanamazsýnýz. Kalan: "wb"%s", ConvertTime(pData[playerid][pJail]));
		Hata(playerid, str);
		return false;
	}
	return true;
}

public OnPlayerModelSelection(playerid, response, listid, modelid)
{
	if(listid == skin_listesi)
	{
		if(!response) return true;
		if(response)
		{
			if(GetPlayerMoney(playerid) < 5) return Hata(playerid, "Skin deðiþtirebilmek için {FF0000}5 TL'ye {FFFFFF}ihtiyacýnýz var!");
			SetPlayerSkin(playerid, modelid);
			GivePlayerMoney(playerid, -5);
			Bilgi(playerid, "Skininiz baþarýlý bir þekilde deðiþtirildi!");
		}
	}

	if(listid == galeri_liste)
	{
		if(!response) return true;
		if(response)
		{
			new str[2548];
			for(new i; i < sizeof(Plakalar); i++)
			{
				format(str, sizeof(str), "%s"wb"» "w"%d - %s\n", str, Plakalar[i][0], Plakalar[i][1]);
			}
			SetPVarInt(playerid, "modell", modelid);
			ShowPlayerDialog(playerid, DIALOG_GALERI_SATINAL, DIALOG_STYLE_LIST, "Plaka Seç", str, "Seç", "Iptal");
		}
	}

	if(listid == oturak_liste)
	{
		if(!response) return true;
		if(response)
		{
			new id = pData[playerid][pEv], bos_id = -2;
			for(new i; i < 10; i++)
			{
				if(evObjelerID[id][i] != -1) continue;
				bos_id = i;
				break;
			}
			if(bos_id == -2) return Hata(playerid, "Eþya sýnýrý doldu!");
			new Float: x, Float: y, Float: z;
			GetPlayerPos(playerid, x, y, z);
			GetXYInFrontOfPlayer(playerid, x, y, 1);
			EvInfo[id][evObjeler][bos_id] = CreateDynamicObject(modelid, x, y, z, 0, 0, 0, pData[playerid][pEv]);
			SetPVarInt(playerid, "ev_duzenlenen_obje", bos_id);
			SetPVarInt(playerid, "ev_duzenlenen_model", modelid);
			SetPVarInt(playerid, "ev_duzenlenen_ilk", 1);
			EditDynamicObject(playerid, EvInfo[id][evObjeler][bos_id]);
		}
	}
	return true;
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(GetPVarInt(playerid, "sonradanduzenle") == 1)
	{
		new Float: oldx, Float: oldy, Float: oldz, Float: oldrx, Float: oldry, Float: oldrz, objeid = GetPVarInt(playerid, "esyayonet_slot"), id = pData[playerid][pEv];
		GetDynamicObjectPos(objectid, oldx, oldy, oldz);
		GetDynamicObjectRot(objectid, oldrx, oldry, oldrz);
		if(response == EDIT_RESPONSE_CANCEL)
		{
			evObjelerPos[id][objeid][0] = oldx;
			evObjelerPos[id][objeid][1] = oldy;
			evObjelerPos[id][objeid][2] = oldz;
			evObjelerPos[id][objeid][3] = oldrx;
			evObjelerPos[id][objeid][4] = oldry;
			evObjelerPos[id][objeid][5] = oldrz;
			SetDynamicObjectPos(objectid, oldx, oldy, oldz);
			SetDynamicObjectRot(objectid, oldrx, oldry, oldrz);
			AdminBilgi(playerid, "Düzenleme iptal edildi!");
		}
		if(response == EDIT_RESPONSE_FINAL)
		{
			evObjelerPos[id][objeid][0] = x;
			evObjelerPos[id][objeid][1] = y;
			evObjelerPos[id][objeid][2] = z;
			evObjelerPos[id][objeid][3] = rx;
			evObjelerPos[id][objeid][4] = ry;
			evObjelerPos[id][objeid][5] = rz;
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);
			EvObjeKaydet(id);
			AdminBilgi(playerid, "Düzenleme tamamlandý!");
		}
	}
	else if(GetPVarInt(playerid, "ev_duzenlenen_ilk") == 1)
	{
		new Float: oldx, Float: oldy, Float: oldz, Float: oldrx, Float: oldry, Float: oldrz, objeid = GetPVarInt(playerid, "ev_duzenlenen_obje"), id = pData[playerid][pEv], objj = GetPVarInt(playerid, "ev_duzenlenen_model");
		GetDynamicObjectPos(objectid, oldx, oldy, oldz);
		GetDynamicObjectRot(objectid, oldrx, oldry, oldrz);
		if(response == EDIT_RESPONSE_CANCEL)
		{
			if(IsValidDynamicObject(objectid)) DestroyDynamicObject(EvInfo[id][evObjeler][objeid]);
			EvInfo[id][evObjeler][objeid] = -1;
			evObjelerPos[id][objeid][0] = -1.0;
			evObjelerPos[id][objeid][1] = -1.0;
			evObjelerPos[id][objeid][2] = -1.0;
			evObjelerPos[id][objeid][3] = -1.0;
			evObjelerPos[id][objeid][4] = -1.0;
			evObjelerPos[id][objeid][5] = -1.0;
			evObjelerID[id][objeid] = -1;
			AdminBilgi(playerid, "Düzenleme iptal edildi!");
		}
		if(response == EDIT_RESPONSE_FINAL)
		{
			evObjelerPos[id][objeid][0] = x;
			evObjelerPos[id][objeid][1] = y;
			evObjelerPos[id][objeid][2] = z;
			evObjelerPos[id][objeid][3] = rx;
			evObjelerPos[id][objeid][4] = ry;
			evObjelerPos[id][objeid][5] = rz;
			evObjelerID[id][objeid] = objj;
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);
			EvObjeKaydet(id);
			AdminBilgi(playerid, "Düzenleme tamamlandý!");
		}
	}
	return true;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_YES && IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new Float: f;
		GetVehicleZAngle(GetPlayerVehicleID(playerid), f);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), f);
		PlayerPlaySound(playerid, 1149, 0.0, 0.0, 0.0);
	}

	if(newkeys & KEY_LOOK_BEHIND && IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		RepairVehicle(GetPlayerVehicleID(playerid));
		AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
		GameTextForPlayer(playerid, "~r~~h~TAMIR EDILDI~n~~g~~h~NITRO EKLENDI", 1500, 3);
		PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	}

	if(newkeys & KEY_CROUCH && IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		foreach(new i: araclar)
		{
			if(GetPlayerVehicleID(playerid) == aData[i][aID] && BenzinligeYakin(playerid) && BenzinDolduruyor[playerid] == false)
			{
				if(GetPlayerMoney(playerid) < 6) return Hata(playerid, "Yetersiz bakiye!");
				BenzinDolduruyor[playerid] = true;
				TogglePlayerControllable(playerid, false);
				new string[512];
				format(string, sizeof(string), "~r~~h~Benzin dolduruluyor...~n~~g~~h~%d", aData[i][aBenzin]);
				GameTextForPlayer(playerid, string, 1000, 5);
				KillTimer(BenzinTimer[playerid]);
				BenzinTimer[playerid] = SetTimerEx("BenzinDolduruluyor", 850, true, "di", playerid, i);
				break;
			}
		}
	}

	if(newkeys & KEY_SECONDARY_ATTACK && !IsPlayerInAnyVehicle(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid, 1.0, 2315.5051, 0.3431, 26.7422))
		{
			new banka_id = GetPVarInt(playerid, "sonbanka");
			SetPlayerInterior(playerid, 0);
			SetPlayerPos(playerid, BankaPoslari[banka_id][0], BankaPoslari[banka_id][1], BankaPoslari[banka_id][2]);
			Bankada[playerid] = false;
			Bilgi(playerid, "Bankadan ayrýldýnýz.");
			DeletePVar(playerid, "sonbanka");
			return true;
		}

		for(new i = 0; i < sizeof(BankaPoslari); i++)
		{
			if(IsPlayerInRangeOfPoint(playerid, 1.0, BankaPoslari[i][0], BankaPoslari[i][1], BankaPoslari[i][2]))
			{
				SetPlayerInterior(playerid, 0);
				SetPlayerPos(playerid, 2315.952880, -1.618174, 26.742187);
				Bankada[playerid] = true;
				Bilgi(playerid, "GL Bank'a hoþgeldiniz. "wb"/hesabim "w"yazarak iþlemlerinizi yapabilirsiniz.");
				SetPVarInt(playerid, "sonbanka", i);
				BasarimVer(playerid, 2);
				break;
			}
		}
	}

	if(newkeys & KEY_SECONDARY_ATTACK && !IsPlayerInAnyVehicle(playerid))
	{
		foreach(new i: evler)
		{
			if(IsPlayerInRangeOfPoint(playerid, 1.0, EvInfo[i][evX], EvInfo[i][evY], EvInfo[i][evZ]))
			{
				if(EvInfo[i][evKilit] == 1 && pData[playerid][pSQLID] != EvInfo[i][evSahip]) return Hata(playerid, "Bu ev kilitli.");

				SetPlayerInterior(playerid, EvInfo[i][evInterior]);
				SetPlayerPos(playerid, EvInfo[i][evCikisX], EvInfo[i][evCikisY], EvInfo[i][evCikisZ]);
				SetPlayerVirtualWorld(playerid, EvInfo[i][evID]);

				EvInfo[i][evCikisPickup] = CreateDynamicPickup(1318, 1, EvInfo[i][evCikisX], EvInfo[i][evCikisY], EvInfo[i][evCikisZ]);
				EvInfo[i][evCikisLabel] = CreateDynamic3DTextLabel("{999999}(Çýkmak için '"wb"F{999999}' tuþuna basýnýz.)", -1, EvInfo[i][evCikisX], EvInfo[i][evCikisY], EvInfo[i][evCikisZ], 35.0);

				new str[512];
				if(EvInfo[i][evSahip] == -1)
				{
					format(str, sizeof(str), ""w"Eve baþarýyla giriþ yaptýnýz. Ev sahibi: "wb"Yok");
				}
				else
				{
					format(str, sizeof(str), ""w"Eve baþarýyla giriþ yaptýnýz. Ev sahibi: "wb"%s", SQL_Isim_Cek(EvInfo[i][evSahip]));
				}
				Bilgi(playerid, str);
				SetPVarInt(playerid, "ev_ID", i);
				pData[playerid][pEvde] = true;
				break;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 1.0, EvInfo[i][evCikisX], EvInfo[i][evCikisY], EvInfo[i][evCikisZ]))
			{
				new id = GetPVarInt(playerid, "ev_ID");
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerPos(playerid, EvInfo[id][evX], EvInfo[id][evY], EvInfo[id][evZ]);
				Bilgi(playerid, "Baþarýyla evden çýktýnýz.");
				if(IsValidDynamic3DTextLabel(EvInfo[id][evCikisLabel]))
					DestroyDynamic3DTextLabel(EvInfo[id][evCikisLabel]);
				if(IsValidDynamicPickup(EvInfo[id][evCikisPickup]))
					DestroyDynamicPickup(EvInfo[id][evCikisPickup]);
				pData[playerid][pEvde] = false;
				break;
			}
		}
	}

	if(newkeys & KEY_SECONDARY_ATTACK && !IsPlayerInAnyVehicle(playerid))
	{
		foreach(new i: isyerleri)
		{
			if(IsPlayerInRangeOfPoint(playerid, 1.0, iData[i][iX], iData[i][iY], iData[i][iZ]))
			{
				if(iData[i][iKilit] == 1 && pData[playerid][pSQLID] != iData[i][iSahip])
				{
					return Hata(playerid, "Bu iþyeri kilitli.");
				}

				if(iData[i][iInterior] == 1)
				{
					SetPlayerPos(playerid, -25.884498,-185.868988,1003.546875); // - Market 1
					SetPlayerInterior(playerid, 17);
				}
				else if(iData[i][iInterior] == 2)
				{
					SetPlayerPos(playerid, 6.091179,-29.271898,1003.549438); // - Market 2
					SetPlayerInterior(playerid, 10);
				}
				else if(iData[i][iInterior] == 3)
				{
					SetPlayerPos(playerid, 286.148986,-40.644397,1001.515625); // - Silahçý 1
					SetPlayerInterior(playerid, 1);
				}
				else if(iData[i][iInterior] == 4)
				{
					SetPlayerPos(playerid, 286.800994,-82.547599,1001.515625); // - Silahçý 2
					SetPlayerInterior(playerid, 4);
				}
				else if(iData[i][iInterior] == 5)
				{
					SetPlayerPos(playerid, 373.825653,-117.270904,1001.499511); // - Pizzacý
					SetPlayerInterior(playerid, 5);
				}
				else if(iData[i][iInterior] == 6)
				{
					SetPlayerPos(playerid, 369.579528,-4.487294,1001.858886); // - Tavukçu :D
					SetPlayerInterior(playerid, 9);
				}
				else if(iData[i][iInterior] == 7)
				{
					SetPlayerPos(playerid, 375.962463,-65.816848,1001.507812); // - Burgerci
					SetPlayerInterior(playerid, 10);
				}
				iData[i][iCikisPickup] = CreateDynamicPickup(1318, 1, iData[i][iCikisX], iData[i][iCikisY], iData[i][iCikisZ]);
				iData[i][iCikisLabel] = CreateDynamic3DTextLabel("{999999}(Çýkmak için '"wb"F{999999}' tuþuna basýnýz.)", -1, iData[i][iCikisX], iData[i][iCikisY], iData[i][iCikisZ], 35.0);
				new str[512];
				if(iData[i][iSahip] != -1)
					format(str, sizeof(str), "Baþarýyla "wb"%s "w"adlý iþyerine giriþ yaptýnýz. Buranýn sahibi: "wb"%s", iData[i][iIsim], SQL_Isim_Cek(iData[i][iSahip]));
				else
					format(str, sizeof(str), "Baþarýyla "wb"%s "w"adlý iþyerine giriþ yaptýnýz. Buranýn sahibi: "wb"Yok", iData[i][iIsim]);
				Bilgi(playerid, str);
				SetPVarInt(playerid, "isyeri_ID", i);
				SetPlayerVirtualWorld(playerid, i);
				break;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 1.0, iData[i][iCikisX], iData[i][iCikisY], iData[i][iCikisZ]))
			{
				new id = GetPVarInt(playerid, "isyeri_ID");
				SetPlayerInterior(playerid, 0);
				SetPlayerPos(playerid, iData[id][iX], iData[id][iY], iData[id][iZ]);
				SetPlayerVirtualWorld(playerid, 0);
				if(IsValidDynamicPickup(iData[id][iCikisPickup]))
					DestroyDynamicPickup(iData[id][iCikisPickup]);
				if(IsValidDynamic3DTextLabel(iData[id][iCikisLabel]))
					DestroyDynamic3DTextLabel(iData[id][iCikisLabel]);
				Bilgi(playerid, "Ýþyerinden çýktýnýz.");
				break;
			}
		}
	}
	return true;
}

//=-=-==-=-==-=-==-=-==-=-==-=-= STOCKLAR =-=-==-=-==-=-==-=-==-=-==-=-=

stock AnimCek(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		new animcik[32], animismine[32];
		GetAnimationName(GetPlayerAnimationIndex(playerid), animcik, 32, animismine, 32);
		if(!strcmp(animcik, "SWIM", true) && !strcmp(animismine, "SWIM_GLIDE", true)) return true;
		else if(!strcmp(animcik, "SWIM", true) && !strcmp(animismine, "SWIM_BREAST", true)) return true;
		else if(!strcmp(animcik, "SWIM", true) && !strcmp(animismine, "SWIM_CRAWL", true)) return true;
		else if(!strcmp(animcik, "SWIM", true) && !strcmp(animismine, "SWIM_DIVE_UNDER", true)) return true;
		else if(!strcmp(animcik, "SWIM", true) && !strcmp(animismine, "SWIM_DIVE_GLIDE", true)) return true;
		else if(!strcmp(animcik, "SWIM", true) && !strcmp(animismine, "SWIM_UNDER", true)) return true;
		else if(!strcmp(animcik, "SWIM", true) && !strcmp(animismine, "SWIM_TREAD", true)) return true;
		else if(GetPlayerWeapon(playerid) != 46)
		{
			if(!strcmp(animcik, "PARACHUTE", true) && !strcmp(animismine, "FALL_SkyDive_Accel", true)) return true;
			if(!strcmp(animcik, "PARACHUTE", true) && !strcmp(animismine, "FALL_SKYDIVE", true)) return true;
		}
	}
	return false;
}

stock PosCek(playerid)
{
	new Float: x, Float: y, Float: z;
	GetPlayerPos(playerid, x, y, z);
	if((x >= -1408.0629 && y >= 2021.0587 && x <= -460.9319 && y <= 2861.4893) ||
	(x >= 1269.5886 && y >= -810.4507 && x <= 1288.8916 && y <= -800.5959) ||
	(x >= 1086.6010 && y >= -683.6998 && x <= 1103.0225 && y <= -662.1832) ||
	(x >= 169.6879 && y >= -1392.6630 && x <= 281.5444 && y <= -1168.9749) ||
	(x >= -828.3018 && y >= -2107.1487 && x <= -443.5032 && y <= -1855.6273) ||
	(x >= 1198.9982 && y >= -2407.0581 && x <= 1275.7397 && y <= -2341.6262) ||
	(x >= 2293.1467 && y >= -1432.5869 && x <= 2331.7388 && y <= -1397.6476) ||
	(x >= 1915.3196 && y >= -1236.2382 && x <= 2016.6565 && y <= -1167.9290) ||
	(x >= -2747.1692 && y >= -510.1152 && x <= -2663.2468 && y <= -411.4905) ||
	(x >= 1838.8041 && y >= 1463.2024 && x <= 2035.4167 && y <= 1703.0480) ||
	(x >= 2049.6646 && y >= 1843.3029 && x <= 2119.9021 && y <= 1983.5464) ||
	(x >= 2094.9255 && y >= 1085.2852 && x <= 2179.1790 && y <= 1183.0610) ||
	(x >= 2545.3718 && y >= 2347.7112 && x <= 2593.6794 && y <= 2403.8040))
	{
		return true;
	}
	return false;
}

stock AkaOlustur(playerid)
{
	new sql[500], ip[50];
	GetPlayerIp(playerid, ip, 50);

	format(sql, sizeof(sql), "SELECT * FROM `akalar` WHERE `ip` = '%s' AND `isim` = '%s'", ip, getName(playerid));
	mysql_query(db, sql);

	if(cache_num_rows() <= 0)
	{
		format(sql, sizeof(sql), "INSERT INTO `akalar` (`ip`, `isim`) VALUES ('%s', '%s')", ip, getName(playerid));
		mysql_query(db, sql);
	}
	return true;
}

stock YoutubeIDCek()
{
	for(new i = 499; i != 0; i--)
	{
		if(YTInfo[i][Caliniyor] == false && YTInfo[i][Sirada] != true && YTInfo[i][Doldu] != true) return i;
	}
	return -1;
}

stock IPBanListele(playerid)
{
	mysql_query(db, "SELECT * FROM `banlog`");
	if(cache_num_rows() <= 0) return Hata(playerid, "Hiç banlý oyuncu yok!");

	new sql[256], sayi, str[10000], nick[24], ip[50];

	format(sql, sizeof(sql), "SELECT * FROM `banlog` LIMIT %d, 12", GetPVarInt(playerid, "IPBANSAYFA"));
	mysql_query(db, sql);
	cache_get_row_count(sayi);

	SetPVarInt(playerid, "IPBANSAYFA", GetPVarInt(playerid, "IPBANSAYFA") + 12);
	for(new i; i < 20; i++) IPBanListe[playerid][i] = -1;

	strcat(str, ""w"#\t"w"Nick\t"w"IP\n");

	for(new i; i < 12; i++)
	{
		if(i < sayi)
		{
			cache_get_value_name_int(i, "id", IPBanListe[playerid][i]);
			cache_get_value_name(i, "banlanan", nick);
			cache_get_value_name(i, "ip", ip);
			format(str, sizeof(str), "%s"wb"»\t"ad"%s\t"w"%s\n", str, nick, ip);
		}
		else
		{
			format(str, sizeof(str), "%s{A9A9A9}---\t{A9A9A9}---------------------------\t{A9A9A9}-----------------\n", str);
		}
	}

	mysql_query(db, "SELECT * FROM `banlog`");
	if(cache_num_rows() > GetPVarInt(playerid, "IPBANSAYFA"))
	{
		strcat(str, "{A9A9A9}>> Sonraki Sayfa");
	}

	ShowPlayerDialog(playerid, DIALOG_UNBAN_IPLISTE, DIALOG_STYLE_TABLIST_HEADERS, "Unban - IPBan - Liste", str, "Aç", "Geri");
	return true;
}

stock NBanListele(playerid)
{
	mysql_query(db, "SELECT * FROM `nbanlog`");
	if(cache_num_rows() <= 0) return Hata(playerid, "Hiç N-banlý oyuncu yok!");

	new sql[256], sayi, str[10000], nick[24], gun, durum[50];

	format(sql, sizeof(sql), "SELECT * FROM `nbanlog` LIMIT %d, 12", GetPVarInt(playerid, "NBANSAYFA"));
	mysql_query(db, sql);
	cache_get_row_count(sayi);

	SetPVarInt(playerid, "NBANSAYFA", GetPVarInt(playerid, "NBANSAYFA") + 12);
	for(new i; i < 20; i++) NBanListe[playerid][i] = -1;

	strcat(str, ""w"#\t"w"Nick\t"w"Kalan Süre\n");

	for(new i; i < 12; i++)
	{
		if(i < sayi)
		{
			cache_get_value_name_int(i, "id", NBanListe[playerid][i]);
			cache_get_value_name(i, "banlanan", nick);
			cache_get_value_name_int(i, "gun", gun);
			if(gettime() > gun)
			{
				durum = ""ad"SONA ERMÝÞ";
			}
			else
			{
				format(durum, sizeof(durum), "{A9A9A9}%s", ConvertTime(gun - gettime()));
			}
			format(str, sizeof(str), "%s"wb"»\t"w"%s\t%s\n", str, nick, durum);
		}
		else
		{
			format(str, sizeof(str), "%s{A9A9A9}---\t{A9A9A9}---------------------------\t{A9A9A9}-----------------\n", str);
		}
	}

	mysql_query(db, "SELECT * FROM `nbanlog`");
	if(cache_num_rows() > GetPVarInt(playerid, "NBANSAYFA"))
	{
		strcat(str, "{A9A9A9}>> Sonraki Sayfa");
	}

	ShowPlayerDialog(playerid, DIALOG_UNBAN_NBANLISTE, DIALOG_STYLE_TABLIST_HEADERS, "Unban - NBan - Liste", str, "Aç", "Geri");
	return true;
}

stock NBanKontrol(playerid)
{
	new sql[500];
	format(sql, sizeof(sql), "SELECT * FROM `nbanlog` WHERE `banlanan` = '%s'", getName(playerid));
	mysql_query(db, sql);
	if(cache_num_rows() > 0)
	{
		new gun;
		cache_get_value_name_int(0, "gun", gun);
		if(gettime() < gun)
		{
			new dialog[5000], str[1000], banlayan[24], tarih[150], sebep[150], asilgun;
			cache_get_value_name(0, "banlayan", banlayan, 24);
			cache_get_value_name(0, "tarih", tarih, 150);
			cache_get_value_name(0, "sebep", sebep, 150);
			cache_get_value_name_int(0, "asilgun", asilgun);
			strcat(dialog, ""w"Sunucumuzdan N-banlandýnýz.\n");
			strcat(dialog, ""w"Eðer hatalý bir iþlem olduðunu düþünüyorsanýz, "wb"www.gamerlity.com "w"adresine\n");
			strcat(dialog, ""w"baþvurabilirsiniz.\n\n");
			format(str, sizeof(str), ""w"N-Banlayan Admin: "wb"%s\n", getName(playerid));
			strcat(dialog, str);
			format(str, sizeof(str), ""w"N-Banlanma Tarihi: "wb"%s\n", tarih);
			strcat(dialog, str);
			format(str, sizeof(str), ""w"N-Banlanma Sebebi: "wb"%s\n", sebep);
			strcat(dialog, str);
			format(str, sizeof(str), ""w"N-Banlanan Nick: "wb"%s\n", getName(playerid));
			strcat(dialog, str);
			format(str, sizeof(str), ""w"N-Banlanan Gün: "wb"%d\n", asilgun);
			strcat(dialog, str);
			format(str, sizeof(str), ""w"N-Banýn Açýlmasýna Kalan: "wb"%s\n\n", ConvertTime(gun - gettime()));
			strcat(dialog, str);
			strcat(dialog, ""ad"Birdahaki sefere daha dikkatli ve daha zevkli bir oyun oynamaný\ntemenni ederiz.");

			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, ""w"N-Banlandýnýz.", dialog, ""w"Kapat", "");
			NormalKick(playerid);
		}
		else
		{
			format(sql, sizeof(sql), "DELETE FROM `nbanlog` WHERE `banlanan` = '%s'", getName(playerid));
			mysql_query(db, sql);
		}
	}
	return true;
}

stock ArkadasYukle(playerid)
{
	Iter_Clear(arkadaslarim<playerid>);

	new sql[500], ekleyen_id;
	format(sql, sizeof(sql), "SELECT * FROM `arkadaslar` WHERE `eklenen` = '%d'", pData[playerid][pSQLID]);
	mysql_query(db, sql);
	
	if(cache_num_rows() > 0)
	{
		for(new i; i < cache_num_rows(); i++)
		{
		    cache_get_value_name_int(i, "ekleyen", ekleyen_id);
		    Iter_Add(arkadaslarim<playerid>, ekleyen_id);
		}
	}
	
	new eklenen_id;
	format(sql, sizeof(sql), "SELECT * FROM `arkadaslar` WHERE `ekleyen` = '%d'", pData[playerid][pSQLID]);
	mysql_query(db, sql);

	if(cache_num_rows() > 0)
	{
		for(new i; i < cache_num_rows(); i++)
		{
		    cache_get_value_name_int(i, "eklenen", eklenen_id);
		    Iter_Add(arkadaslarim<playerid>, eklenen_id);
		}
	}
	return true;
}

stock split(const strsrc[], strdest[][], delimiter)
{
	new i, li, aNum, len;
	while(i <= strlen(strsrc))
	{
		if(strsrc[i] == delimiter || i == strlen(strsrc))
		{
			len = strmid(strdest[aNum], strsrc, li, i, 128);
			strdest[aNum][len] = 0;
			li = i + 1;
			aNum++;
		}
		i++;
	}
	return true;
}

stock strcount(str[], delimiter)
{
	new c;
	for(new i, l = strlen(str); i < l; i++)
		if(str[i] == delimiter)
			c++;
	return c;
}

stock EvKaydet(evid)
{
	new sql[1024];
	format(sql, sizeof(sql), "UPDATE `evler` SET `isim` = '%s', `sahip` = '%d', `kilit` = '%d' WHERE `id` = '%d'", 
		EvInfo[evid][evIsim], EvInfo[evid][evSahip], EvInfo[evid][evKilit], evid);
	mysql_query(db, sql);
	return true;
}

stock IsYeriKaydet(id)
{
	new sql[1024];
	format(sql, sizeof(sql), "UPDATE `is_yerleri` SET `isim` = '%s', `sahip` = '%d', `kilit` = '%d', `kasa` = '%d', `level` = '%d', `bitiszaman` = '%d' WHERE `id` = '%d'", 
		iData[id][iIsim], iData[id][iSahip], iData[id][iKilit], iData[id][iKasa], iData[id][iLevel], iData[id][iBitisZaman], id);
	mysql_query(db, sql);
	return true;
}

stock GetXYInFrontOfPlayer(playerid, &Float: x, &Float: y, Float: distance)
{
    // Created by Y_Less

    new Float: a;

    GetPlayerPos(playerid, x, y, a);
    GetPlayerFacingAngle(playerid, a);

    if(GetPlayerVehicleID(playerid))
    {
        GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
    }

    x += (distance * floatsin(-a, degrees));
    y += (distance * floatcos(-a, degrees));
}

stock GetWeaponSlot(silahid)
{
	switch(silahid)
	{
		case 0, 1: return 0;
		case 2..9: return 1;
		case 10..15: return 10;
		case 16,17,18,39: return 8;
		case 22,23,24: return 2;
		case 25,26,27: return 3;
		case 28,29,32: return 4;
		case 30,31: return 5;
		case 33,34: return 6;
		case 35,36,38,37: return 7;
		case 40: return 12;
		case 41,42,43: return 9;
		case 44,45,46: return 11;
	}
	return -5;
}

stock EvObjeKaydet(evid)
{
	new sql[5000];
	format(sql, sizeof(sql), "UPDATE `evler` SET `objeler` = '%d,%f,%f,%f,%f,%f,%f|\
															  %d,%f,%f,%f,%f,%f,%f|\
															  %d,%f,%f,%f,%f,%f,%f|\
															  %d,%f,%f,%f,%f,%f,%f|\
															  %d,%f,%f,%f,%f,%f,%f|\
															  %d,%f,%f,%f,%f,%f,%f|\
															  %d,%f,%f,%f,%f,%f,%f|\
															  %d,%f,%f,%f,%f,%f,%f|\
															  %d,%f,%f,%f,%f,%f,%f|\
															  %d,%f,%f,%f,%f,%f,%f' WHERE `id` = '%d'", 
		evObjelerID[evid][0], evObjelerPos[evid][0][0], evObjelerPos[evid][0][1], evObjelerPos[evid][0][2], evObjelerPos[evid][0][3], evObjelerPos[evid][0][4], evObjelerPos[evid][0][5], 
		evObjelerID[evid][1], evObjelerPos[evid][1][0], evObjelerPos[evid][1][1], evObjelerPos[evid][1][2], evObjelerPos[evid][1][3], evObjelerPos[evid][1][4], evObjelerPos[evid][1][5], 
		evObjelerID[evid][2], evObjelerPos[evid][2][0], evObjelerPos[evid][2][1], evObjelerPos[evid][2][2], evObjelerPos[evid][2][3], evObjelerPos[evid][2][4], evObjelerPos[evid][2][5], 
		evObjelerID[evid][3], evObjelerPos[evid][3][0], evObjelerPos[evid][3][1], evObjelerPos[evid][3][2], evObjelerPos[evid][3][3], evObjelerPos[evid][3][4], evObjelerPos[evid][3][5], 
		evObjelerID[evid][4], evObjelerPos[evid][4][0], evObjelerPos[evid][4][1], evObjelerPos[evid][4][2], evObjelerPos[evid][4][3], evObjelerPos[evid][4][4], evObjelerPos[evid][4][5], 
		evObjelerID[evid][5], evObjelerPos[evid][5][0], evObjelerPos[evid][5][1], evObjelerPos[evid][5][2], evObjelerPos[evid][5][3], evObjelerPos[evid][5][4], evObjelerPos[evid][5][5], 
		evObjelerID[evid][6], evObjelerPos[evid][6][0], evObjelerPos[evid][6][1], evObjelerPos[evid][6][2], evObjelerPos[evid][6][3], evObjelerPos[evid][6][4], evObjelerPos[evid][6][5], 
		evObjelerID[evid][7], evObjelerPos[evid][7][0], evObjelerPos[evid][7][1], evObjelerPos[evid][7][2], evObjelerPos[evid][7][3], evObjelerPos[evid][7][4], evObjelerPos[evid][7][5], 
		evObjelerID[evid][8], evObjelerPos[evid][8][0], evObjelerPos[evid][8][1], evObjelerPos[evid][8][2], evObjelerPos[evid][8][3], evObjelerPos[evid][8][4], evObjelerPos[evid][8][5], 
		evObjelerID[evid][9], evObjelerPos[evid][9][0], evObjelerPos[evid][9][1], evObjelerPos[evid][9][2], evObjelerPos[evid][9][3], evObjelerPos[evid][9][4], evObjelerPos[evid][9][5], evid);
	mysql_query(db, sql);
	return true;
}

stock ApplyAnimationEx(playerid, animlib[], animname[], Float: fDelta, loop, lockx, locky, freeze, time, forcesync = 1)
{
	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);
	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);
	TextDrawShowForPlayer(playerid, AnimDurdurText0[playerid]);
	return true;
}

stock ClearAnimationsEx(playerid)
{
    ClearAnimations(playerid);
    ApplyAnimationEx(playerid, "PED", "IDLE_CHAT", 4.1, 0, 0, 0, 0, 10);
    TextDrawHideForPlayer(playerid, AnimDurdurText0[playerid]);
    return true;
}

stock PosYukle(playerid)
{
	new sql[1024], poslar[2048], pos[5][250];
	format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `sqlid` = '%d'", pData[playerid][pSQLID]);
	mysql_query(db, sql);

	cache_get_value_name(0, "poslar", poslar);
	sscanf(poslar, "p<|>s[250]s[250]s[250]s[250]s[250]", pos[0], pos[1], pos[2], pos[3], pos[4]);

	for(new i; i < 5; i++)
	{
		sscanf(pos[i], "p<,>fff", Poslar[playerid][i][0], Poslar[playerid][i][1], Poslar[playerid][i][2]);
	}
	return true;
}

stock PosKayit(playerid)
{
	new sql[1024];
	format(sql, sizeof(sql), "UPDATE `hesaplar` SET `poslar` = '%f,%f,%f|%f,%f,%f|%f,%f,%f|%f,%f,%f|%f,%f,%f'", 
		Poslar[playerid][0][0], Poslar[playerid][0][1], Poslar[playerid][0][2], 
		Poslar[playerid][1][0], Poslar[playerid][1][1], Poslar[playerid][1][2], 
		Poslar[playerid][2][0], Poslar[playerid][2][1], Poslar[playerid][2][2], 
		Poslar[playerid][3][0], Poslar[playerid][3][1], Poslar[playerid][3][2], 
		Poslar[playerid][4][0], Poslar[playerid][4][1], Poslar[playerid][4][2]);
	mysql_query(db, sql);
	return true;
}

stock KlanUyeSayisi(klanid)
{
	new uyesayisi, sql[60];
	format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `klan` = '%d'", klanid);
	mysql_query(db, sql);
	cache_get_row_count(uyesayisi);
	return uyesayisi;
}

stock GalerileriYukle()
{
	new yuklenen, id;
	mysql_query(db, "SELECT * FROM `galeriler`");

	if(cache_num_rows() > 0)
	{
		while(yuklenen < cache_num_rows())
		{
			cache_get_value_name_int(yuklenen, "id", id);
			gData[id][gID] = id;
			cache_get_value_name_float(yuklenen, "x", gData[id][gX]);
			cache_get_value_name_float(yuklenen, "y", gData[id][gY]);
			cache_get_value_name_float(yuklenen, "z", gData[id][gZ]);
			gData[id][gLabel] = CreateDynamic3DTextLabel(""ad"ARAÇ GALERÝSÝ\n"w"Ýstediðiniz aracý sýfýr bir þekilde alabilirsiniz.", -1, gData[id][gX], gData[id][gY], gData[id][gZ], 35.0);
			gData[id][gPickup] = CreateDynamicPickup(1239, 1, gData[id][gX], gData[id][gY], gData[id][gZ]);
			gData[id][gMapIcon] = CreateDynamicMapIcon(gData[id][gX], gData[id][gY], gData[id][gZ], 11, 0);
			Iter_Add(galeriler, id);
			yuklenen++;
		}
	}

	printf("<< GALERÝLER >> %d adet galeri yüklendi.", yuklenen);
	return true;
}

stock AnahtarYukle(playerid)
{
	Iter_Clear(Anahtarlar<playerid>);

	new sql[128], aracid;
	format(sql, sizeof(sql), "SELECT * FROM `anahtarlar` WHERE `sqlid` = '%d'", pData[playerid][pSQLID]);
	mysql_query(db, sql);

	if(cache_num_rows() > 0)
	{
		for(new i; i < cache_num_rows(); i++)
		{
			cache_get_value_name_int(i, "aracid", aracid);
			Iter_Add(Anahtarlar<playerid>, aracid);
		}
	}
	return true;
}

stock RekorCheck(playerid)
{
	if(Iter_Count(Player) > SunucuRekoru)
	{
		new str[512];
		SunucuRekoru = Iter_Count(Player);
		SunucuRekoru_Tarih = gettime();
		format(str, sizeof(str), ""ad"Yeni sunucu rekoru kýrýldý! Oyuncu: "wb"%d "ad"- Tarih: "wb"%s", SunucuRekoru, convertDate(SunucuRekoru_Tarih));
		SendClientMessageToAll(-1, str);
		format(str, sizeof(str), "UPDATE `sunucu_bilgileri` SET `rekor` = '%d', `rekortarih` = '%d'", SunucuRekoru, SunucuRekoru_Tarih);
		mysql_query(db, str);
	}
	else
	{
		SFM(playerid, -1, ""wb"» "w"Sunucu rekoru "wb"%d "w"oyuncuyla "wb"%s "w"tarihinde kýrýldý.", SunucuRekoru, convertDate(SunucuRekoru_Tarih));
	}
	return true;
}

stock SunucuBilgileri_Yukle()
{
	mysql_query(db, "SELECT * FROM `sunucu_bilgileri`");
	cache_get_value_name_int(0, "rekor", SunucuRekoru);
	cache_get_value_name_int(0, "rekortarih", SunucuRekoru_Tarih);
	cache_get_value_name(0, "ip", SunucuIP);
	printf("\nSunucu Bilgileri Yüklendi.\n\tRekor: %d, Rekor Tarih: %s, IP: %s\n", SunucuRekoru, convertDate(SunucuRekoru_Tarih), SunucuIP);
	return true;
}

stock SFM(playerid, color, fstring[], {Float, _}:...)
{
    static const STATIC_ARGS = 3;
    new n = (numargs() - STATIC_ARGS) * 4;
    if(n)
    {
        new message[144],arg_start,arg_end;
        #emit CONST.alt        fstring
        #emit LCTRL          5
        #emit ADD
        #emit STOR.S.pri        arg_start

        #emit LOAD.S.alt        n
        #emit ADD
        #emit STOR.S.pri        arg_end
        do
        {
            #emit LOAD.I
            #emit PUSH.pri
            arg_end -= 4;
            #emit LOAD.S.pri      arg_end
        }
        while(arg_end > arg_start);

        #emit PUSH.S          fstring
        #emit PUSH.C          144
        #emit PUSH.ADR         message

        n += 4 * 3;
        #emit PUSH.S          n
        #emit SYSREQ.C         format

        n += 4;
        #emit LCTRL          4
        #emit LOAD.S.alt        n
        #emit ADD
        #emit SCTRL          4

        if(playerid == INVALID_PLAYER_ID)
        {
            #pragma unused playerid
            return SendClientMessageToAll(color, message);
        } else {
            return SendClientMessage(playerid, color, message);
        }
    } else {
        if(playerid == INVALID_PLAYER_ID)
        {
            #pragma unused playerid
            return SendClientMessageToAll(color, fstring);
        } else {
            return SendClientMessage(playerid, color, fstring);
        }
    }
}

stock BankaAnaSayfa(playerid)
{
	new str[1024], id = pData[playerid][pBankaHesap], editlisifre[100];
	strcat(editlisifre, bData[id][bSifre]);

	for(new i = 0; i < 3; i++)
	{
		basla:
		new rand = randomEx(0, strlen(editlisifre));
		if(editlisifre[rand] == '*') goto basla;
		editlisifre[rand] = '*';
	}

	strcat(str, "#\t#\n");
	format(str, sizeof(str), "%s"wb"» "w"Hesap ID:\t"wb"%d\n"wb"» "w"Hesap Sahibi:\t"wb"%s\n"wb"» "w"Hesap Bakiyesi:\t"wb"%s TL\n"wb"» "w"Hesap Þifresi:\t"wb"%s\n"wb"» "w"Hesap Oluþturma Tarihi:\t"wb"%s\n \n"wb"» "w"Para Transfer Et\n"wb"» "w"Para Yatýr\n"wb"» "w"Para Çek\n"wb"» "w"Kredi Çek", 
		str, id, SQL_Isim_Cek(bData[id][bSahip]), FormatMoney(bData[id][bBakiye]), editlisifre, bData[id][bOlusturma]);

	ShowPlayerDialog(playerid, DIALOG_BANKA_YONETIM, DIALOG_STYLE_TABLIST_HEADERS, "Banka Hesabým", str, "Seç", "Iptal");
	return true;
}

stock GetZoneName(Float: x, Float: y, Float: z)
{
	new zone[28];
 	for(new i = 0; i < sizeof(SAZones); i++)
 	{
		if(x >= SAZones[i][SAZONE_AREA][0] && x <= SAZones[i][SAZONE_AREA][3] && y >= SAZones[i][SAZONE_AREA][1] && y <= SAZones[i][SAZONE_AREA][4] && z >= SAZones[i][SAZONE_AREA][2] && z <= SAZones[i][SAZONE_AREA][5])
		{
		    strcat(zone, SAZones[i][SAZONE_NAME]);
		    return zone;
		}
	}
	strcat(zone, "Unknown");
	return zone;
}

stock IsVehicleEmpty(vehicleid)
{
	foreach(new i: Player) if(IsPlayerInVehicle(i, vehicleid)) return false;
	return true;
}

static CheckSpeed(playerid)
{
    new Keys, ud, lr;
    GetPlayerKeys(playerid, Keys, ud, lr);

	if(ud == KEY_UP && lr != KEY_LEFT && lr != KEY_RIGHT)
	{
		new Float: Velocity[3];
		GetPlayerVelocity(playerid, Velocity[0], Velocity[1], Velocity[2]);
	    Velocity[0] = floatsqroot((Velocity[0] * Velocity[0]) + (Velocity[1] * Velocity[1]) + (Velocity[2] * Velocity[2]));
		if(Velocity[0] >= 0.11 && Velocity[0] <= 0.13) return true;
	}
	return false;
}

stock DriverCheck(vehicleid)
{
	foreach(new i: Player)
	{
		if(GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == vehicleid) return true;
	}
	return false;
}

stock code(txt[])
{
    new converted_txt[1024];
    strcat(converted_txt, txt);
    for(new i = 0; i < 1024; i++)
    {
        switch(converted_txt[i])
        {
            case 'ð': converted_txt[i] = 'g';
            case 'Ð': converted_txt[i] = 'G';
            case 'þ': converted_txt[i] = 's';
            case 'Þ': converted_txt[i] = 'S';
            case 'ý': converted_txt[i] = 'i';
            case 'ö': converted_txt[i] = 'o';
            case 'Ö': converted_txt[i] = 'O';
            case 'ç': converted_txt[i] = 'c';
            case 'Ç': converted_txt[i] = 'C';
            case 'ü': converted_txt[i] = 'u';
            case 'Ü': converted_txt[i] = 'U';
            case 'Ý': converted_txt[i] = 'I';
        }
    }
    return converted_txt;
}

stock TextMesaji(const text[])
{
    foreach(new i: Player) PlayerPlaySound(i, 5205, 0.0, 0.0, 0.0);
    for(new line; line < 4; line++)
   	{
		MessageStr[line] = MessageStr[line + 1];
		TextDrawSetString(OlayText[line], MessageStr[line]);
  	}
    format(MessageStr[4], 1024, "%s",text);
    TextDrawSetString(OlayText[4], MessageStr[4]);
    for(new i; i < 5; i++)
	{
		if(EVT[i] != -1)
		{
			KillTimer(EVT[i]);
		    EVT[i] = -1;
	    }
    }
    EVT[0] = SetTimer("MesajSil0", 3500, false);
    return true;
}

stock BasarimVer(playerid, basarimid)
{
	if(Basarimlarim[playerid][basarimid] == 0)
	{
		new str[512];
		Basarimlarim[playerid][basarimid] = 1;
		format(str, sizeof(str), "Tebrikler! "wb"%s "w"adlý baþarýmý kazandýnýz. "ad"Ödül: %d skor ve %s TL", Basarimlar[basarimid][bIsim], Basarimlar[basarimid][bSkor], FormatMoney(Basarimlar[basarimid][bPara]));
		AdminBilgi(playerid, str);
		GivePlayerMoney(playerid, Basarimlar[basarimid][bPara]);
		SetPlayerScore(playerid, GetPlayerScore(playerid) + Basarimlar[basarimid][bSkor]);
		pData[playerid][pExp] += Basarimlar[basarimid][bExp];
		format(str, sizeof(str), "UPDATE `basarimlar` SET `basarim%d` = '1' WHERE `sqlid` = '%d'", basarimid, pData[playerid][pSQLID]);
		mysql_query(db, str);
	}
	return true;
}

stock BasarimYukle(playerid)
{
	new sql[128];
	format(sql, sizeof(sql), "SELECT * FROM `basarimlar` WHERE `sqlid` = '%d'", pData[playerid][pSQLID]);
	mysql_query(db, sql);

	for(new i = 0; i < sizeof(Basarimlar); i++)
	{
		format(sql, sizeof(sql), "basarim%d", i);
		cache_get_value_name_int(0, sql, Basarimlarim[playerid][i]);
	}
	return true;
}

stock GetWeaponNameEx(weaponid)
{
	new weaponstr[45];
	switch(weaponid)
	{
		case 0: weaponstr = "Fist";
		case 18: weaponstr = "Molotov Cocktail";
		case 44: weaponstr = "Night Vision Goggles";
		case 45: weaponstr = "Thermal Goggles";
		default: GetWeaponName(weaponid, weaponstr, sizeof(weaponstr));
	}
	return weaponstr;
}

stock BankaHesaplariniYukle()
{
	for(new i = 0; i < sizeof(BankaPoslari); i++)
	{
		CreateDynamicMapIcon(BankaPoslari[i][0], BankaPoslari[i][1], BankaPoslari[i][2], 52, 0);
		CreateDynamicPickup(1274, 1, BankaPoslari[i][0], BankaPoslari[i][1], BankaPoslari[i][2], -1, -1, -1);
		CreateDynamicPickup(1318, 1, 2315.5051, 0.3431, 26.7422, -1, -1, -1);
		CreateDynamic3DTextLabel("{00E1FF}GL BANK\n\n{999999}(Ýçeri girmek için '"wb"F{999999}' tuþuna basýnýz.)", -1, BankaPoslari[i][0], BankaPoslari[i][1], BankaPoslari[i][2], 35.0);
	}
	CreateDynamic3DTextLabel(""wb"» "w"Ýþlemlerinizi gerçekleþtirmek için "wb"/hesabim "w"yazýnýz.", -1, 2310.7258, -8.7045, 26.7422, 10.0);

	new yuklenen, id;
	mysql_query(db, "SELECT * FROM `banka_hesaplari`");
	if(cache_num_rows() > 0)
	{
		while(yuklenen < cache_num_rows())
		{
			cache_get_value_name_int(yuklenen, "id", id);
			bData[id][bId] = id;
			cache_get_value_name_int(yuklenen, "sahip", bData[id][bSahip]);
			cache_get_value_name_int(yuklenen, "bakiye", bData[id][bBakiye]);
			cache_get_value_name(yuklenen, "sifre", bData[id][bSifre], 100);
			cache_get_value_name(yuklenen, "olusturulma", bData[id][bOlusturma], 100);
			Iter_Add(bankahesaplari, id);
			yuklenen++;
		}
	}
	printf("<< BANKA HESAPLARI >> %d adet banka hesabý yüklendi.", yuklenen);
	return true;
}

stock FormatMoney(para)
{
	new string[64], sayi;
	format(string, sizeof(string), "%i", para);
	for(new i = strlen(string); i > 0; i--)
	{
	    sayi++;
	    if(sayi == 4) strins(string, ".", i), sayi = 1;
	}
	return string;
}

stock randomEx(min, max)
{
	new rand = random(max - min + 1) + min;
	return rand;
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

stock IsValidVehicleModel(const modelid)
	return(399 < modelid < 612);

stock GetVehicleMaxSpeed(const modelid)
{
	if(IsValidVehicleModel(modelid)) return uf_VehicleSpeeds[modelid - 400];
	return false;
}

stock KlanBaslik(klanid)
{
	new satir[150];
	format(satir, sizeof(satir), "{%06x}[%s] - %s", KlanRenkleri[kData[klanid][kRenk]] >>> 8, kData[klanid][kTag], kData[klanid][kIsim]);
	return satir;
}

stock KlanMesaji(klan_id, mesaj[])
{
	foreach(new i: Player)
	{
		if(pData[i][pKlan] == klan_id)
		{
			SendClientMessage(i, -1, mesaj);
		}
	}
	return true;
}

stock GetPlayerID(const isim[])
{
	foreach(new i: Player)
	{
 		new pName[MAX_PLAYER_NAME];
   		GetPlayerName(i, pName, sizeof(pName));
     	if(strcmp(isim, pName, true) == 0)
      	{
       		return i;
       	}
	}
	return -1;
}

stock KlanMenusu(playerid)
{
	if(pData[playerid][pKlan] == -1) return true;
	new dialog[1000], str[1000], id = pData[playerid][pKlan];
	strcat(dialog, ""w"#\t"w"#\t"w"#\n");
	format(str, sizeof(str), ""wb"» "w"Klan Leveli\t-"wb"%d"w"-\t("wb"%d"w"/"wb"%d"w")\n", kData[id][kLevel], kData[id][kExp], kData[id][kMaxExp]);
	strcat(dialog, str);

	new za_ = kData[pData[playerid][pKlan]][kMaxExp] / 30, Bar[5000];
	new donusturulenHiz = kData[pData[playerid][pKlan]][kExp] / za_;
	Bar[0] = '[';
	for(new x = 0; x < 30; x++)
	{
		if(x < donusturulenHiz)
		{
			Bar[x + 1] = 'I';
		}
		else
		{
			Bar[x + 1] = ' ';
		}
		if(x == 29) Bar[x + 1] = ']';
	}

	format(str, sizeof(str), ""wb"» "w"Level Bar:\t"ad"%s\n", Bar);
	strcat(dialog, str);
	format(str, sizeof(str), ""wb"» "w"Klan Bankasý\t"wb"%s TL\n", FormatMoney(kData[id][kKasa]));
	strcat(dialog, str);
	strcat(dialog, " \n");
	strcat(dialog, ""wb"» "w"Klana Para Yatýr\n");
	strcat(dialog, ""wb"» "w"Klana EXP Yatýr\n");
	strcat(dialog, " \n");
	strcat(dialog, ""wb"» "w"Klan Bilgileri\n");
	strcat(dialog, ""wb"» "w"Klan Üyeleri\n");
	strcat(dialog, ""wb"» "w"Klan Baþvurularý\n");
	strcat(dialog, " \n");
	strcat(dialog, ""wb"» "w"Klana Üye Al\n");
	strcat(dialog, ""wb"» "w"Klandan Üye At\n");
	strcat(dialog, " \n");
	strcat(dialog, ""wb"» "w"Klandan Ayrýl\n");
	strcat(dialog, ""wb"» "w"Klaný Kapat");
	ShowPlayerDialog(playerid, DIALOG_KLAN_GENEL, DIALOG_STYLE_TABLIST_HEADERS, KlanBaslik(pData[playerid][pKlan]), dialog, ""w"Seç", ""w"Kapat");
	return true;
}

stock KlanlariYukle()
{
	new id, yuklenen;
	mysql_query(db, "SELECT * FROM `klanlar`");
	while(yuklenen < cache_num_rows())
	{
		cache_get_value_name_int(yuklenen, "id", id);
		kData[id][kID] = id;
		cache_get_value_name(yuklenen, "isim", kData[id][kIsim], 50);
		cache_get_value_name(yuklenen, "tag", kData[id][kTag], 10);
		cache_get_value_name_int(yuklenen, "kasa", kData[id][kKasa]);
		cache_get_value_name_int(yuklenen, "renk", kData[id][kRenk]);
		cache_get_value_name_int(yuklenen, "level", kData[id][kLevel]);
		cache_get_value_name_int(yuklenen, "exp", kData[id][kExp]);
		cache_get_value_name_int(yuklenen, "maxexp", kData[id][kMaxExp]);
		cache_get_value_name(yuklenen, "kurulus_tarihi", kData[id][kKurulus_Tarihi], 100);
		Iter_Add(klanlar, id);
		yuklenen++;
	}

	printf("<< KLANLAR >> Toplam %d klan yüklendi.", yuklenen);
	return true;
}

stock LabelUpdate()
{
	new str[512];
	foreach(new i: Player)
	{
		if(pData[i][pGiris] == true)
		{
			new godstr[50];
			switch(pData[i][pGod])
			{
				case true: godstr = "{FF0000}[= "ad"GOD AKTIF {FF0000}=]";
				case false: godstr = "";
			}
			if(pData[i][pAdmin] > 0 && pData[i][pKlan] == -1)
			{
				format(str, sizeof(str), ""ad"%d Seviye Admin\n"w"Level: "wb"%d "w"("wb"%d"w"/"wb"%d"w")\n%s", pData[i][pAdmin], pData[i][pLevel], pData[i][pExp], pData[i][pMaxExp], godstr);
				Update3DTextLabelText(pData[i][pLabel], -1, str);
			}
			else if(pData[i][pAnim] > 0 && pData[i][pKlan] == -1)
			{
				format(str, sizeof(str), ""ad"%d Seviye Animatör\n"w"Level: "wb"%d "w"("wb"%d"w"/"wb"%d"w")\n%s", pData[i][pAnim], pData[i][pLevel], pData[i][pExp], pData[i][pMaxExp], godstr);
				Update3DTextLabelText(pData[i][pLabel], -1, str);
			}
			else if(pData[i][pAnim] == 0 && pData[i][pAdmin] == 0 && pData[i][pKlan] == -1)
			{
				format(str, sizeof(str), ""w"Level: "wb"%d "w"("wb"%d"w"/"wb"%d"w")\n%s", pData[i][pLevel], pData[i][pExp], pData[i][pMaxExp], godstr);
				Update3DTextLabelText(pData[i][pLabel], -1, str);
			}
			////////////////////////
			else if(pData[i][pAdmin] > 0 && pData[i][pKlan] != -1)
			{
				format(str, sizeof(str), ""ad"%d Seviye Admin\n"w"Level: "wb"%d "w"("wb"%d"w"/"wb"%d"w")\n{%06x}[%s] - %s (%s)\n%s", pData[i][pAdmin], pData[i][pLevel], pData[i][pExp], pData[i][pMaxExp], KlanRenkleri[kData[pData[i][pKlan]][kRenk]] >>> 8, kData[pData[i][pKlan]][kTag], kData[pData[i][pKlan]][kIsim], KlanRutbeleri[pData[i][pKlanRutbe]], godstr);
				Update3DTextLabelText(pData[i][pLabel], -1, str);
			}
			else if(pData[i][pAnim] > 0 && pData[i][pKlan] != -1)
			{
				format(str, sizeof(str), ""ad"%d Seviye Animatör\n"w"Level: "wb"%d "w"("wb"%d"w"/"wb"%d"w")\n{%06x}[%s] - %s (%s)\n%s", pData[i][pAnim], pData[i][pLevel], pData[i][pExp], pData[i][pMaxExp], KlanRenkleri[kData[pData[i][pKlan]][kRenk]] >>> 8, kData[pData[i][pKlan]][kTag], kData[pData[i][pKlan]][kIsim], KlanRutbeleri[pData[i][pKlanRutbe]], godstr);
				Update3DTextLabelText(pData[i][pLabel], -1, str);
			}
			else if(pData[i][pAnim] == 0 && pData[i][pAdmin] == 0 && pData[i][pKlan] != -1)
			{
				format(str, sizeof(str), ""w"Level: "wb"%d "w"("wb"%d"w"/"wb"%d"w")\n{%06x}[%s] - %s (%s)\n%s", pData[i][pLevel], pData[i][pExp], pData[i][pMaxExp], KlanRenkleri[kData[pData[i][pKlan]][kRenk]] >>> 8, kData[pData[i][pKlan]][kTag], kData[pData[i][pKlan]][kIsim], KlanRutbeleri[pData[i][pKlanRutbe]], godstr);
				Update3DTextLabelText(pData[i][pLabel], -1, str);
			}
		}
	}
	return true;
}

stock EvleriYukle()
{
	new yuklenen, id, str[1024], kilitstr[75], sahipstr[100], objestr[5000], objelerayri[10][5000];
	mysql_query(db, "SELECT * FROM `evler`");

	yuklenen = 0;

	while(yuklenen < cache_num_rows())
	{
		cache_get_value_name_int(yuklenen, "id", id);
		EvInfo[id][evID] = id;
		cache_get_value_name(yuklenen, "isim", EvInfo[id][evIsim], 100);
		cache_get_value_name_int(yuklenen, "fiyat", EvInfo[id][evFiyat]);
		cache_get_value_name_int(yuklenen, "sahip", EvInfo[id][evSahip]);
		cache_get_value_name_float(yuklenen, "x", EvInfo[id][evX]);
		cache_get_value_name_float(yuklenen, "y", EvInfo[id][evY]);
		cache_get_value_name_float(yuklenen, "z", EvInfo[id][evZ]);
		cache_get_value_name_int(yuklenen, "kilit", EvInfo[id][evKilit]);
		cache_get_value_name_int(yuklenen, "interior", EvInfo[id][evInterior]);
		cache_get_value_name(yuklenen, "objeler", objestr);

		sscanf(objestr, "p<|>s[500]s[500]s[500]s[500]s[500]s[500]s[500]s[500]s[500]s[500]", 
			objelerayri[0], objelerayri[1], objelerayri[2], objelerayri[3], objelerayri[4], objelerayri[5], 
			objelerayri[6], objelerayri[7], objelerayri[8], objelerayri[9]);

		for(new i; i < 10; i++)
		{
			sscanf(objelerayri[i], "p<,>dffffff", evObjelerID[id][i], evObjelerPos[id][i][0], evObjelerPos[id][i][1],
				evObjelerPos[id][i][2], evObjelerPos[id][i][3], evObjelerPos[id][i][4], evObjelerPos[id][i][5]);
		}

		for(new q; q < 10; q++)
		{
			if(evObjelerID[id][q] != -1)
			{
				EvInfo[id][evObjeler][q] = CreateDynamicObject(evObjelerID[id][q], evObjelerPos[id][q][0], evObjelerPos[id][q][1], evObjelerPos[id][q][2], evObjelerPos[id][q][3], evObjelerPos[id][q][4], evObjelerPos[id][q][5], EvInfo[id][evID]);
			}
		}

		if(EvInfo[id][evInterior] == 12)
		{
			EvInfo[id][evCikisX] = 2324.53;
			EvInfo[id][evCikisY] = -1149.54;
			EvInfo[id][evCikisZ] = 1050.71;
		}
		else if(EvInfo[id][evInterior] == 3)
		{
			EvInfo[id][evCikisX] = 235.34;
			EvInfo[id][evCikisY] = 1186.68;
			EvInfo[id][evCikisZ] = 1080.26;
		}
		else if(EvInfo[id][evInterior] == 11)
		{
			EvInfo[id][evCikisX] = 2283.04;
			EvInfo[id][evCikisY] = -1140.28;
			EvInfo[id][evCikisZ] = 1050.90;
		}
		switch(EvInfo[id][evKilit])
		{
			case 0: kilitstr = "Açýk";
			case 1: kilitstr = "Kilitli";
		}
		EvInfo[id][evPickup] = CreateDynamicPickup(1273, 1, EvInfo[id][evX], EvInfo[id][evY], EvInfo[id][evZ]);
		EvInfo[id][evMapIcon] = CreateDynamicMapIcon(EvInfo[id][evX], EvInfo[id][evY], EvInfo[id][evZ], 31, 0);
		switch(EvInfo[id][evSahip])
		{
			case -1: sahipstr = "Yok";
			default: format(sahipstr, sizeof(sahipstr), "%s", SQL_Isim_Cek(EvInfo[id][evSahip]));
		}
		format(str, sizeof(str), ""wb"%s\n"w"Ev Fiyatý: "wb"%s TL\n"w"Ev Sahibi: "wb"%s\n"w"Ev Durumu: "wb"%s\n\n{999999}(Ýçeri girmek için '"wb"F{999999}' tuþuna basýnýz.)",
			EvInfo[id][evIsim], FormatMoney(EvInfo[id][evFiyat]), sahipstr, kilitstr);
		EvInfo[id][evLabel] = CreateDynamic3DTextLabel(str, -1, EvInfo[id][evX], EvInfo[id][evY], EvInfo[id][evZ], 35.0);
		mysql_query(db, "SELECT * FROM `evler`");
		Iter_Add(evler, id);
		yuklenen++;
	}

	printf("<< EVLER >> Toplam %d ev yüklendi.", yuklenen);
	return true;
}

stock EvLabelGuncelle(evivd)
{
	new kilitstr[75], sahipstr[100], str[512];
	switch(EvInfo[evivd][evKilit])
	{
		case 0: kilitstr = "Açýk";
		case 1: kilitstr = "Kilitli";
	}
	switch(EvInfo[evivd][evSahip])
	{
		case -1: sahipstr = "Yok";
		default: format(sahipstr, sizeof(sahipstr), "%s", SQL_Isim_Cek(EvInfo[evivd][evSahip]));
	}
	format(str, sizeof(str), ""wb"%s\n"w"Ev Fiyatý: "wb"%s TL\n"w"Ev Sahibi: "wb"%s\n"w"Ev Durumu: "wb"%s\n\n{999999}(Ýçeri girmek için '"wb"F{999999}' tuþuna basýnýz.)",
		EvInfo[evivd][evIsim], FormatMoney(EvInfo[evivd][evFiyat]), sahipstr, kilitstr);
	UpdateDynamic3DTextLabelText(EvInfo[evivd][evLabel], -1, str);
	return true;
}

stock PlakaYarat(aracid, plakano = -1)
{
	new plaka[50];
	if(plakano == -1)
	{
		new id = aracid, harfleXr[25];
		new harfler[23] = "ABCDEFGHIJKLMNOPRSTYVZ";
		for(new i = 0; i < 3; i++)
		{
			harfleXr[i] = harfler[random(21)];
		}
		format(plaka, sizeof(plaka), "34 %s %04d", harfleXr, id);
	}
	else
	{
		new id = aracid, harfleXr[25];
		new harfler[23] = "ABCDEFGHIJKLMNOPRSTYVZ";
		for(new i = 0; i < 3; i++)
		{
			harfleXr[i] = harfler[random(21)];
		}
		format(plaka, sizeof(plaka), "%02d %s %04d", plakano, harfleXr, id);
	}
	return plaka;
}

stock spamProtect(playerid, isim[], saniye)
{
	new edit[250], str[512];
	format(edit, sizeof(edit), "spamkoruma_%s", isim);

	if(GetPVarInt(playerid, edit) > gettime())
	{
		format(str, sizeof(str), "Bu komutu tekrar kullanabilmek için "wb"%s "w"beklemelisiniz.", ConvertTime(GetPVarInt(playerid, edit) - gettime()));
		Hata(playerid, str);
		return true;
	}
	else
	{
		SetPVarInt(playerid, edit, gettime() + saniye);
	}
	return false;
}

stock OyuncuKaydet(playerid)
{
	new sql[5000];
	format(sql, sizeof(sql), "UPDATE `hesaplar` SET `skor` = '%d', `para` = '%d', `olum` = '%d', `oldurme` = '%d', `admin` = '%d'\
		, `anim` = '%d', `arac` = '%d', `isyeri` = '%d', `ev` = '%d', `online_suresi` = '%d', `klan` = '%d', `klanrutbe` = '%d'\
		 , `exp` = '%d', `maxexp` = '%d', `level` = '%d', `bankahesap` = '%d', `mute` = '%d'\
		 , `spawnsilahlari` = '%d|%d|%d|%d|%d|%d', `jail` = '%d' WHERE `sqlid` = '%d'", GetPlayerScore(playerid), GetPlayerMoney(playerid), pData[playerid][pOlum],
		pData[playerid][pOldurme], pData[playerid][pAdmin], pData[playerid][pAnim], pData[playerid][pArac], pData[playerid][pIsYeri], pData[playerid][pEv], pData[playerid][pOnlineSuresi], pData[playerid][pKlan], pData[playerid][pKlanRutbe], pData[playerid][pExp], pData[playerid][pMaxExp], pData[playerid][pLevel], pData[playerid][pBankaHesap], pData[playerid][pMute], 
		pData[playerid][pSilahlar][0], pData[playerid][pSilahlar][1], pData[playerid][pSilahlar][2], pData[playerid][pSilahlar][3], pData[playerid][pSilahlar][4], pData[playerid][pSilahlar][5], pData[playerid][pJail], pData[playerid][pSQLID]);
	mysql_query(db, sql);
	return true;
}

stock IsYeriLabelGuncelle(isyeri_id)
{
	new sahipstr[75], KilitDurum[75], str[512];

	switch(iData[isyeri_id][iSahip])
	{
		case -1: format(sahipstr, sizeof(sahipstr), ""wb"Yok");
		default: format(sahipstr, sizeof(sahipstr), ""wb"%s", SQL_Isim_Cek(iData[isyeri_id][iSahip]));
	}

	switch(iData[isyeri_id][iKilit])
	{
		case 0:
		{
			KilitDurum = ""ad"Açýk";
		}
		case 1:
		{
			KilitDurum = ""r"Kapalý";
		}
	}

	format(str, sizeof(str), "\
		"wb"%s\n\
		"w"Ýþyeri Fiyatý: "wb"%s TL\n\
		"w"Ýþyeri Durumu: "wb"%s\n\
		"w"Ýþyeri Leveli: "wb"%d\n\
		"w"Ýþyeri Sahibi: %s\n\n\
		{999999}(Ýçeri girmek için '"wb"F{999999}' tuþuna basýnýz.)", iData[isyeri_id][iIsim], FormatMoney(iData[isyeri_id][iFiyat]), KilitDurum, iData[isyeri_id][iLevel], sahipstr);
	UpdateDynamic3DTextLabelText(iData[isyeri_id][iLabel], -1, str);
	return true;
}

stock SistemBan(playerid, sebep[])
{
	new ip[50], dialog[2048], str[850], string[512];
	GetPlayerIp(playerid, ip, 50);

	strcat(dialog, ""w"Sunucumuzdan banlandýnýz.\n");
	strcat(dialog, ""w"Eðer hatalý bir iþlem olduðunu düþünüyorsanýz, "wb"www.gamerlity.com "w"adresine\n");
	strcat(dialog, ""w"baþvurabilirsiniz.\n\n");
	format(str, sizeof(str), ""w"Banlayan Admin: "wb"Sistem\n");
	strcat(dialog, str);
	format(str, sizeof(str), ""w"Banlanma Tarihi: "wb"%s\n", convertDate(gettime()));
	strcat(dialog, str);
	format(str, sizeof(str), ""w"Banlanma Sebebi: "wb"%s\n", sebep);
	strcat(dialog, str);
	format(str, sizeof(str), ""w"Banlanan IP Adresi: "wb"%s\n\n", ip);
	strcat(dialog, str);
	strcat(dialog, ""ad"Birdahaki sefere daha dikkatli ve daha zevkli bir oyun oynamaný\ntemenni ederiz.");

	format(string, sizeof(string), "Yetkili "wb"Sistem "w"sizi sunucudan banladý!");
	AdminBilgi(playerid, string);
	printf("<< SISTEM BAN >> Sistem » %s (%s)", getName(playerid), sebep);

	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, ""w"Banlandýnýz.", dialog, ""w"Kapat", "");

	format(str, sizeof(str), "~p~[BAN] ~w~~h~~h~Sistem ~p~>> ~w~~h~~h~%s ~p~(Sebep: %s)", getName(playerid), sebep);
	TextMesaji(code(str));

	if(pData[playerid][pAdmin] == 10) return true;
	format(string, sizeof(string), "banip %s", ip);
	SendRconCommand(string);
	SendRconCommand("reloadbans");
	NormalKick(playerid);
	return true;
}

stock SistemKick(playerid, sebep[])
{
	new dialog[2048], str[850];
	strcat(dialog, ""w"Sunucumuzdan kicklendiniz.\n");
	strcat(dialog, ""w"Eðer hatalý bir iþlem olduðunu düþünüyorsanýz, "wb"www.gamerlity.com "w"adresine\n");
	strcat(dialog, ""w"baþvurabilirsiniz.\n\n");
	format(str, sizeof(str), ""w"Kickleyen Admin: "wb"Sistem\n");
	strcat(dialog, str);
	format(str, sizeof(str), ""w"Kicklenme Tarihi: "wb"%s\n", convertDate(gettime()));
	strcat(dialog, str);
	format(str, sizeof(str), ""w"Kicklenme Sebebi: "wb"%s\n\n", sebep);
	strcat(dialog, str);
	strcat(dialog, ""ad"Birdahaki sefere daha dikkatli ve daha zevkli bir oyun oynamaný\ntemenni ederiz.");

	format(str, sizeof(str), "Yetkili "wb"Sistem "w"sizi sunucudan kickledi!");
	AdminBilgi(playerid, str);
	printf("<< SISTEM KICK >> Sistem » %s (%s)", getName(playerid), sebep);

	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, ""w"Kicklendiniz.", dialog, ""w"Kapat", "");

	format(str, sizeof(str), "~p~[KICK] ~w~~h~~h~Sistem ~p~>> ~w~~h~~h~%s ~p~(Sebep: %s)", getName(playerid), sebep);
	TextMesaji(code(str));

	if(pData[playerid][pAdmin] == 10) return true;
	NormalKick(playerid);
	return true;
}

stock SQL_Isim_Cek(sqlid)
{
	new sql[500], isim[50];
	format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `sqlid` = '%d'", sqlid);
	mysql_query(db, sql);

	cache_get_value_name(0, "kullaniciadi", isim, 50);
	return isim;
}

stock NormalKick(playerid)
{
	if(pData[playerid][pAdmin] == 10) return true;
	new ping = GetPlayerPing(playerid) + 150;
	SetTimerEx("Kick_Timer", (ping > 500 ? 500 : ping), false, "d", playerid);
	return true;
}

stock IsYerleriniYukle()
{
	new sql[500], yuklenen = 0, id, str[512], KilitDurum[75], sahipstr[75];
	format(sql, sizeof(sql), "SELECT * FROM `is_yerleri`");
	mysql_query(db, sql);

	while(yuklenen < cache_num_rows())
	{
		cache_get_value_name_int(yuklenen, "id", id);
		cache_get_value_name(yuklenen, "isim", iData[id][iIsim], 128);
		cache_get_value_name_int(yuklenen, "sahip", iData[id][iSahip]);
		cache_get_value_name_int(yuklenen, "fiyat", iData[id][iFiyat]);
		cache_get_value_name_float(yuklenen, "x", iData[id][iX]);
		cache_get_value_name_float(yuklenen, "y", iData[id][iY]);
		cache_get_value_name_float(yuklenen, "z", iData[id][iZ]);
		cache_get_value_name_int(yuklenen, "kilit", iData[id][iKilit]);
		cache_get_value_name_int(yuklenen, "interior", iData[id][iInterior]);
		cache_get_value_name_int(yuklenen, "kasa", iData[id][iKasa]);
		cache_get_value_name_int(yuklenen, "level", iData[id][iLevel]);
		cache_get_value_name_int(yuklenen, "bitiszaman", iData[id][iBitisZaman]);

		if(iData[id][iInterior] == 1)
		{
			iData[id][iCikisX] = -25.884498;
			iData[id][iCikisY] = -185.868988;
			iData[id][iCikisZ] = 1003.546875;
			CreateDynamicPickup(1318, 1, iData[id][iCikisX], iData[id][iCikisY], iData[id][iCikisZ]);
			CreateDynamic3DTextLabel("{999999}(Çýkmak için '"wb"F{999999}' tuþuna basýnýz.)", -1, iData[id][iCikisX], iData[id][iCikisY], iData[id][iCikisZ], 35.0);
		}
		else if(iData[id][iInterior] == 2)
		{
			iData[id][iCikisX] = 6.091179;
			iData[id][iCikisY] = -29.271898;
			iData[id][iCikisZ] = 1003.549438;
			CreateDynamicPickup(1318, 1, iData[id][iCikisX], iData[id][iCikisY], iData[id][iCikisZ]);
			CreateDynamic3DTextLabel("{999999}(Çýkmak için '"wb"F{999999}' tuþuna basýnýz.)", -1, iData[id][iCikisX], iData[id][iCikisY], iData[id][iCikisZ], 35.0);
		}
		else if(iData[id][iInterior] == 3)
		{
			iData[id][iCikisX] = 286.148986;
			iData[id][iCikisY] = -40.644397;
			iData[id][iCikisZ] = 1001.515625;
			CreateDynamicPickup(1318, 1, iData[id][iCikisX], iData[id][iCikisY], iData[id][iCikisZ]);
			CreateDynamic3DTextLabel("{999999}(Çýkmak için '"wb"F{999999}' tuþuna basýnýz.)", -1, iData[id][iCikisX], iData[id][iCikisY], iData[id][iCikisZ], 35.0);
		}
		else if(iData[id][iInterior] == 4)
		{
			iData[id][iCikisX] = 286.800994;
			iData[id][iCikisY] = -82.547599;
			iData[id][iCikisZ] = 1001.515625;
			CreateDynamicPickup(1318, 1, iData[id][iCikisX], iData[id][iCikisY], iData[id][iCikisZ]);
			CreateDynamic3DTextLabel("{999999}(Çýkmak için '"wb"F{999999}' tuþuna basýnýz.)", -1, iData[id][iCikisX], iData[id][iCikisY], iData[id][iCikisZ], 35.0);
		}
		else if(iData[id][iInterior] == 5)
		{
			iData[id][iCikisX] = 373.825653;
			iData[id][iCikisY] = -117.270904;
			iData[id][iCikisZ] = 1001.499511;
			CreateDynamicPickup(1318, 1, iData[id][iCikisX], iData[id][iCikisY], iData[id][iCikisZ]);
			CreateDynamic3DTextLabel("{999999}(Çýkmak için '"wb"F{999999}' tuþuna basýnýz.)", -1, iData[id][iCikisX], iData[id][iCikisY], iData[id][iCikisZ], 35.0);
		}
		else if(iData[id][iInterior] == 6)
		{
			iData[id][iCikisX] = 369.579528;
			iData[id][iCikisY] = -4.487294;
			iData[id][iCikisZ] = 1001.858886;
			CreateDynamicPickup(1318, 1, iData[id][iCikisX], iData[id][iCikisY], iData[id][iCikisZ]);
			CreateDynamic3DTextLabel("{999999}(Çýkmak için '"wb"F{999999}' tuþuna basýnýz.)", -1, iData[id][iCikisX], iData[id][iCikisY], iData[id][iCikisZ], 35.0);
		}
		else if(iData[id][iInterior] == 7)
		{
			iData[id][iCikisX] = 375.962463;
			iData[id][iCikisY] = -65.816848;
			iData[id][iCikisZ] = 1001.507812;
			CreateDynamicPickup(1318, 1, iData[id][iCikisX], iData[id][iCikisY], iData[id][iCikisZ]);
			CreateDynamic3DTextLabel("{999999}(Çýkmak için '"wb"F{999999}' tuþuna basýnýz.)", -1, iData[id][iCikisX], iData[id][iCikisY], iData[id][iCikisZ], 35.0);
		}

		iData[id][iID] = id;
		iData[id][iPickup] = CreateDynamicPickup(1272, 1, iData[id][iX], iData[id][iY], iData[id][iZ]);
		switch(iData[id][iKilit])
		{
			case 0:
			{
				KilitDurum = ""ad"Açýk";
			}
			case 1:
			{
				KilitDurum = ""r"Kapalý";
			}
		}
		iData[id][iMapIcon] = CreateDynamicMapIcon(iData[id][iX], iData[id][iY], iData[id][iZ], 51, 0);
		switch(iData[id][iSahip])
		{
			case -1: format(sahipstr, sizeof(sahipstr), ""wb"Yok");
			default: format(sahipstr, sizeof(sahipstr), ""wb"%s", SQL_Isim_Cek(iData[id][iSahip]));
		}
		format(str, sizeof(str), "\
			"wb"%s\n\
			"w"Ýþyeri Fiyatý: "wb"%s TL\n\
			"w"Ýþyeri Durumu: "wb"%s\n\
			"w"Ýþyeri Leveli: "wb"%d\n\
			"w"Ýþyeri Sahibi: %s\n\n\
			{999999}(Ýçeri girmek için '"wb"F{999999}' tuþuna basýnýz.)", iData[id][iIsim], FormatMoney(iData[id][iFiyat]), KilitDurum, iData[id][iLevel], sahipstr);
		iData[id][iLabel] = CreateDynamic3DTextLabel(str, -1, iData[id][iX], iData[id][iY], iData[id][iZ], 35.0);
		mysql_query(db, "SELECT * FROM `is_yerleri`");
		Iter_Add(isyerleri, id);
		yuklenen++;
	}

	printf("<< ÝÞYERLERÝ >> Toplam %d iþyeri yüklendi.", yuklenen);
	return true;
}

stock GetVehicleIDFromName(string[], bool: useFind = true)
{
	if(string[0] >= '0' && string[0] <= '9')
	{
		new id = strval(string);
		if(id >= 400 && id <= 612)
		{
			return id;
		}
	}
	else
	{
		if(useFind == false)
		{
			for(new i = 0, sof = sizeof(VehicleNames); i < sof; i++)
			{
				if(!strcmp(VehicleNames[i], string, true))
				{
					return i + 400;
				}
			}
		}
		else if(useFind == true)
		{
			for(new i = 0, sof = sizeof(VehicleNames); i < sof; i++)
			{
				if(strfind(VehicleNames[i], string, true) != -1)
				{
					return i + 400;
				}
			}
		}
	}
	return false;
}

stock IsValidWeapon(weaponid)
{
    if(weaponid >= 0 && weaponid < 19 || weaponid > 21 && weaponid < 47) return true;
    return false;
}

stock IsNumeric(const string[])
{
	for(new i = 0, j = strlen(string); i < j; i++)
	{
		if(string[i] > '9' || string[i] < '0') return false;
	}
    return true;
}

stock GetWeaponIDFromName(WeaponName[])
{
	//returnlu - 18
	if(strfind("molotov", WeaponName, true) != -1) return 18;
	for(new i = 0; i <= 46; i++)
	{
		switch(i)
		{
			case 0,19,20,21,44,45: continue;
			default:
			{
				new name[32]; GetWeaponName(i, name, 32);
				if(strfind(name, WeaponName, true) != -1) return i;
			}
		}
	}
	return -1;
}

stock GetVehicleName(vehicleid)
{
    new String[128];
	format(String, sizeof(String), "%s", VehicleNames[GetVehicleModel(vehicleid) - 400]);
	return String;
}

stock BenzinligeYakin(playerid)
{
	for(new i = 0; i < sizeof Benzinlikler; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 20.0, Benzinlikler[i][0], Benzinlikler[i][1], Benzinlikler[i][2]))
		{
			return true;
		}
	}
	return false;
}

stock TextYukle(playerid)
{
	tebrik0[playerid] = TextDrawCreate(462.000000, 72.900009, "arkaplan");
	TextDrawLetterSize(tebrik0[playerid], 0.000000, 28.979629);
	TextDrawTextSize(tebrik0[playerid], 192.500000, 0.000000);
	TextDrawAlignment(tebrik0[playerid], 1);
	TextDrawColor(tebrik0[playerid], 0);
	TextDrawUseBox(tebrik0[playerid], true);
	TextDrawBoxColor(tebrik0[playerid], -6618986);
	TextDrawSetShadow(tebrik0[playerid], 0);
	TextDrawSetOutline(tebrik0[playerid], 0);
	TextDrawFont(tebrik0[playerid], 0);

	tebrik1[playerid] = TextDrawCreate(238.000000, 87.733375, "rutbe");
	TextDrawLetterSize(tebrik1[playerid], 0.449999, 1.600000);
	TextDrawTextSize(tebrik1[playerid], 179.000000, 170.333450);
	TextDrawAlignment(tebrik1[playerid], 1);
	TextDrawColor(tebrik1[playerid], -1);
	TextDrawUseBox(tebrik1[playerid], 0);
	TextDrawBoxColor(tebrik1[playerid], 0);
	TextDrawSetShadow(tebrik1[playerid], 0);
	TextDrawSetOutline(tebrik1[playerid], 0);
	TextDrawBackgroundColor(tebrik1[playerid], 0);
	TextDrawFont(tebrik1[playerid], 5);
	TextDrawSetProportional(tebrik1[playerid], 1);
	TextDrawSetPreviewModel(tebrik1[playerid], 19784);
	TextDrawSetPreviewRot(tebrik1[playerid], 90, 0, 0, 1);

	tebrik2[playerid] = TextDrawCreate(254.500000, 76.999992, "... TEBRIKLER ...");
	TextDrawLetterSize(tebrik2[playerid], 0.532000, 2.094666);
	TextDrawTextSize(tebrik2[playerid], 491.500000, -193.199996);
	TextDrawAlignment(tebrik2[playerid], 1);
	TextDrawColor(tebrik2[playerid], -1);
	TextDrawSetShadow(tebrik2[playerid], 0);
	TextDrawSetOutline(tebrik2[playerid], -1);
	TextDrawBackgroundColor(tebrik2[playerid], 51);
	TextDrawFont(tebrik2[playerid], 2);
	TextDrawSetProportional(tebrik2[playerid], 1);

	tebrik3[playerid] = TextDrawCreate(282.500000, 98.046501, "LEVEL ATLADIN");
	TextDrawLetterSize(tebrik3[playerid], 0.371499, 1.450666);
	TextDrawAlignment(tebrik3[playerid], 1);
	TextDrawColor(tebrik3[playerid], -1);
	TextDrawSetShadow(tebrik3[playerid], 0);
	TextDrawSetOutline(tebrik3[playerid], 1);
	TextDrawBackgroundColor(tebrik3[playerid], 51);
	TextDrawFont(tebrik3[playerid], 1);
	TextDrawSetProportional(tebrik3[playerid], 1);

	tebrik4[playerid] = TextDrawCreate(233.500000, 227.266769, "Yeni Levelin :");
	TextDrawLetterSize(tebrik4[playerid], 0.404999, 2.043333);
	TextDrawTextSize(tebrik4[playerid], 455.000000, -37.333335);
	TextDrawAlignment(tebrik4[playerid], 1);
	TextDrawColor(tebrik4[playerid], -1);
	TextDrawUseBox(tebrik4[playerid], true);
	TextDrawBoxColor(tebrik4[playerid], 0);
	TextDrawSetShadow(tebrik4[playerid], 0);
	TextDrawSetOutline(tebrik4[playerid], 0);
	TextDrawBackgroundColor(tebrik4[playerid], 255);
	TextDrawFont(tebrik4[playerid], 1);
	TextDrawSetProportional(tebrik4[playerid], 1);

	tebrik5[playerid] = TextDrawCreate(327.500000, 228.666595, " .");
	TextDrawLetterSize(tebrik5[playerid], 0.492499, 1.847334);
	TextDrawTextSize(tebrik5[playerid], -147.000000, 319.200012);
	TextDrawAlignment(tebrik5[playerid], 1);
	TextDrawColor(tebrik5[playerid], -1);
	TextDrawSetShadow(tebrik5[playerid], 0);
	TextDrawSetOutline(tebrik5[playerid], 1);
	TextDrawBackgroundColor(tebrik5[playerid], 51);
	TextDrawFont(tebrik5[playerid], 3);
	TextDrawSetProportional(tebrik5[playerid], 1);

	tebrik6[playerid] = TextDrawCreate(287.750000, 251.999954, "... TEBRIKLER ...");
	TextDrawLetterSize(tebrik6[playerid], 0.317999, 1.623333);
	TextDrawAlignment(tebrik6[playerid], 1);
	TextDrawColor(tebrik6[playerid], -1);
	TextDrawSetShadow(tebrik6[playerid], 0);
	TextDrawSetOutline(tebrik6[playerid], 1);
	TextDrawBackgroundColor(tebrik6[playerid], 51);
	TextDrawFont(tebrik6[playerid], 1);
	TextDrawSetProportional(tebrik6[playerid], 1);

	AnimDurdurText0[playerid] = TextDrawCreate(374.000000, 83.000000, "~y~Animasyonu durdurmak icin ~r~~h~/z ~y~yaziniz.");
	TextDrawBackgroundColor(AnimDurdurText0[playerid], 80);
	TextDrawFont(AnimDurdurText0[playerid], 1);
	TextDrawLetterSize(AnimDurdurText0[playerid], 0.180000, 1.200000);
	TextDrawColor(AnimDurdurText0[playerid], -1);
	TextDrawSetOutline(AnimDurdurText0[playerid], 1);
	TextDrawSetProportional(AnimDurdurText0[playerid], 1);
	TextDrawSetSelectable(AnimDurdurText0[playerid], 0);

	Para[playerid][0] = TextDrawCreate(605.783630, 100.166648, "~g~~h~~h~+45.000 TL");
	TextDrawLetterSize(Para[playerid][0], 0.400000, 1.600000);
	TextDrawAlignment(Para[playerid][0], 3);
	TextDrawColor(Para[playerid][0], -1);
	TextDrawSetShadow(Para[playerid][0], 0);
	TextDrawSetOutline(Para[playerid][0], 1);
	TextDrawBackgroundColor(Para[playerid][0], 255);
	TextDrawFont(Para[playerid][0], 3);
	TextDrawSetProportional(Para[playerid][0], 1);
	TextDrawSetShadow(Para[playerid][0], 0);

	Hiz_Benzin[playerid][0] = TextDrawCreate(507.862487, 352.166778, "box");
	TextDrawLetterSize(Hiz_Benzin[playerid][0], 0.000000, 7.376276);
	TextDrawTextSize(Hiz_Benzin[playerid][0], 626.000000, 0.000000);
	TextDrawAlignment(Hiz_Benzin[playerid][0], 1);
	TextDrawColor(Hiz_Benzin[playerid][0], -1);
	TextDrawUseBox(Hiz_Benzin[playerid][0], 1);
	TextDrawBoxColor(Hiz_Benzin[playerid][0], 68);
	TextDrawSetShadow(Hiz_Benzin[playerid][0], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][0], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][0], 255);
	TextDrawFont(Hiz_Benzin[playerid][0], 1);
	TextDrawSetProportional(Hiz_Benzin[playerid][0], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][0], 0);

	Hiz_Benzin[playerid][1] = TextDrawCreate(510.910583, 357.283508, "box");
	TextDrawLetterSize(Hiz_Benzin[playerid][1], 0.000000, 2.622075);
	TextDrawTextSize(Hiz_Benzin[playerid][1], 622.000000, 0.000000);
	TextDrawAlignment(Hiz_Benzin[playerid][1], 1);
	TextDrawColor(Hiz_Benzin[playerid][1], -1);
	TextDrawUseBox(Hiz_Benzin[playerid][1], 1);
	TextDrawBoxColor(Hiz_Benzin[playerid][1], 51);
	TextDrawSetShadow(Hiz_Benzin[playerid][1], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][1], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][1], 255);
	TextDrawFont(Hiz_Benzin[playerid][1], 1);
	TextDrawSetProportional(Hiz_Benzin[playerid][1], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][1], 0);

	Hiz_Benzin[playerid][2] = TextDrawCreate(510.910583, 391.085571, "box");
	TextDrawLetterSize(Hiz_Benzin[playerid][2], 0.000000, 2.622075);
	TextDrawTextSize(Hiz_Benzin[playerid][2], 622.000000, 0.000000);
	TextDrawAlignment(Hiz_Benzin[playerid][2], 1);
	TextDrawColor(Hiz_Benzin[playerid][2], -1);
	TextDrawUseBox(Hiz_Benzin[playerid][2], 1);
	TextDrawBoxColor(Hiz_Benzin[playerid][2], 51);
	TextDrawSetShadow(Hiz_Benzin[playerid][2], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][2], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][2], 255);
	TextDrawFont(Hiz_Benzin[playerid][2], 1);
	TextDrawSetProportional(Hiz_Benzin[playerid][2], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][2], 0);

	Hiz_Benzin[playerid][3] = TextDrawCreate(503.008758, 353.333587, "");
	TextDrawLetterSize(Hiz_Benzin[playerid][3], 0.000000, 0.000000);
	TextDrawTextSize(Hiz_Benzin[playerid][3], 34.000000, 30.000000);
	TextDrawAlignment(Hiz_Benzin[playerid][3], 1);
	TextDrawColor(Hiz_Benzin[playerid][3], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][3], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][3], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][3], 0);
	TextDrawFont(Hiz_Benzin[playerid][3], 5);
	TextDrawSetProportional(Hiz_Benzin[playerid][3], 0);
	TextDrawSetShadow(Hiz_Benzin[playerid][3], 0);
	TextDrawSetPreviewModel(Hiz_Benzin[playerid][3], 3465);
	TextDrawSetPreviewRot(Hiz_Benzin[playerid][3], 0.000000, 0.000000, 90.000000, 1.000000);

	Hiz_Benzin[playerid][4] = TextDrawCreate(527.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][4], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][4], 1);
	TextDrawColor(Hiz_Benzin[playerid][4], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][4], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][4], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][4], 255);
	TextDrawFont(Hiz_Benzin[playerid][4], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][4], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][4], 0);

	Hiz_Benzin[playerid][5] = TextDrawCreate(530.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][5], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][5], 1);
	TextDrawColor(Hiz_Benzin[playerid][5], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][5], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][5], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][5], 255);
	TextDrawFont(Hiz_Benzin[playerid][5], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][5], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][5], 0);

	Hiz_Benzin[playerid][6] = TextDrawCreate(533.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][6], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][6], 1);
	TextDrawColor(Hiz_Benzin[playerid][6], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][6], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][6], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][6], 255);
	TextDrawFont(Hiz_Benzin[playerid][6], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][6], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][6], 0);

	Hiz_Benzin[playerid][7] = TextDrawCreate(536.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][7], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][7], 1);
	TextDrawColor(Hiz_Benzin[playerid][7], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][7], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][7], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][7], 255);
	TextDrawFont(Hiz_Benzin[playerid][7], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][7], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][7], 0);

	Hiz_Benzin[playerid][8] = TextDrawCreate(539.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][8], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][8], 1);
	TextDrawColor(Hiz_Benzin[playerid][8], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][8], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][8], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][8], 255);
	TextDrawFont(Hiz_Benzin[playerid][8], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][8], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][8], 0);

	Hiz_Benzin[playerid][9] = TextDrawCreate(542.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][9], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][9], 1);
	TextDrawColor(Hiz_Benzin[playerid][9], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][9], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][9], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][9], 255);
	TextDrawFont(Hiz_Benzin[playerid][9], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][9], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][9], 0);

	Hiz_Benzin[playerid][10] = TextDrawCreate(545.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][10], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][10], 1);
	TextDrawColor(Hiz_Benzin[playerid][10], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][10], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][10], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][10], 255);
	TextDrawFont(Hiz_Benzin[playerid][10], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][10], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][10], 0);

	Hiz_Benzin[playerid][11] = TextDrawCreate(548.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][11], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][11], 1);
	TextDrawColor(Hiz_Benzin[playerid][11], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][11], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][11], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][11], 255);
	TextDrawFont(Hiz_Benzin[playerid][11], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][11], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][11], 0);

	Hiz_Benzin[playerid][12] = TextDrawCreate(551.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][12], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][12], 1);
	TextDrawColor(Hiz_Benzin[playerid][12], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][12], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][12], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][12], 255);
	TextDrawFont(Hiz_Benzin[playerid][12], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][12], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][12], 0);

	Hiz_Benzin[playerid][13] = TextDrawCreate(554.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][13], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][13], 1);
	TextDrawColor(Hiz_Benzin[playerid][13], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][13], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][13], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][13], 255);
	TextDrawFont(Hiz_Benzin[playerid][13], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][13], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][13], 0);

	Hiz_Benzin[playerid][14] = TextDrawCreate(557.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][14], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][14], 1);
	TextDrawColor(Hiz_Benzin[playerid][14], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][14], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][14], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][14], 255);
	TextDrawFont(Hiz_Benzin[playerid][14], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][14], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][14], 0);

	Hiz_Benzin[playerid][15] = TextDrawCreate(560.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][15], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][15], 1);
	TextDrawColor(Hiz_Benzin[playerid][15], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][15], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][15], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][15], 255);
	TextDrawFont(Hiz_Benzin[playerid][15], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][15], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][15], 0);

	Hiz_Benzin[playerid][16] = TextDrawCreate(563.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][16], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][16], 1);
	TextDrawColor(Hiz_Benzin[playerid][16], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][16], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][16], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][16], 255);
	TextDrawFont(Hiz_Benzin[playerid][16], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][16], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][16], 0);

	Hiz_Benzin[playerid][17] = TextDrawCreate(566.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][17], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][17], 1);
	TextDrawColor(Hiz_Benzin[playerid][17], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][17], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][17], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][17], 255);
	TextDrawFont(Hiz_Benzin[playerid][17], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][17], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][17], 0);

	Hiz_Benzin[playerid][18] = TextDrawCreate(569.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][18], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][18], 1);
	TextDrawColor(Hiz_Benzin[playerid][18], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][18], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][18], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][18], 255);
	TextDrawFont(Hiz_Benzin[playerid][18], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][18], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][18], 0);

	Hiz_Benzin[playerid][19] = TextDrawCreate(572.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][19], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][19], 1);
	TextDrawColor(Hiz_Benzin[playerid][19], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][19], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][19], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][19], 255);
	TextDrawFont(Hiz_Benzin[playerid][19], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][19], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][19], 0);

	Hiz_Benzin[playerid][20] = TextDrawCreate(575.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][20], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][20], 1);
	TextDrawColor(Hiz_Benzin[playerid][20], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][20], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][20], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][20], 255);
	TextDrawFont(Hiz_Benzin[playerid][20], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][20], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][20], 0);

	Hiz_Benzin[playerid][21] = TextDrawCreate(578.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][21], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][21], 1);
	TextDrawColor(Hiz_Benzin[playerid][21], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][21], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][21], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][21], 255);
	TextDrawFont(Hiz_Benzin[playerid][21], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][21], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][21], 0);

	Hiz_Benzin[playerid][22] = TextDrawCreate(581.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][22], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][22], 1);
	TextDrawColor(Hiz_Benzin[playerid][22], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][22], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][22], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][22], 255);
	TextDrawFont(Hiz_Benzin[playerid][22], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][22], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][22], 0);

	Hiz_Benzin[playerid][23] = TextDrawCreate(584.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][23], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][23], 1);
	TextDrawColor(Hiz_Benzin[playerid][23], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][23], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][23], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][23], 255);
	TextDrawFont(Hiz_Benzin[playerid][23], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][23], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][23], 0);

	Hiz_Benzin[playerid][24] = TextDrawCreate(587.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][24], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][24], 1);
	TextDrawColor(Hiz_Benzin[playerid][24], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][24], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][24], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][24], 255);
	TextDrawFont(Hiz_Benzin[playerid][24], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][24], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][24], 0);

	Hiz_Benzin[playerid][25] = TextDrawCreate(590.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][25], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][25], 1);
	TextDrawColor(Hiz_Benzin[playerid][25], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][25], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][25], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][25], 255);
	TextDrawFont(Hiz_Benzin[playerid][25], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][25], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][25], 0);

	Hiz_Benzin[playerid][26] = TextDrawCreate(593.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][26], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][26], 1);
	TextDrawColor(Hiz_Benzin[playerid][26], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][26], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][26], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][26], 255);
	TextDrawFont(Hiz_Benzin[playerid][26], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][26], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][26], 0);

	Hiz_Benzin[playerid][27] = TextDrawCreate(596.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][27], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][27], 1);
	TextDrawColor(Hiz_Benzin[playerid][27], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][27], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][27], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][27], 255);
	TextDrawFont(Hiz_Benzin[playerid][27], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][27], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][27], 0);

	Hiz_Benzin[playerid][28] = TextDrawCreate(599.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][28], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][28], 1);
	TextDrawColor(Hiz_Benzin[playerid][28], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][28], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][28], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][28], 255);
	TextDrawFont(Hiz_Benzin[playerid][28], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][28], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][28], 0);

	Hiz_Benzin[playerid][29] = TextDrawCreate(602.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][29], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][29], 1);
	TextDrawColor(Hiz_Benzin[playerid][29], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][29], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][29], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][29], 255);
	TextDrawFont(Hiz_Benzin[playerid][29], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][29], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][29], 0);

	Hiz_Benzin[playerid][30] = TextDrawCreate(605.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][30], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][30], 1);
	TextDrawColor(Hiz_Benzin[playerid][30], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][30], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][30], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][30], 255);
	TextDrawFont(Hiz_Benzin[playerid][30], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][30], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][30], 0);

	Hiz_Benzin[playerid][31] = TextDrawCreate(608.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][31], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][31], 1);
	TextDrawColor(Hiz_Benzin[playerid][31], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][31], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][31], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][31], 255);
	TextDrawFont(Hiz_Benzin[playerid][31], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][31], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][31], 0);

	Hiz_Benzin[playerid][32] = TextDrawCreate(611.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][32], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][32], 1);
	TextDrawColor(Hiz_Benzin[playerid][32], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][32], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][32], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][32], 255);
	TextDrawFont(Hiz_Benzin[playerid][32], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][32], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][32], 0);

	Hiz_Benzin[playerid][33] = TextDrawCreate(614.540344, 352.166564, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][33], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][33], 1);
	TextDrawColor(Hiz_Benzin[playerid][33], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][33], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][33], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][33], 255);
	TextDrawFont(Hiz_Benzin[playerid][33], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][33], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][33], 0);

	Hiz_Benzin[playerid][34] = TextDrawCreate(509.099853, 392.916870, "");
	TextDrawLetterSize(Hiz_Benzin[playerid][34], 0.000000, 0.000000);
	TextDrawTextSize(Hiz_Benzin[playerid][34], 20.000000, 21.000000);
	TextDrawAlignment(Hiz_Benzin[playerid][34], 1);
	TextDrawColor(Hiz_Benzin[playerid][34], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][34], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][34], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][34], 0);
	TextDrawFont(Hiz_Benzin[playerid][34], 5);
	TextDrawSetProportional(Hiz_Benzin[playerid][34], 0);
	TextDrawSetShadow(Hiz_Benzin[playerid][34], 0);
	TextDrawSetPreviewModel(Hiz_Benzin[playerid][34], 1085);
	TextDrawSetPreviewRot(Hiz_Benzin[playerid][34], 0.000000, 0.000000, 90.000000, 1.000000);

	Hiz_Benzin[playerid][35] = TextDrawCreate(527.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][35], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][35], 1);
	TextDrawColor(Hiz_Benzin[playerid][35], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][35], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][35], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][35], 255);
	TextDrawFont(Hiz_Benzin[playerid][35], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][35], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][35], 0);

	Hiz_Benzin[playerid][36] = TextDrawCreate(530.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][36], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][36], 1);
	TextDrawColor(Hiz_Benzin[playerid][36], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][36], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][36], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][36], 255);
	TextDrawFont(Hiz_Benzin[playerid][36], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][36], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][36], 0);

	Hiz_Benzin[playerid][37] = TextDrawCreate(533.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][37], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][37], 1);
	TextDrawColor(Hiz_Benzin[playerid][37], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][37], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][37], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][37], 255);
	TextDrawFont(Hiz_Benzin[playerid][37], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][37], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][37], 0);

	Hiz_Benzin[playerid][38] = TextDrawCreate(536.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][38], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][38], 1);
	TextDrawColor(Hiz_Benzin[playerid][38], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][38], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][38], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][38], 255);
	TextDrawFont(Hiz_Benzin[playerid][38], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][38], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][38], 0);

	Hiz_Benzin[playerid][39] = TextDrawCreate(539.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][39], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][39], 1);
	TextDrawColor(Hiz_Benzin[playerid][39], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][39], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][39], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][39], 255);
	TextDrawFont(Hiz_Benzin[playerid][39], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][39], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][39], 0);

	Hiz_Benzin[playerid][40] = TextDrawCreate(542.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][40], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][40], 1);
	TextDrawColor(Hiz_Benzin[playerid][40], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][40], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][40], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][40], 255);
	TextDrawFont(Hiz_Benzin[playerid][40], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][40], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][40], 0);

	Hiz_Benzin[playerid][41] = TextDrawCreate(545.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][41], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][41], 1);
	TextDrawColor(Hiz_Benzin[playerid][41], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][41], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][41], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][41], 255);
	TextDrawFont(Hiz_Benzin[playerid][41], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][41], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][41], 0);

	Hiz_Benzin[playerid][42] = TextDrawCreate(548.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][42], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][42], 1);
	TextDrawColor(Hiz_Benzin[playerid][42], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][42], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][42], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][42], 255);
	TextDrawFont(Hiz_Benzin[playerid][42], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][42], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][42], 0);

	Hiz_Benzin[playerid][43] = TextDrawCreate(551.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][43], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][43], 1);
	TextDrawColor(Hiz_Benzin[playerid][43], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][43], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][43], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][43], 255);
	TextDrawFont(Hiz_Benzin[playerid][43], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][43], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][43], 0);

	Hiz_Benzin[playerid][44] = TextDrawCreate(554.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][44], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][44], 1);
	TextDrawColor(Hiz_Benzin[playerid][44], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][44], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][44], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][44], 255);
	TextDrawFont(Hiz_Benzin[playerid][44], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][44], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][44], 0);

	Hiz_Benzin[playerid][45] = TextDrawCreate(557.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][45], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][45], 1);
	TextDrawColor(Hiz_Benzin[playerid][45], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][45], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][45], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][45], 255);
	TextDrawFont(Hiz_Benzin[playerid][45], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][45], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][45], 0);

	Hiz_Benzin[playerid][46] = TextDrawCreate(560.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][46], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][46], 1);
	TextDrawColor(Hiz_Benzin[playerid][46], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][46], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][46], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][46], 255);
	TextDrawFont(Hiz_Benzin[playerid][46], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][46], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][46], 0);

	Hiz_Benzin[playerid][47] = TextDrawCreate(563.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][47], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][47], 1);
	TextDrawColor(Hiz_Benzin[playerid][47], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][47], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][47], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][47], 255);
	TextDrawFont(Hiz_Benzin[playerid][47], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][47], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][47], 0);

	Hiz_Benzin[playerid][48] = TextDrawCreate(566.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][48], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][48], 1);
	TextDrawColor(Hiz_Benzin[playerid][48], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][48], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][48], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][48], 255);
	TextDrawFont(Hiz_Benzin[playerid][48], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][48], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][48], 0);

	Hiz_Benzin[playerid][49] = TextDrawCreate(569.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][49], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][49], 1);
	TextDrawColor(Hiz_Benzin[playerid][49], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][49], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][49], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][49], 255);
	TextDrawFont(Hiz_Benzin[playerid][49], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][49], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][49], 0);

	Hiz_Benzin[playerid][50] = TextDrawCreate(572.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][50], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][50], 1);
	TextDrawColor(Hiz_Benzin[playerid][50], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][50], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][50], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][50], 255);
	TextDrawFont(Hiz_Benzin[playerid][50], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][50], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][50], 0);

	Hiz_Benzin[playerid][51] = TextDrawCreate(575.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][51], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][51], 1);
	TextDrawColor(Hiz_Benzin[playerid][51], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][51], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][51], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][51], 255);
	TextDrawFont(Hiz_Benzin[playerid][51], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][51], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][51], 0);

	Hiz_Benzin[playerid][52] = TextDrawCreate(578.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][52], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][52], 1);
	TextDrawColor(Hiz_Benzin[playerid][52], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][52], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][52], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][52], 255);
	TextDrawFont(Hiz_Benzin[playerid][52], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][52], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][52], 0);

	Hiz_Benzin[playerid][53] = TextDrawCreate(581.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][53], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][53], 1);
	TextDrawColor(Hiz_Benzin[playerid][53], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][53], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][53], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][53], 255);
	TextDrawFont(Hiz_Benzin[playerid][53], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][53], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][53], 0);

	Hiz_Benzin[playerid][54] = TextDrawCreate(584.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][54], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][54], 1);
	TextDrawColor(Hiz_Benzin[playerid][54], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][54], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][54], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][54], 255);
	TextDrawFont(Hiz_Benzin[playerid][54], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][54], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][54], 0);

	Hiz_Benzin[playerid][55] = TextDrawCreate(587.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][55], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][55], 1);
	TextDrawColor(Hiz_Benzin[playerid][55], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][55], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][55], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][55], 255);
	TextDrawFont(Hiz_Benzin[playerid][55], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][55], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][55], 0);

	Hiz_Benzin[playerid][56] = TextDrawCreate(590.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][56], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][56], 1);
	TextDrawColor(Hiz_Benzin[playerid][56], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][56], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][56], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][56], 255);
	TextDrawFont(Hiz_Benzin[playerid][56], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][56], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][56], 0);

	Hiz_Benzin[playerid][57] = TextDrawCreate(593.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][57], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][57], 1);
	TextDrawColor(Hiz_Benzin[playerid][57], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][57], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][57], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][57], 255);
	TextDrawFont(Hiz_Benzin[playerid][57], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][57], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][57], 0);

	Hiz_Benzin[playerid][58] = TextDrawCreate(596.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][58], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][58], 1);
	TextDrawColor(Hiz_Benzin[playerid][58], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][58], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][58], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][58], 255);
	TextDrawFont(Hiz_Benzin[playerid][58], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][58], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][58], 0);

	Hiz_Benzin[playerid][59] = TextDrawCreate(599.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][59], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][59], 1);
	TextDrawColor(Hiz_Benzin[playerid][59], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][59], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][59], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][59], 255);
	TextDrawFont(Hiz_Benzin[playerid][59], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][59], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][59], 0);

	Hiz_Benzin[playerid][60] = TextDrawCreate(602.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][60], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][60], 1);
	TextDrawColor(Hiz_Benzin[playerid][60], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][60], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][60], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][60], 255);
	TextDrawFont(Hiz_Benzin[playerid][60], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][60], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][60], 0);

	Hiz_Benzin[playerid][61] = TextDrawCreate(605.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][61], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][61], 1);
	TextDrawColor(Hiz_Benzin[playerid][61], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][61], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][61], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][61], 255);
	TextDrawFont(Hiz_Benzin[playerid][61], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][61], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][61], 0);

	Hiz_Benzin[playerid][62] = TextDrawCreate(608.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][62], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][62], 1);
	TextDrawColor(Hiz_Benzin[playerid][62], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][62], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][62], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][62], 255);
	TextDrawFont(Hiz_Benzin[playerid][62], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][62], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][62], 0);

	Hiz_Benzin[playerid][63] = TextDrawCreate(611.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][63], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][63], 1);
	TextDrawColor(Hiz_Benzin[playerid][63], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][63], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][63], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][63], 255);
	TextDrawFont(Hiz_Benzin[playerid][63], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][63], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][63], 0);

	Hiz_Benzin[playerid][64] = TextDrawCreate(614.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][64], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][64], 2);
	TextDrawColor(Hiz_Benzin[playerid][64], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][64], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][64], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][64], 255);
	TextDrawFont(Hiz_Benzin[playerid][64], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][64], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][64], 0);

	Hiz_Benzin[playerid][65] = TextDrawCreate(617.540344, 386.250152, "I");
	TextDrawLetterSize(Hiz_Benzin[playerid][65], 0.472151, 3.198333);
	TextDrawAlignment(Hiz_Benzin[playerid][65], 2);
	TextDrawColor(Hiz_Benzin[playerid][65], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][65], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][65], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][65], 255);
	TextDrawFont(Hiz_Benzin[playerid][65], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][65], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][65], 0);

	Hiz_Benzin[playerid][66] = TextDrawCreate(507.862487, 328.665344, "box");
	TextDrawLetterSize(Hiz_Benzin[playerid][66], 0.000000, 1.941431);
	TextDrawTextSize(Hiz_Benzin[playerid][66], 626.000000, 0.000000);
	TextDrawAlignment(Hiz_Benzin[playerid][66], 1);
	TextDrawColor(Hiz_Benzin[playerid][66], -1);
	TextDrawUseBox(Hiz_Benzin[playerid][66], 1);
	TextDrawBoxColor(Hiz_Benzin[playerid][66], 68);
	TextDrawSetShadow(Hiz_Benzin[playerid][66], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][66], 0);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][66], 255);
	TextDrawFont(Hiz_Benzin[playerid][66], 1);
	TextDrawSetProportional(Hiz_Benzin[playerid][66], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][66], 0);

	Hiz_Benzin[playerid][67] = TextDrawCreate(566.427551, 331.166656, "~r~~h~~h~Hiz: ~g~~h~~h~62 ~r~~h~~h~Benzin: ~g~~h~~h~100");
	TextDrawLetterSize(Hiz_Benzin[playerid][67], 0.228521, 1.337499);
	TextDrawAlignment(Hiz_Benzin[playerid][67], 2);
	TextDrawColor(Hiz_Benzin[playerid][67], -1);
	TextDrawSetShadow(Hiz_Benzin[playerid][67], 0);
	TextDrawSetOutline(Hiz_Benzin[playerid][67], 1);
	TextDrawBackgroundColor(Hiz_Benzin[playerid][67], 68);
	TextDrawFont(Hiz_Benzin[playerid][67], 2);
	TextDrawSetProportional(Hiz_Benzin[playerid][67], 1);
	TextDrawSetShadow(Hiz_Benzin[playerid][67], 0);

	for(new q = 35; q < 67; q++)
	{
		TextDrawBackgroundColor(Hiz_Benzin[playerid][q], 0x00000033);
		TextDrawFont(Hiz_Benzin[playerid][q], 2);
		TextDrawColor(Hiz_Benzin[playerid][q], 0x66666644);
		TextDrawSetOutline(Hiz_Benzin[playerid][q], false);
		TextDrawSetProportional(Hiz_Benzin[playerid][q], true);
		TextDrawSetShadow(Hiz_Benzin[playerid][q], false);
	}

	for(new q = 4; q < 34; q++)
	{
		TextDrawBackgroundColor(Hiz_Benzin[playerid][q], 0x00000033);
		TextDrawFont(Hiz_Benzin[playerid][q], 2);
		TextDrawColor(Hiz_Benzin[playerid][q], 0x66666644);
		TextDrawSetOutline(Hiz_Benzin[playerid][q], false);
		TextDrawSetProportional(Hiz_Benzin[playerid][q], true);
		TextDrawSetShadow(Hiz_Benzin[playerid][q], false);
	}
	return true;
}

stock SetPlayerPV(playerid, Float:X, Float:Y, Float:Z,interior = 0, world = 0)
{
	new PlayerState = GetPlayerState(playerid);
	new vehicleid;
	vehicleid = GetPlayerVehicleID(playerid);
	SetPlayerInterior(playerid,interior);
	SetPlayerVirtualWorld(playerid, world);
	if(IsPlayerInAnyVehicle(playerid) && PlayerState == PLAYER_STATE_DRIVER)
	{
 		SetVehiclePos(vehicleid, X,Y,Z);
 		SetVehicleZAngle(vehicleid,0);
 		LinkVehicleToInterior(vehicleid, interior);
 		SetVehicleVirtualWorld(vehicleid, world);
	}
	else
	{
 		SetPlayerPos(playerid, X,Y,Z);
	}
}

stock getName(playerid)
{
	new isim[MAX_PLAYER_NAME];
	GetPlayerName(playerid, isim, MAX_PLAYER_NAME);
	return isim;
}

stock SendClientMessageToAllEx(renk, const yazi[], kesim_uzunlugu = 142)
{
	new mesaj[148 + 1], deger = 0 - kesim_uzunlugu, uzunluk = strlen(yazi);

	while(uzunluk > (deger += kesim_uzunlugu))
	{
		strmid(mesaj, yazi[deger], 0, kesim_uzunlugu), SendClientMessageToAll(renk, mesaj);
	}
	return true;
}

stock CC(playerid)
{
	new a = 0;
	while(a < 120)
	{
		SendClientMessage(playerid, -1, " ");
		a++;
	}
	return true;
}

stock Kayit_Giris(playerid)
{
	new sql[500], str[500];
	format(sql, sizeof(sql), "SELECT * FROM `hesaplar` WHERE `tagsiz_isim` = '%s'", getName(playerid));
	mysql_query(db, sql);

	if(cache_num_rows() == 0)
	{
		format(str, sizeof(str), "\
			{00EEFF}Sunucumuza hoþgeldin %s!\n\
			Adýna kayýtlý bir hesap {FF0000}malesef bulunmuyor!\n\n\
			{FFB300}Aþaðýdaki kutucuða þifreni girerek kayýt olabilirsin:\n", getName(playerid));
		ShowPlayerDialog(playerid, DIALOG_KAYIT, DIALOG_STYLE_PASSWORD, "{00EEFF}Kayýt", str, "Kayýt Ol", "Çýkýþ");
	}
	else
	{
		format(str, sizeof(str), "\
			{00EEFF}Sunucumuza hoþgeldin %s!\n\
			Adýna kayýtlý bir hesap {00F600}bulunuyor!\n\n\
			{FFB300}Aþaðýdaki kutucuða þifreni girerek giriþ yapabilirsin:\n\n\
			Kalan Giriþ Haklarýn: %d/3", getName(playerid), GetPVarInt(playerid, "GirisHaklari"));
		ShowPlayerDialog(playerid, DIALOG_GIRIS, DIALOG_STYLE_PASSWORD, "{00EEFF}Giriþ", str, "Giriþ Yap", "Çýkýþ");
	}
	return true;
}

stock GetWeekDay(day=0, month=0, year=0)
{
	if(!day)
		getdate(year, month, day);

	new
	weekday_str[25],
	j,
	e
	;

	if(month <= 2)
	{
		month += 12;
		--year;
	}

	j = year % 100;
	e = year / 100;

	switch((day +(month+1)*26/10 + j + j/4 + e/4 - 2*e) % 7)
	{
		case 0: weekday_str = "Cumartesi";
		case 1: weekday_str = "Pazar";
		case 2: weekday_str = "Pazartesi";
		case 3: weekday_str = "Salý";
		case 4: weekday_str = "Çarþamba";
		case 5: weekday_str = "Perþembe";
		case 6: weekday_str = "Cuma";
	}

	return weekday_str;
}

stock ConvertTime(cts)
{
    new
        ctm,
        cth,
        ctd,
        ctw,
        ctmo,
        cty;

    #define PLUR(%0,%1,%2) (%0),((%0) == 1)?((#%1)):((#%2))

    #define CTM_cty 31536000
    #define CTM_ctmo 2628000
    #define CTM_ctw 604800
    #define CTM_ctd 86400
    #define CTM_cth 3600
    #define CTM_ctm 60

    #define CT(%0) %0 = cts / CTM_%0; cts %= CTM_%0

    new strii[128];

    if(cty != -1 && (cts/CTM_cty))
    {
        CT(cty); CT(ctmo); CT(ctw); CT(ctd); CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, %d %s, %d %s, %d %s, %d %s ve %d %s",PLUR(cty,"yýl","yýl"),PLUR(ctmo,"ay","ay"),PLUR(ctw,"hafta","hafta"),PLUR(ctd,"gün","gün"),PLUR(cth,"saat","saat"),PLUR(ctm,"dakika","dakika"),PLUR(cts,"saniye","saniye"));
        return strii;
    }
    if(ctmo != -1 && (cts/CTM_ctmo))
    {
        cty = 0; CT(ctmo); CT(ctw); CT(ctd); CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, %d %s, %d %s, %d %s ve %d %s",PLUR(ctmo,"ay","ay"),PLUR(ctw,"hafta","hafta"),PLUR(ctd,"gün","gün"),PLUR(cth,"saat","saat"),PLUR(ctm,"dakika","dakika"),PLUR(cts,"saniye","saniye"));
        return strii;
    }
    if(ctw != -1 && (cts/CTM_ctw))
    {
        cty = 0; ctmo = 0; CT(ctw); CT(ctd); CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, %d %s, %d %s ve %d %s",PLUR(ctw,"hafta","hafta"),PLUR(ctd,"gün","gün"),PLUR(cth,"saat","saat"),PLUR(ctm,"dakika","dakika"),PLUR(cts,"saniye","saniye"));
        return strii;
    }
    if(ctd != -1 && (cts/CTM_ctd))
    {
        cty = 0; ctmo = 0; ctw = 0; CT(ctd); CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, %d %s ve %d %s",PLUR(ctd,"gün","gün"),PLUR(cth,"saat","saat"),PLUR(ctm,"dakika","dakika"),PLUR(cts,"saniye","saniye"));
        return strii;
    }
    if(cth != -1 && (cts/CTM_cth))
    {
        cty = 0; ctmo = 0; ctw = 0; ctd = 0; CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s ve %d %s",PLUR(cth,"saat","saat"),PLUR(ctm,"dakika","dakika"),PLUR(cts,"saniye","saniye"));
        return strii;
    }
    if(ctm != -1 && (cts/CTM_ctm))
    {
        cty = 0; ctmo = 0; ctw = 0; ctd = 0; cth = 0; CT(ctm);
        format(strii, sizeof(strii), "%d %s ve %d %s",PLUR(ctm,"dakika","dakika"),PLUR(cts,"saniye","saniye"));
        return strii;
    }
    cty = 0; ctmo = 0; ctw = 0; ctd = 0; cth = 0; ctm = 0;
    format(strii, sizeof(strii), "%d %s", PLUR(cts,"saniye","saniye"));
    return strii;
}

stock convertDate(timestamp, _form=0){
    new year=1970, day=0, month=0, hour=0, mins=0, sec=0;
    new days_of_month[12] = { 31,28,31,30,31,30,31,31,30,31,30,31 };
    new names_of_month[12][10] = {"Ocak","Subat","Mart","Nisan","Mayis","Haziran","Temmuz","Agustos","Eylul","Ekim","Kasim","Aralik"};
    new returnstring[56];
    while(timestamp>31622400){
        timestamp -= 31536000;
        if(((year % 4 == 0) &&(year % 100 != 0)) ||(year % 400 == 0)) timestamp -= 86400;
        year++;
    }
    if(((year % 4 == 0) &&(year % 100 != 0)) ||(year % 400 == 0))
        days_of_month[1] = 29;
    else
        days_of_month[1] = 28;
    while(timestamp>86400){
        timestamp -= 86400, day++;
        if(day==days_of_month[month]) day=0, month++;
    }
    while(timestamp>60){
        timestamp -= 60, mins++;
        if(mins == 60) mins=0, hour++;
    }
    sec=timestamp;
    hour += 3;
    if(hour >= 24) hour -= 24;
    switch(_form){
        case 1: format(returnstring, 56, "%02d/%02d/%d %02d:%02d:%02d", day+1, month+1, year, hour, mins, sec);
        case 2: format(returnstring, 56, "%s %02d, %d, %02d:%02d:%02d", names_of_month[month],day+1,year, hour, mins, sec);
        case 3: format(returnstring, 56, "%d %c%c%c %d, %02d:%02d", day+1,names_of_month[month][0],names_of_month[month][1],names_of_month[month][2], year,hour,mins);

        default: format(returnstring, 56, "%02d/%02d/%d - %02d:%02d:%02d, %s", day+1, month+1, year, hour, mins, sec, GetWeekDay(day + 1, month + 1, year));
    }
    return returnstring;
}

stock SaveComponent(playerid, vehicleid, componentid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	    if(aData[vehicleid][aSahip] == pData[playerid][pSQLID])
	    {
			for(new s = 0; s < 20; s++)
			{
 				if(componentid == spoiler[s][0])
 				{
   					aData[vehicleid][aMod1] = componentid;
	        	}
			}

			for(new s = 0; s < 3; s++)
			{
 				if(componentid == nitro[s][0])
 				{
   					aData[vehicleid][aMod2] = componentid;
	        	}
			}

			for(new s = 0; s < 23; s++)
			{
 				if(componentid == fbumper[s][0])
 				{
   					aData[vehicleid][aMod3] = componentid;
	        	}
			}

			for(new s = 0; s < 22; s++)
			{
 				if(componentid == rbumper[s][0])
 				{
   					aData[vehicleid][aMod4] = componentid;
	        	}
			}

			for(new s = 0; s < 28; s++)
			{
 				if(componentid == exhaust[s][0])
 				{
   					aData[vehicleid][aMod5] = componentid;
	        	}
			}

			for(new s = 0; s < 2; s++)
			{
 				if(componentid == bventr[s][0])
 				{
   					aData[vehicleid][aMod6] = componentid;
	        	}
			}

			for(new s = 0; s < 2; s++)
			{
 				if(componentid == bventl[s][0])
 				{
   					aData[vehicleid][aMod7] = componentid;
	        	}
			}

			for(new s = 0; s < 4; s++)
			{
 				if(componentid == bscoop[s][0])
 				{
   					aData[vehicleid][aMod8] = componentid;
	        	}
			}

			for(new s = 0; s < 13; s++)
			{
 				if(componentid == rscoop[s][0])
 				{
   					aData[vehicleid][aMod9] = componentid;
	        	}
			}

			for(new s = 0; s < 21; s++)
			{
 				if(componentid == lskirt[s][0])
 				{
   					aData[vehicleid][aMod10] = componentid;
	        	}
			}

			for(new s = 0; s < 21; s++)
			{
 				if(componentid == rskirt[s][0])
 				{
   					aData[vehicleid][aMod11] = componentid;
	        	}
			}

			for(new s = 0; s < 1; s++)
			{
 				if(componentid == hydraulics[s][0])
 				{
   					aData[vehicleid][aMod12] = componentid;
	        	}
			}

			for(new s = 0; s < 1; s++)
			{
 				if(componentid == yex[s][0])
 				{
   					aData[vehicleid][aMod13] = componentid;
	        	}
			}

			for(new s = 0; s < 2; s++)
			{
 				if(componentid == rbbars[s][0])
 				{
   					aData[vehicleid][aMod14] = componentid;
	        	}
			}

			for(new s = 0; s < 2; s++)
			{
 				if(componentid == fbbars[s][0])
 				{
   					aData[vehicleid][aMod15] = componentid;
	        	}
			}

			for(new s = 0; s < 17; s++)
			{
 				if(componentid == wheels[s][0])
 				{
   					aData[vehicleid][aMod16] = componentid;
	        	}
			}

			for(new s = 0; s < 2; s++)
			{
 				if(componentid == lights[s][0])
 				{
   					aData[vehicleid][aMod17] = componentid;
	        	}
			}
			return true;
		}
	}
	return false;
}

stock SavePaintjob(playerid, vehicleid, paintjobid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	    if(aData[vehicleid][aSahip] == pData[playerid][pSQLID])
	    {
			aData[vehicleid][aPaintJob] = paintjobid;
			return true;
		}
	}
	return false;
}

stock SaveColors(playerid, vehicleid, color1, color2)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	    if(aData[vehicleid][aSahip] == pData[playerid][pSQLID])
	    {
			aData[vehicleid][aRenk1] = color1;
	        aData[vehicleid][aRenk2] = color2;
			return true;
		}
	}
	return false;
}

stock AracKayit(id)
{
	new sql[1024];
	format(sql, sizeof(sql), "UPDATE `araclar` SET `mod1` = '%d', `mod2` = '%d', `mod3` = '%d', `mod4` = '%d', `mod5` = '%d', `mod6` = '%d', `mod7` = '%d', `mod8` = '%d', `mod9` = '%d', `mod10` = '%d',\
		`mod11` = '%d', `mod12` = '%d', `mod13` = '%d', `mod14` = '%d', `mod15` = '%d', `mod16` = '%d', `mod17` = '%d', `paintjob` = '%d', `renk1` = '%d', `renk2` = '%d' WHERE `id` = '%d'",
		aData[id][aMod1], aData[id][aMod2], aData[id][aMod3], aData[id][aMod4], aData[id][aMod5], aData[id][aMod6], aData[id][aMod7], aData[id][aMod8], aData[id][aMod9], aData[id][aMod10], aData[id][aMod11], 
		aData[id][aMod12], aData[id][aMod13], aData[id][aMod14], aData[id][aMod15], aData[id][aMod16], aData[id][aMod17], aData[id][aPaintJob], aData[id][aRenk1], aData[id][aRenk2], id);
	mysql_query(db, sql);
	return true;
}

stock ModVehicle(playerid)
{
	new vehicleid = pData[playerid][pArac];
	if(aData[vehicleid][aMod1] != 0)
	{
		AddVehicleComponent(GetPlayerVehicleID(playerid), aData[vehicleid][aMod1]);
	}
	if(aData[vehicleid][aMod2] != 0)
	{
		AddVehicleComponent(GetPlayerVehicleID(playerid), aData[vehicleid][aMod2]);
	}
	if(aData[vehicleid][aMod3] != 0)
	{
		AddVehicleComponent(GetPlayerVehicleID(playerid), aData[vehicleid][aMod3]);
	}
	if(aData[vehicleid][aMod4] != 0)
	{
		AddVehicleComponent(GetPlayerVehicleID(playerid), aData[vehicleid][aMod4]);
	}
	if(aData[vehicleid][aMod5] != 0)
	{
		AddVehicleComponent(GetPlayerVehicleID(playerid), aData[vehicleid][aMod5]);
	}
	if(aData[vehicleid][aMod6] != 0)
	{
		AddVehicleComponent(GetPlayerVehicleID(playerid), aData[vehicleid][aMod6]);
	}
	if(aData[vehicleid][aMod7] != 0)
	{
		AddVehicleComponent(GetPlayerVehicleID(playerid), aData[vehicleid][aMod7]);
	}
	if(aData[vehicleid][aMod8] != 0)
	{
		AddVehicleComponent(GetPlayerVehicleID(playerid), aData[vehicleid][aMod8]);
 	}
	if(aData[vehicleid][aMod9] != 0)
	{
		AddVehicleComponent(GetPlayerVehicleID(playerid), aData[vehicleid][aMod9]);
	}
	if(aData[vehicleid][aMod10] != 0)
	{
		AddVehicleComponent(GetPlayerVehicleID(playerid), aData[vehicleid][aMod10]);
	}
	if(aData[vehicleid][aMod11] != 0)
	{
		AddVehicleComponent(GetPlayerVehicleID(playerid), aData[vehicleid][aMod11]);
	}
	if(aData[vehicleid][aMod12] != 0)
	{
		AddVehicleComponent(GetPlayerVehicleID(playerid), aData[vehicleid][aMod12]);
	}
	if(aData[vehicleid][aMod13] != 0)
	{
		AddVehicleComponent(GetPlayerVehicleID(playerid), aData[vehicleid][aMod13]);
	}
	if(aData[vehicleid][aMod14] != 0)
	{
		AddVehicleComponent(GetPlayerVehicleID(playerid), aData[vehicleid][aMod14]);
	}
	if(aData[vehicleid][aMod15] != 0)
	{
		AddVehicleComponent(GetPlayerVehicleID(playerid), aData[vehicleid][aMod15]);
	}
	if(aData[vehicleid][aMod16] != 0)
	{
		AddVehicleComponent(GetPlayerVehicleID(playerid), aData[vehicleid][aMod16]);
	}
	if(aData[vehicleid][aMod17] != 0)
	{
		AddVehicleComponent(GetPlayerVehicleID(playerid), aData[vehicleid][aMod17]);
	}
	if(aData[vehicleid][aRenk1] > -1 || aData[vehicleid][aRenk2] > -1)
	{
		ChangeVehicleColor(GetPlayerVehicleID(playerid), aData[vehicleid][aRenk1], aData[vehicleid][aRenk2]);
 	}
	if(aData[vehicleid][aPaintJob] > -1)
	{
		ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), aData[vehicleid][aPaintJob]);
 	}
	return true;
}

stock ModVehicle_Yeni(id)
{
	new vehicleid = id;
	if(aData[vehicleid][aMod1] != 0)
	{
		AddVehicleComponent(aData[id][aID], aData[vehicleid][aMod1]);
	}
	if(aData[vehicleid][aMod2] != 0)
	{
		AddVehicleComponent(aData[id][aID], aData[vehicleid][aMod2]);
	}
	if(aData[vehicleid][aMod3] != 0)
	{
		AddVehicleComponent(aData[id][aID], aData[vehicleid][aMod3]);
	}
	if(aData[vehicleid][aMod4] != 0)
	{
		AddVehicleComponent(aData[id][aID], aData[vehicleid][aMod4]);
	}
	if(aData[vehicleid][aMod5] != 0)
	{
		AddVehicleComponent(aData[id][aID], aData[vehicleid][aMod5]);
	}
	if(aData[vehicleid][aMod6] != 0)
	{
		AddVehicleComponent(aData[id][aID], aData[vehicleid][aMod6]);
	}
	if(aData[vehicleid][aMod7] != 0)
	{
		AddVehicleComponent(aData[id][aID], aData[vehicleid][aMod7]);
	}
	if(aData[vehicleid][aMod8] != 0)
	{
		AddVehicleComponent(aData[id][aID], aData[vehicleid][aMod8]);
 	}
	if(aData[vehicleid][aMod9] != 0)
	{
		AddVehicleComponent(aData[id][aID], aData[vehicleid][aMod9]);
	}
	if(aData[vehicleid][aMod10] != 0)
	{
		AddVehicleComponent(aData[id][aID], aData[vehicleid][aMod10]);
	}
	if(aData[vehicleid][aMod11] != 0)
	{
		AddVehicleComponent(aData[id][aID], aData[vehicleid][aMod11]);
	}
	if(aData[vehicleid][aMod12] != 0)
	{
		AddVehicleComponent(aData[id][aID], aData[vehicleid][aMod12]);
	}
	if(aData[vehicleid][aMod13] != 0)
	{
		AddVehicleComponent(aData[id][aID], aData[vehicleid][aMod13]);
	}
	if(aData[vehicleid][aMod14] != 0)
	{
		AddVehicleComponent(aData[id][aID], aData[vehicleid][aMod14]);
	}
	if(aData[vehicleid][aMod15] != 0)
	{
		AddVehicleComponent(aData[id][aID], aData[vehicleid][aMod15]);
	}
	if(aData[vehicleid][aMod16] != 0)
	{
		AddVehicleComponent(aData[id][aID], aData[vehicleid][aMod16]);
	}
	if(aData[vehicleid][aMod17] != 0)
	{
		AddVehicleComponent(aData[id][aID], aData[vehicleid][aMod17]);
	}
	if(aData[vehicleid][aRenk1] > -1 || aData[vehicleid][aRenk2] > -1)
	{
		ChangeVehicleColor(aData[id][aID], aData[vehicleid][aRenk1], aData[vehicleid][aRenk2]);
 	}
	if(aData[vehicleid][aPaintJob] > -1)
	{
		ChangeVehiclePaintjob(aData[id][aID], aData[vehicleid][aPaintJob]);
 	}
	return true;
}

stock AraclariYukle()
{
	new sql[500], yuklenen = 0, id;
	format(sql, sizeof(sql), "SELECT * FROM `araclar`");
	mysql_query(db, sql);

	while(yuklenen < cache_num_rows())
	{
		cache_get_value_name_int(yuklenen, "id", id);
		cache_get_value_name_int(yuklenen, "sahip", aData[id][aSahip]);
		cache_get_value_name_int(yuklenen, "model", aData[id][aModel]);
		cache_get_value_name_int(yuklenen, "mod1", aData[id][aMod1]);
		cache_get_value_name_int(yuklenen, "mod2", aData[id][aMod2]);
		cache_get_value_name_int(yuklenen, "mod3", aData[id][aMod3]);
		cache_get_value_name_int(yuklenen, "mod4", aData[id][aMod4]);
		cache_get_value_name_int(yuklenen, "mod5", aData[id][aMod5]);
		cache_get_value_name_int(yuklenen, "mod6", aData[id][aMod6]);
		cache_get_value_name_int(yuklenen, "mod7", aData[id][aMod7]);
		cache_get_value_name_int(yuklenen, "mod8", aData[id][aMod8]);
		cache_get_value_name_int(yuklenen, "mod9", aData[id][aMod9]);
		cache_get_value_name_int(yuklenen, "mod10", aData[id][aMod10]);
		cache_get_value_name_int(yuklenen, "mod11", aData[id][aMod11]);
		cache_get_value_name_int(yuklenen, "mod12", aData[id][aMod12]);
		cache_get_value_name_int(yuklenen, "mod13", aData[id][aMod13]);
		cache_get_value_name_int(yuklenen, "mod14", aData[id][aMod14]);
		cache_get_value_name_int(yuklenen, "mod15", aData[id][aMod15]);
		cache_get_value_name_int(yuklenen, "mod16", aData[id][aMod16]);
		cache_get_value_name_int(yuklenen, "mod17", aData[id][aMod17]);
		cache_get_value_name_int(yuklenen, "paintjob", aData[id][aPaintJob]);
		cache_get_value_name_int(yuklenen, "renk1", aData[id][aRenk1]);
		cache_get_value_name_int(yuklenen, "renk2", aData[id][aRenk2]);
		cache_get_value_name_float(yuklenen, "x", aData[id][aX]);
		cache_get_value_name_float(yuklenen, "y", aData[id][aY]);
		cache_get_value_name_float(yuklenen, "z", aData[id][aZ]);
		cache_get_value_name_float(yuklenen, "f", aData[id][aF]);
		cache_get_value_name(yuklenen, "plaka", aData[id][aPlaka], 50);
		aData[id][aID] = CreateVehicle(aData[id][aModel], aData[id][aX], aData[id][aY], aData[id][aZ], aData[id][aF], aData[id][aRenk1], aData[id][aRenk2], -1);
		SetVehicleNumberPlate(aData[id][aID], aData[id][aPlaka]);
		SetVehicleToRespawn(aData[id][aID]);
		iArac[aData[id][aID]] = id;
		ModVehicle_Yeni(id);
		aData[id][aBenzin] = 100;
		Iter_Add(araclar, id);
		aData[id][aKilit] = true;
		yuklenen++;
	}

	printf("<< ARAÇ >> Toplam %d araç yüklendi.", yuklenen);
	return true;
}

//=-=-==-=-==-=-==-=-==-=-==-=-= KOMUTLAR =-=-==-=-==-=-==-=-==-=-==-=-=

CMD:level(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1) return YetersizSeviye(playerid, 1);
	new level, dialog[10000], baslik[100];
	if(sscanf(params, "i", level)) return Kullanim(playerid, "level [1-10]");
	if(level < 1 || level > 10) return Hata(playerid, "Level en az 1, en fazla 10 olabilir.");
	if(pData[playerid][pAdmin] < level) return Hata(playerid, "Level kendi levelinizden büyük seçilemez.");

	strcat(dialog, ""w"Komut\t"w"Açýklama\n");
	for(new i; i < sizeof(Komutlar); i++)
	{
		if(Komutlar[i][Level] == level)
		{
			format(dialog, sizeof(dialog), "%s"ad"/%s\t"w"%s\n", dialog, Komutlar[i][Isim], Komutlar[i][Aciklama]);
		}
	}

	format(baslik, sizeof(baslik), "Admin Komutlarý - Level %d", level);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, baslik, dialog, "Kapat", "");
	return true;
}

CMD:cmds(playerid, params[])
{
	new dialog[100000];
	strcat(dialog, ""w"Komut\t"w"Açýklama\n");
	for(new i; i < sizeof(Komutlar); i++)
	{
		if(Komutlar[i][Level] == 0)
		{
			format(dialog, sizeof(dialog), "%s"ad"/%s\t"w"%s\n", dialog, Komutlar[i][Isim], Komutlar[i][Aciklama]);
		}
	}
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "Komutlar", dialog, "Kapat", "");
	return true;
}

CMD:aka(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1) return YetersizSeviye(playerid, 1);
	new id, sql[500], str[1000], isim[24], ip[50];
	if(sscanf(params, "u", id)) return Kullanim(playerid, "aka [ID/Isim]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil.");
	if(pData[id][pAdmin] > pData[playerid][pAdmin]) return Hata(playerid, "Oyuncu sizden yüksek level!");
	strcat(str, ""w"Sýra\t"w"Ýsim\n");

	GetPlayerIp(id, ip, 50);
	format(sql, sizeof(sql), "SELECT * FROM `akalar` WHERE `ip` = '%s'", ip);
	mysql_query(db, sql);

	for(new i; i < cache_num_rows(); i++)
	{
		cache_get_value_name(i, "isim", isim, 24);
		format(str, sizeof(str), "%s"wb"%d.\t"w"%s\n", str, i + 1, isim);
	}
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "Aka", str, "Kapat", "");
	return true;
}

CMD:youtube(playerid, params[])
{
	new str[1000], sayi;
	strcat(str, ""w"Þarký\t"w"Ekleyen\t"w"Süre\t"w"Durum\n");
	for(new i = 499; i != 0; i--)
	{
		if(YTInfo[i][Caliniyor] == true || YTInfo[i][Sirada] == true)
		{
			format(str, sizeof(str), "%s"w"%s\t"w"%s\t"w"%s\t"w"%s\n", str, YTInfo[i][Isim], YTInfo[i][Ekleyen], ConvertTime(YTInfo[i][Sure]), (YTInfo[i][Caliniyor] == true ? (""ad"Çalýyor") : (""r"Sýrada")));
			sayi++;
		}
	}
	if(sayi == 0)
	{
		strcat(str, ""w"Liste boþ");
	}
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "Youtube", str, "Kapat", "");
	return true;
}

CMD:youtubeara(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5) return YetersizSeviye(playerid, 5);
	new kelime[50], link[1024];
	if(YT_Islem == true) return Hata(playerid, "Þu anda baþka bir youtube iþlemi yapýlýyor, lütfen bekleyiniz.");
	if(sscanf(params, "s[50]", kelime)) return Kullanim(playerid, "youtubeara [Anahtar Kelime]");
	strreplace(kelime, " ", "_");
	format(link, sizeof(link), "michaelbelgium.me/ytconverter/search.php?q=%s&max_results=5", code(kelime));
	HTTP(playerid, HTTP_GET, link, "", "YT_Arama");
	YT_Islem = true;
	YT_Kullanan = playerid;
	return true;
}

CMD:youtubegec(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5) return YetersizSeviye(playerid, 5);
	new sayim;
	for(new i = 499; i != 0; i--)
	{
		if(YTInfo[i][Caliniyor] == true)
		{
			sayim++;
		}
	}
	if(sayim == 0) return Hata(playerid, "Zaten bir þarký çalmýyor.");
	AdminBilgi(playerid, "Þarký baþarýyla geçildi.");
	for(new i = 499; i != 0; i--)
	{
		if(YTInfo[i][Caliniyor] == true)
		{
			SarkiBitti(i);
			break;
		}
	}
	return true;
}

CMD:unban(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5) return YetersizSeviye(playerid, 5);
	new dialog[350];
	strcat(dialog, ""wb">> "w"IP Banlarý Listele\n");
	strcat(dialog, ""wb">> "w"Isim ile IP Ban Aç\n");
	strcat(dialog, " \n");
	strcat(dialog, ""wb">> "w"Nick Banlarý Listele\n");
	strcat(dialog, ""wb">> "w"Isim ile Nick Ban Aç\n");
	strcat(dialog, " \n");
	strcat(dialog, ""wb">> "w"Serial Banlarý Listele\n");
	strcat(dialog, ""wb">> "w"Isim ile Serial Ban Aç");
	ShowPlayerDialog(playerid, DIALOG_UNBAN, DIALOG_STYLE_LIST, "Unban", dialog, "Seç", "Kapat");
	return true;
}

CMD:bugraporlar(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6) return YetersizSeviye(playerid, 6);
	new sql[500], str[10000], raporsayi, gonderen[24], tarih[50], okundu;

	strcat(str, ""w"Sýra\t"w"Gönderen\t"w"Tarih\t"w"Durum\n");
	SetPVarInt(playerid, "BugRaporSayfa", 0);
	for(new i; i < 20; i++) BugRaporID[playerid][i] = -1;
	format(sql, sizeof(sql), "SELECT * FROM `bugrapor_log` LIMIT %d, 10", GetPVarInt(playerid, "BugRaporSayfa"));
	mysql_query(db, sql);

	SetPVarInt(playerid, "BugRaporSayfa", GetPVarInt(playerid, "BugRaporSayfa") + 10);

	cache_get_row_count(raporsayi);

	for(new i; i < 10; i++)
	{
		if(i < raporsayi)
		{
			cache_get_value_name_int(i, "id", BugRaporID[playerid][i]);
			cache_get_value_name(i, "gonderen", gonderen, 24);
			cache_get_value_name(i, "tarih", tarih, 50);
			cache_get_value_name_int(i, "okundu", okundu);
			format(str, sizeof(str), "%s"w"%d-)\t"w"%s\t"w"%s\t%s\n", str, i + 1, gonderen, tarih, (okundu == 0 ? (""ad"Okunmamýþ") : (""r"Okunmuþ")));
		}
		else
		{
			format(str, sizeof(str), "%s"w"%d-)\t{A9A9A9}---\t{A9A9A9}---\t{A9A9A9}---\n", str, i + 1);
		}
	}

	mysql_query(db, "SELECT * FROM `bugrapor_log`");
	if(cache_num_rows() > 10)
	{
		strcat(str, ">> Sonraki Sayfa");
	}

	ShowPlayerDialog(playerid, DIALOG_BUGRAPORLAR, DIALOG_STYLE_TABLIST_HEADERS, "Bug Raporlarý", str, "Seç", "Kapat");
	return true;
}

CMD:netstats(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4) return YetersizSeviye(playerid, 4);
	new id;
	if(sscanf(params, "u", id)) return Kullanim(playerid, "netstats [ID/Isim]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	if(pData[id][pAdmin] > pData[playerid][pAdmin]) return Hata(playerid, "Oyuncu sizden yüksek level!");
	new str[1024];
	format(str, sizeof(str), "{%06x}%s {FFFFFF}- Netstats\n\n\
		\t"w"Ülke: "wb"%s\n\
		\t"w"Þehir: "wb"%s\n\
		\t"w"LAT: "wb"%s\n\
		\t"w"LON: "wb"%s\n\
		\t"w"Saðlayýcý: "wb"%s\n\
		\t"w"Proxy Var Mý?: "wb"%s", GetPlayerColor(id) >>> 8, getName(id), GetPlayerCountry(id), code(GetPlayerCity(id)), 
		GetPlayerLatitude(id), GetPlayerLongtitude(id), GetPlayerProvider(id), GetPlayerProxyStatus(id));
	strreplace(str, "false", "Hayýr");
	strreplace(str, "true", "Evet");
	strreplace(str, "\"", "");
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Netstats", str, "Kapat", "");
	return true;
}

CMD:silahlar(playerid, params[])
{
	ShowPlayerMenu(playerid, SILAHLAR, "Silah Dukkani");
	for(new i; i < sizeof(Silahlar); i++)
	{
		AddPlayerMenuItem(playerid, Silahlar[i][sIsim], "Fiyat: $10.000");
	}
	TogglePlayerControllable(playerid, false);
	return true;
}

CMD:testler(playerid, params[])
{
	if(pData[playerid][pAdmin] < 7) return YetersizSeviye(playerid, 7);
	new str[1024];
	strcat(str, ""w"#\t"w"Test\t"w"Tekrarlama Süresi\n");
	strcat(str, ""wb"»\t"w"Reaksiyon Testi\t"wb"8 "w"Dakika\n");
	strcat(str, ""wb"»\t"w"Matematik Testi\t"wb"10 "w"Dakika\n");
	strcat(str, ""wb"»\t"w"Lotto\t"wb"15 "w"Dakika\n");
	ShowPlayerDialog(playerid, DIALOG_TESTLER, DIALOG_STYLE_TABLIST_HEADERS, ""w"Testler", str, "Baþlat", "Iptal");
	return true;
}

CMD:arkadaslarim(playerid, params[])
{
	new str[1024], durum[50], slot;
	strcat(str, ""w"Isim\t"w"Durum\n");
	strcat(str, ""w"Arkadaþ Ekle\n"w"Arkadaþ Sil\n");
	if(Iter_Count(arkadaslarim<playerid>) > 0)
	{
		foreach(new i: arkadaslarim<playerid>)
		{
			new id = GetPlayerID(SQL_Isim_Cek(i));
		    switch(IsPlayerConnected(id))
		    {
				case 0: durum = ""r"Çevrimdýþý";
				case 1: durum = ""ad"Çevrimiçi";
		    }
		    Arkadaslar[playerid][slot] = i;
		    format(str, sizeof(str), "%s%s\t%s\n", str, SQL_Isim_Cek(i), durum);
		    slot++;
		}
	}
	ShowPlayerDialog(playerid, DIALOG_ARKADASLARIM, DIALOG_STYLE_TABLIST_HEADERS, "Arkadaþlarým", str, "Seç", "Iptal");
	return true;
}

CMD:evim(playerid, params[])
{
	if(pData[playerid][pEv] == -1) return Hata(playerid, "Bir eviniz yok!");
	if(pData[playerid][pEvde] == false) return Hata(playerid, "Bir evde deðilsiniz!");
	if(pData[playerid][pEvde] == true && pData[playerid][pEv] != GetPVarInt(playerid, "ev_ID")) return Hata(playerid, "Bu ev sizin deðil!");
	new str[5000], str2[500], id = pData[playerid][pEv];

	format(str2, sizeof(str2), ""wb"» "w"Ev Ýsmi: "wb"%s\n", EvInfo[id][evIsim]);
	strcat(str, str2);
	format(str2, sizeof(str2), ""wb"» "w"Ev Fiyatý: "wb"%s TL\n", FormatMoney(EvInfo[id][evFiyat]));
	strcat(str, str2);
	format(str2, sizeof(str2), ""wb"» "w"Ev Sahibi: "wb"%s\n", SQL_Isim_Cek(EvInfo[id][evSahip]));
	strcat(str, str2);
	format(str2, sizeof(str2), ""wb"» "w"Ev Bölgesi: "wb"%s\n", GetZoneName(EvInfo[id][evX], EvInfo[id][evY], EvInfo[id][evZ]));
	strcat(str, str2);
	format(str2, sizeof(str2), " \n");
	strcat(str, str2);
	format(str2, sizeof(str2), ""wb"» "w"Ev Ýsmini Deðiþtir\n");
	strcat(str, str2);
	format(str2, sizeof(str2), ""wb"» "w"Ev Durumu: %s\n", (EvInfo[id][evKilit] == 1 ? (""r"Kapalý") : (""ad"Açýk")));
	strcat(str, str2);
	format(str2, sizeof(str2), ""wb"» "w"Ev Eþyalarý\n");
	strcat(str, str2);
	format(str2, sizeof(str2), " \n");
	strcat(str, str2);
	format(str2, sizeof(str2), ""wb"» "w"Evi Sat");
	strcat(str, str2);

	ShowPlayerDialog(playerid, DIALOG_EVIM, DIALOG_STYLE_LIST, "Ev Menüsü", str, "Seç", "Kapat");
	return true;
}

CMD:evimegit(playerid, params[])
{
	if(pData[playerid][pEv] == -1) return Hata(playerid, "Bir eviniz yok!");
	new id = pData[playerid][pEv];
	SetPlayerPV(playerid, EvInfo[id][evX], EvInfo[id][evY], EvInfo[id][evZ]);
	Bilgi(playerid, "Baþarýyla evinize ýþýnlandýnýz.");
	return true;
}

CMD:evesya(playerid, params[])
{
	if(pData[playerid][pEv] == -1) return Hata(playerid, "Bir eviniz yok!");
	if(pData[playerid][pEvde] == false) return Hata(playerid, "Bir evde deðilsiniz!");
	if(pData[playerid][pEvde] == true && pData[playerid][pEv] != GetPVarInt(playerid, "ev_ID")) return Hata(playerid, "Bu ev sizin deðil!");
	ShowModelSelectionMenu(playerid, oturak_liste, "Esyalar");
	return true;
}

CMD:z(playerid, params[])
{
	ClearAnimationsEx(playerid);
	Bilgi(playerid, "Animasyonu durdurdunuz!");
	return true;
}

CMD:god(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6) return YetersizSeviye(playerid, 6);
	if(pData[playerid][pGod] == false)
	{
		pData[playerid][pGod] = true;
		AdminBilgi(playerid, "God-mode aktifleþtirildi.");
	}
	else if(pData[playerid][pGod] == true)
	{
		pData[playerid][pGod] = false;
		AdminBilgi(playerid, "God-mode kapatýldý.");
	}
	return true;
}

CMD:savepos(playerid, params[])
{
	new str[2048], durum[20], bolge[50];
	strcat(str, "{FFFFFF}Slot\t{FFFFFF}Durum\t{FFFFFF}Bölge\n");
	for(new i; i < 5; i++)
	{
		if(Poslar[playerid][i][0] == -1.0 || Poslar[playerid][i][1] == -1.0 || Poslar[playerid][i][2] == -1.0)
		{
			durum = ""ad"BOÞ";
			bolge = ""r"-";
		}
		else
		{
			durum = ""r"DOLU";
			format(bolge, sizeof(bolge), ""ad"%s", GetZoneName(Poslar[playerid][i][0], Poslar[playerid][i][1], Poslar[playerid][i][2]));
		}
		format(str, sizeof(str), "%s"wb"» "w"Slot %d\t%s\t%s\n", str, i + 1, durum, bolge);
	}
	ShowPlayerDialog(playerid, DIALOG_SAVEPOS, DIALOG_STYLE_TABLIST_HEADERS, "Savepos", str, "Kaydet", "Iptal");
	return true;
}

CMD:loadpos(playerid, params[])
{
	new str[2048], durum[20], bolge[50];
	strcat(str, "{FFFFFF}Slot\t{FFFFFF}Durum\t{FFFFFF}Bölge\n");
	for(new i; i < 5; i++)
	{
		if(Poslar[playerid][i][0] == -1.0 || Poslar[playerid][i][1] == -1.0 || Poslar[playerid][i][2] == -1.0)
		{
			durum = ""ad"BOÞ";
			bolge = ""r"-";
		}
		else
		{
			durum = ""r"DOLU";
			format(bolge, sizeof(bolge), ""ad"%s", GetZoneName(Poslar[playerid][i][0], Poslar[playerid][i][1], Poslar[playerid][i][2]));
		}
		format(str, sizeof(str), "%s"wb"» "w"Slot %d\t%s\t%s\n", str, i + 1, durum, bolge);
	}
	ShowPlayerDialog(playerid, DIALOG_LOADPOS, DIALOG_STYLE_TABLIST_HEADERS, "Loadpos", str, "Iþýnlan", "Iptal");
	return true;
}

CMD:sarki(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5) return YetersizSeviye(playerid, 5);
	new link[256], isim[50], str[512];
	if(sscanf(params, "s[256]s[50]", link, isim)) return Kullanim(playerid, "sarki [Þarký Linki] [Þarký Isimi]");
	foreach(new i: Player)
	{
		StopAudioStreamForPlayer(i);
		PlayAudioStreamForPlayer(i, link);
	}
	format(str, sizeof(str), "~p~[SARKI] ~w~~h~~h~%s ~p~>> ~w~~h~~h~%s", getName(playerid), isim);
	TextMesaji(code(str));
	return true;
}

CMD:galeri(playerid, params[])
{
	if(pData[playerid][pArac] != -1) return Hata(playerid, "Zaten bir aracýnýz var!");
	if(GetPlayerMoney(playerid) < 14000) return Hata(playerid, "Araç alabilmek için 14.000 TL'ye ihtiyacýnýz var!");
	foreach(new i: galeriler)
	{
		if(IsPlayerInRangeOfPoint(playerid, 1.0, gData[i][gX], gData[i][gY], gData[i][gZ]))
		{
			return ShowModelSelectionMenu(playerid, galeri_liste, "Galerideki Araclar");
		}
	}
	Hata(playerid, "Herhangi bir galerinin üzerinde deðilsiniz!");
	return true;
}

CMD:galeriyarat(playerid, params[])
{
	if(pData[playerid][pAdmin] < 10) return YetersizSeviye(playerid, 10);
	new id = Iter_Free(galeriler), Float: x, Float: y, Float: z, sql[500];
	GetPlayerPos(playerid, x, y, z);
	gData[id][gID] = id;
	gData[id][gX] = x;
	gData[id][gY] = y;
	gData[id][gZ] = z;
	gData[id][gLabel] = CreateDynamic3DTextLabel(""ad"ARAÇ GALERÝSÝ\n"w"Ýstediðiniz aracý sýfýr bir þekilde alabilirsiniz.", -1, gData[id][gX], gData[id][gY], gData[id][gZ], 35.0);
	gData[id][gPickup] = CreateDynamicPickup(1239, 1, gData[id][gX], gData[id][gY], gData[id][gZ]);
	gData[id][gMapIcon] = CreateDynamicMapIcon(gData[id][gX], gData[id][gY], gData[id][gZ], 11, 0);
	Iter_Add(galeriler, id);
	Bilgi(playerid, "Galeri baþarýyla oluþturuldu!");
	format(sql, sizeof(sql), "INSERT INTO `galeriler` (`id`, `x`, `y`, `z`) VALUES ('%d', '%f', '%f', '%f')", 
		id, x, y, z);
	mysql_query(db, sql);
	return true;
}

CMD:galerisil(playerid, params[])
{
	foreach(new i: galeriler)
	{
		if(IsPlayerInRangeOfPoint(playerid, 1.0, gData[i][gX], gData[i][gY], gData[i][gZ]))
		{
			new sql[128];
			gData[i][gID] = -1;
			gData[i][gX] = 0;
			gData[i][gY] = 0;
			gData[i][gZ] = 0;
			if(IsValidDynamic3DTextLabel(gData[i][gLabel]))
				DestroyDynamic3DTextLabel(gData[i][gLabel]);
			if(IsValidDynamicPickup(gData[i][gPickup]))
				DestroyDynamicPickup(gData[i][gPickup]);
			DestroyDynamicMapIcon(gData[i][gMapIcon]);
			Iter_Remove(galeriler, i);
			format(sql, sizeof(sql), "DELETE FROM `galeriler` WHERE `id` = '%d'", i);
			mysql_query(db, sql);
			return Bilgi(playerid, "Galeri silindi!");
		}
	}
	Hata(playerid, "Herhangi bir galerinin üzerinde deðilsiniz!");
	return true;
}

CMD:myskin(playerid, params[])
{
	if(GetPlayerMoney(playerid) < 5) return Hata(playerid, "Skin deðiþtirebilmek için {FF0000}5 TL'ye {FFFFFF}ihtiyacýnýz var!");
	new id;
	if(sscanf(params, "i", id)) return Kullanim(playerid, "myskin [Skin ID]");
	if(id < 0 || id > 311) return Hata(playerid, "Bu ID'de bir skin yok!");
	SetPlayerSkin(playerid, id);
	GivePlayerMoney(playerid, -5);
	Bilgi(playerid, "Skininiz baþarýlý bir þekilde deðiþtirildi!");
	return true;
}

CMD:unjail(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1 && pData[playerid][pAnim] < 1) return YetersizSeviye(playerid, 1);
	new id, str[512];
	if(sscanf(params, "u", id)) return Kullanim(playerid, "unjail [ID/Isim]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	if(pData[id][pJail] <= 0) return Hata(playerid, "Oyuncu zaten hapiste deðil!");
	SetPlayerTeam(id, 0);
	SetPlayerInterior(id, 0);
	SetPlayerVirtualWorld(id, 0);
	SetPlayerWorldBounds(id, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
	SpawnPlayer(id);
	pData[id][pJail] = 0;
	format(str, sizeof(str), "Yetkili "wb"%s "w"sizi hapisten çýkardý!", getName(playerid));
	AdminBilgi(id, str);
	format(str, sizeof(str), ""wb"%s "w"adlý oyuncuyu hapisten çýkardýnýz!", getName(id));
	AdminBilgi(playerid, str);
	format(str, sizeof(str), "~p~[UN-JAIL] ~w~~h~~h~%s ~p~>> ~w~~h~~h~%s", getName(playerid), getName(id));
	TextMesaji(code(str));
	OyuncuKaydet(id);
	return true;
}

CMD:jail(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1 && pData[playerid][pAnim] < 1) return YetersizSeviye(playerid, 1);
	new id, sure, sebep[250], str[512];
	if(sscanf(params, "uis[250]", id, sure, sebep)) return Kullanim(playerid, "jail [ID/Isim] [Süre(dk)] [Sebep]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	if(pData[id][pJail] > 0) return Hata(playerid, "Oyuncu zaten hapiste!");
	SetPlayerTeam(id, 20);
	SetPlayerInterior(id, 20);
	SetPlayerVirtualWorld(id, 20);
	SetPlayerPos(id, -1532.0116, 2686.3806, 55.8359);
	SetPlayerWorldBounds(id, -1532.0116 + 10, -1532.0116 - 10, 2686.3806 + 10, 2686.3806 - 10);
	ResetPlayerWeapons(id);
	pData[id][pJail] = sure * 60;
	format(str, sizeof(str), "Yetkili "wb"%s "w"sizi hapise attý! Sebep: "wb"%s", getName(playerid), sebep);
	AdminBilgi(id, str);
	format(str, sizeof(str), ""wb"%s "w"adlý oyuncuyu hapise attýnýz. Sebep: "wb"%s", getName(id), sebep);
	AdminBilgi(playerid, str);
	format(str, sizeof(str), "~p~[JAIL] ~w~~h~~h~%s ~p~>> ~w~~h~~h~%s ~p~(Dakika: %d) (Sebep: %s)", getName(playerid), getName(id), sure, sebep);
	TextMesaji(code(str));
	OyuncuKaydet(id);
	return true;
}

CMD:renkler(playerid, params[])
{
	new str[100000];
	for(new i = 0; i < 100; i++)
	{
		format(str, sizeof(str), "%s{%06x}Oyuncu Rengi %d - (100 TL)\n", str, Oyuncu_Renkleri[i] >>> 8, i + 1);
	}
	ShowPlayerDialog(playerid, DIALOG_RENKLER, DIALOG_STYLE_LIST, "Renkler", str, "Satýn Al", "Çýk");
	return true;
}

CMD:spawnsilahlari(playerid, params[])
{
	new str[5000], durum[25], silah[25];
	strcat(str, "{FFFFFF}Slot\t{FFFFFF}Durum\t{FFFFFF}Silah\n");
	for(new i = 0; i < 6; i++)
	{
		if(pData[playerid][pSilahlar][i] == -1)
		{
			durum = ""ad"BOÞ";
			silah = ""r"-";
		}
		else
		{
			durum = ""r"DOLU";
			format(silah, sizeof(silah), ""ad"%s", GetWeaponNameEx(pData[playerid][pSilahlar][i]));
		}
		format(str, sizeof(str), "%s"wb"» "w"Slot %d\t%s\t%s\n", str, i + 1, durum, silah);
	}
	strcat(str, ""wb"» "w"Seçimleri Sýfýrla");
	ShowPlayerDialog(playerid, DIALOG_SPAWNSILAHLARI, DIALOG_STYLE_TABLIST_HEADERS, "Spawn Silahlarý", str, "Seç", "Kapat");
	return true;
}
alias:spawnsilahlari("/spawnsilahlar");

CMD:akill(playerid, params[])
{
	if(pData[playerid][pAdmin] < 3 && pData[playerid][pAnim] < 3) return YetersizSeviye(playerid, 3);
	new id, str[512];
	if(sscanf(params, "u", id)) return Kullanim(playerid, "akill [ID/Isim]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	if(pData[playerid][pAdmin] < pData[id][pAdmin]) return Hata(playerid, "Oyuncu sizden yüksek level!");
	format(str, sizeof(str), "Yetkili "wb"%s "w"sizi öldürdü!", getName(playerid));
	AdminBilgi(id, str);
	format(str, sizeof(str), ""wb"%s "w"adlý oyuncuyu öldürdünüz!", getName(id));
	AdminBilgi(playerid, str);
	SetPlayerHealth(id, -1.0);
	return true;
}

CMD:weaps(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1 && pData[playerid][pAnim] < 1) return YetersizSeviye(playerid, 1);
	new id, silah, mermi, sayim, str[1024];
	if(sscanf(params, "u", id)) return Kullanim(playerid, "weaps [ID/Isim]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	if(pData[playerid][pAdmin] < pData[id][pAdmin]) return Hata(playerid, "Oyuncu sizden yüksek level!");
	sayim = 0;
	for(new i = 0; i < 14; i++)
	{
		GetPlayerWeaponData(id, i, silah, mermi);
		if(silah != 0 && mermi != 0) sayim++;
	}
	if(sayim == 0) return Hata(playerid, "Oyuncunun hiç silahý yok!");
	for(new i = 0; i < 14; i++)
	{
		GetPlayerWeaponData(id, i, silah, mermi);
		if(silah != 0 && mermi != 0) format(str, sizeof(str), "%s"wb"» "w"%s - %s mermi\n", str, GetWeaponNameEx(silah), FormatMoney(mermi));
	}
	ShowPlayerDialog(playerid, DIALOG_WEAPS, DIALOG_STYLE_MSGBOX, "Kullanýcýnýn Silahlarý", str, "Kapat", "");
	return true;
}

CMD:warn(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2 && pData[playerid][pAnim] < 2) return YetersizSeviye(playerid, 2);
	new id, sebep[250], str[512];
	if(sscanf(params, "us[250]", id, sebep)) return Kullanim(playerid, "warn [ID/Isim] [Sebep]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	pData[id][pUyarilar]++;
	format(str, sizeof(str), "Yetkili "wb"%s "w"sizi uyardý! Sebep: "wb"%s", getName(playerid), sebep);
	AdminBilgi(id, str);
	format(str, sizeof(str), ""wb"%s "w"adlý oyuncuyu uyardýnýz! Sebep: "wb"%s", getName(id), sebep);
	AdminBilgi(playerid, str);
	format(str, sizeof(str), "~p~[WARN] ~w~~h~~h~%s ~p~>> ~w~~h~~h~%s (~y~%d~w~~h~~h~/~r~3~w~~h~~h~) ~p~(Sebep: %s)", getName(playerid), getName(id), pData[id][pUyarilar], sebep);
	TextMesaji(code(str));
	if(pData[id][pUyarilar] >= 3) SistemKick(id, "Uyari Siniri Asildi");
	return true;
}

CMD:rac(playerid, params[])
{
	if(pData[playerid][pAdmin] < 7) return YetersizSeviye(playerid, 7);
	for(new i = 1; i <= MAX_VEHICLES; i++)
	{
		if(IsVehicleEmpty(i)) SetVehicleToRespawn(i);
	}
	AdminBilgi(playerid, "Kullanýlmayan tüm araçlarý tekrardan spawn ettiniz!");
	return true;
}

CMD:re(playerid, params[])
{
	if(SonPM[playerid] == -1) return Hata(playerid, "Son PM'niz bulunmamakta!");
	new id = SonPM[playerid], mesaj[250], komut[2048];
	if(sscanf(params, "s[250]", mesaj)) return Kullanim(playerid, "re [Mesaj]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	format(komut, sizeof(komut), "/pm %d %s", id, mesaj);
	PC_EmulateCommand(playerid, komut);
	return true;
}

CMD:pm(playerid, params[])
{
	new id, mesaj[250], str[1024];
	if(sscanf(params, "us[250]", id, mesaj)) return Kullanim(playerid, "pm [ID/Isim] [Mesaj]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	format(str, sizeof(str), "{FFFF00}»» Gelen PM: %s(%d): %s", getName(playerid), playerid, mesaj);
	SCM(id, -1, str);
	format(str, sizeof(str), "{FFFF00}«« Giden PM: %s(%d): %s", getName(id), id, mesaj);
	SCM(playerid, -1, str);
	SonPM[playerid] = id;
	SonPM[id] = playerid;
	return true;
}

CMD:c(playerid, params[])
{
	if(pData[playerid][pKlan] == -1) return Hata(playerid, "Klan sohbeti kullanmak için bir klana mensup olmalýsýn!");
	new yazi[1024];
	if(sscanf(params, "s[1024]", yazi)) return Kullanim(playerid, "c [Yazý]");
	new str[2048], id = pData[playerid][pKlan];
	format(str, sizeof(str), "{%06x}[%s] - %s Sohbet: {%06x}%s({FFFFFF}%d{%06x}): {FFFFFF}%s", 
		KlanRenkleri[kData[id][kRenk]] >>> 8, kData[id][kTag], kData[id][kIsim], GetPlayerColor(playerid) >>> 8, getName(playerid), 
		playerid, GetPlayerColor(playerid) >>> 8, yazi);
	KlanMesaji(id, str);
	return true;
}

CMD:fcmd(playerid, params[])
{
	if(pData[playerid][pAdmin] < 8) return YetersizSeviye(playerid, 8);
	new id, komut[250];
	if(sscanf(params, "us[250]", id, komut)) return Kullanim(playerid, "fcmd [ID/Isim] [Komut]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	PC_EmulateCommand(id, komut);
	return true;
}

CMD:fchat(playerid, params[])
{
	if(pData[playerid][pAdmin] < 8) return YetersizSeviye(playerid, 8);
	new id, yazi[250];
	if(sscanf(params, "us[250]", id, yazi)) return Kullanim(playerid, "fchat [ID/Isim] [Yazý]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	OnPlayerText(id, yazi);
	return true;
}

CMD:hesabim(playerid, params[])
{
	if(Bankada[playerid] == false) return Hata(playerid, "Bu komutu kullanabilmek için bankada olmalýsýnýz!");
	if(pData[playerid][pBankaHesap] == -1)
	{
		ShowPlayerDialog(playerid, DIALOG_BANKA, DIALOG_STYLE_TABLIST_HEADERS, "Banka Hesabým", "#\t#\n»\tHesap Oluþtur", "Seç", "Iptal");
	}
	else
	{
		new str[1024], id = pData[playerid][pBankaHesap];
		strcat(str, ""wb"» "w"Hesap ID\t"wb"» "w"Sahip\t"wb"» "w"Bakiye\t"wb"» "w"Oluþturulma\n");
		format(str, sizeof(str), "%s"wb"» "w"%d\t"wb"» "w"%s\t"wb"» "w"%s TL\t"wb"» "w"%s", str, bData[id][bId], SQL_Isim_Cek(bData[id][bSahip]), FormatMoney(bData[id][bBakiye]), bData[id][bOlusturma]);
		ShowPlayerDialog(playerid, DIALOG_BANKA, DIALOG_STYLE_TABLIST_HEADERS, "Banka Hesabým", str, "Seç", "Iptal");
	}
	return true;
}

CMD:banka(playerid, params[])
{
	//new id = randomEx(0, sizeof(BankaPoslari) - 1);
	new Float: yakinlik = 999999999.0, id;
	for(new i = 0; i < sizeof(BankaPoslari); i++)
	{
		if(GetPlayerDistanceFromPoint(playerid, BankaPoslari[i][0], BankaPoslari[i][1], BankaPoslari[i][2]) < yakinlik)
		{
			yakinlik = GetPlayerDistanceFromPoint(playerid, BankaPoslari[i][0], BankaPoslari[i][1], BankaPoslari[i][2]);
			id = i;
		}
	}
	SetPlayerPos(playerid, BankaPoslari[id][0], BankaPoslari[id][1], BankaPoslari[id][2]);
	SetPlayerInterior(playerid, 0);
	Bilgi(playerid, "Konumunuzun en yakýn olduðu bankaya ýþýnlandýnýz.");
	return true;
}

CMD:basarimlarim(playerid, params[])
{
	new str[10000], str2[512];
	format(str2, sizeof(str2), "{%06x}%s {FFC400}Baþarýmlarý\n{FFC400}==========================================================================\n", GetPlayerColor(playerid) >>> 8, getName(playerid));
	strcat(str, str2);
	for(new i = 0; i < sizeof(Basarimlar); i++)
	{
		format(str, sizeof(str), "%s%s%02d. %s: "w"%s\n", str, (Basarimlarim[playerid][i] == 1 ? (""ad"") : (""r"")), i + 1, Basarimlar[i][bIsim], Basarimlar[i][bAciklama]);
	}
	strcat(str, "{FFC400}==========================================================================\n\n");
	strcat(str, ""ad"Yeþil "w"renkte göstrilen baþarýmlar tamamlanmýþ, "r"kýrmýzý "w"renkte gösterilen baþarýmlar tamamlanmamýþtýr.");
	ShowPlayerDialog(playerid, DIALOG_BASARIMLARIM, DIALOG_STYLE_MSGBOX, "Baþarýmlarým", str, "Kapat", "");
	return true;
}

CMD:unmute(playerid, params[])
{
	if(pData[playerid][pAnim] < 1 && pData[playerid][pAdmin] < 1) return YetersizSeviye(playerid, 1);
	new id, str[512];
	if(sscanf(params, "u", id)) return Kullanim(playerid, "unmute [ID/Isim]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	if(pData[id][pAdmin] > pData[playerid][pAdmin]) return Hata(playerid, "Oyuncu sizden yüksek level!");
	if(pData[id][pMute] <= 0) return Hata(playerid, "Oyuncu zaten susturulmamýþ!");
	pData[id][pMute] = 0;
	format(str, sizeof(str), "Yetkili "wb"%s "w"susturma cezanýzý kaldýrdý!", getName(playerid));
	AdminBilgi(id, str);
	format(str, sizeof(str), ""wb"%s "w"adlý oyuncunun susturma cezasýný kaldýrdýnýz.", getName(id));
	AdminBilgi(playerid, str);
	format(str, sizeof(str), "~p~[UN-MUTE] ~w~~h~~h~%s ~p~>> ~w~~h~~h~%s", getName(playerid), getName(id));
	TextMesaji(code(str));
	OyuncuKaydet(id);
	return true;
}

CMD:mute(playerid, params[])
{
	if(pData[playerid][pAnim] < 1 && pData[playerid][pAdmin] < 1) return YetersizSeviye(playerid, 1);
	new id, sure, sebep[250], str[512];
	if(sscanf(params, "uis[250]", id, sure, sebep)) return Kullanim(playerid, "mute [ID/Isim] [Süre(dakika)] [Sebep]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	if(pData[id][pAdmin] > pData[playerid][pAdmin]) return Hata(playerid, "Oyuncu sizden yüksek level!");
	if(pData[id][pMute] > 0) return Hata(playerid, "Oyuncu zaten susturulmuþ!");
	pData[id][pMute] = sure * 60;
	format(str, sizeof(str), ""wb"%s "w"adlý oyuncuyu "wb"%d "w"dakika susturdunuz.", getName(id), sure);
	AdminBilgi(playerid, str);
	format(str, sizeof(str), "Yetkili "wb"%s "w"sizi "wb"%d "w"dakika susturdu.", getName(playerid), sure);
	AdminBilgi(id, str);
	format(str, sizeof(str), "~p~[MUTE] ~w~~h~~h~%s ~p~>> ~w~~h~~h~%s ~p~(%d Dakika) (Sebep: %s)", getName(playerid), getName(id), sure, sebep);
	TextMesaji(code(str));
	OyuncuKaydet(id);
	return true;
}

CMD:klanlar(playerid, params[])
{
	new sql[500], isim[50], tag[10], level, renk, str[10000], baslik[150];
	format(sql, sizeof(sql), "SELECT * FROM `klanlar` ORDER BY `level` DESC LIMIT 10");
	mysql_query(db, sql);

	strcat(str, "{A9A9A9}Klan Ýsmi\t{A9A9A9}Klan Seviyesi\t{A9A9A9}Klan Üye Sayýsý\t{A9A9A9}Klan Giriþ Tipi\n");

	SetPVarInt(playerid, "klanlar_sayfa", 10);
	for(new i; i < 500; i++) KlanlarListe[playerid][i] = -1;

	for(new i; i < 10; i++)
	{
		if(i < cache_num_rows())
		{
			cache_get_value_name_int(i, "id", KlanlarListe[playerid][i]);
			cache_get_value_name(i, "isim", isim, 50);
			cache_get_value_name(i, "tag", tag, 10);
			cache_get_value_name_int(i, "level", level);
			cache_get_value_name_int(i, "renk", renk);
			format(str, sizeof(str), "%s{%06x}[%s] %s\t{%06x}- {FFFFFF}%d {%06x}-\t{%06x} - {FFFFFF}%02d/%d {%06x}-\t{%06x} - {FFFFFF}Herkese Açýk {%06x}-\n", 
				str, KlanRenkleri[renk] >>> 8, tag, isim, KlanRenkleri[renk] >>> 8, level, KlanRenkleri[renk] >>> 8, KlanRenkleri[renk] >>> 8, KlanUyeSayisi(KlanlarListe[playerid][i]), level * 10, KlanRenkleri[renk] >>> 8, KlanRenkleri[renk] >>> 8, KlanRenkleri[renk] >>> 8);
			format(sql, sizeof(sql), "SELECT * FROM `klanlar` ORDER BY `level` DESC LIMIT 10");
			mysql_query(db, sql);
		}
		else
		{
			format(str, sizeof(str), "%s{A9A9A9}-----------------------------\t{A9A9A9}--------\t{A9A9A9}---------------\t{A9A9A9}-------------------------\n", str);
		}
	}

	mysql_query(db, "SELECT * FROM `klanlar`");
	new fstr[50];
	if(cache_num_rows() % 10 != 0)
	{
		format(fstr, sizeof(fstr), "%d.%d", cache_num_rows() / 10, cache_num_rows() % 10);
	}
	else
	{
		format(fstr, sizeof(fstr), "%d", cache_num_rows() / 10);
	}
	new toplamSyf = floatround(floatstr(fstr), floatround_ceil);
	format(baslik, sizeof(baslik), "Klanlar - (%d/%d)", GetPVarInt(playerid, "klanlar_sayfa") / 10, toplamSyf);
	if(cache_num_rows() > GetPVarInt(playerid, "klanlar_sayfa"))
	{
		strcat(str, "{A9A9A9}====================\t{A9A9A9}========\t{A9A9A9}===\t{A9A9A9}=================================\n");
		format(fstr, sizeof(fstr), "{A9A9A9}>> Sonraki Sayfa\t \t \t{A9A9A9}(%d/%d)\n", GetPVarInt(playerid, "klanlar_sayfa") / 10, toplamSyf);
		strcat(str, fstr);
		strcat(str, "{A9A9A9}====================\t{A9A9A9}========\t{A9A9A9}===\t{A9A9A9}=================================");
	}

	ShowPlayerDialog(playerid, DIALOG_KLANLAR, DIALOG_STYLE_TABLIST_HEADERS, baslik, str, "Baþvuru Yap", "Kapat");
	return true;
}

CMD:lottokatil(playerid, params[])
{
	if(lData[lAktif] != true) return Hata(playerid, "Aktif bir lotto yok!");
	new str[5000], durum[101][101], sayim[101];
	strcat(str, "#\t#\n");
	for(new i = 0; i <= 100; i++)
	{
		sayim[i] = 0;
	}
	for(new i = 0; i <= 100; i++)
	{
		foreach(new q: Player)
		{
			if(LottoSayisi[q] == i)
			{
				format(durum[i], 101, ""r"DOLU");
				sayim[i]++;
			}
		}
	}
	for(new i = 0; i <= 100; i++)
	{
		if(sayim[i] <= 0)
		{
			format(durum[i], 101, ""ad"BOÞ");
		}
	}
	for(new i = 0; i <= 100; i++)
	{
		format(str, sizeof(str), "%s"w"%d\t[%s"w"]\n", str, i, durum[i]);
	}
	ShowPlayerDialog(playerid, DIALOG_LOTTO, DIALOG_STYLE_TABLIST_HEADERS, "Lotto", str, "Satýn Al", "Iptal");
	return true;
}

CMD:setexp(playerid, params[])
{
	new id, miktar, str[512];
	if(pData[playerid][pAdmin] < 8) return YetersizSeviye(playerid, 8);
	if(sscanf(params, "ui", id, miktar)) return Kullanim(playerid, "setexp [id/isim] [miktar]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	if(miktar < 1) return Hata(playerid, "Geçersiz miktar girdiniz.");
	pData[id][pExp] = miktar;
	format(str, sizeof(str), ""w"Yetkili "wb"%s "w"EXP'inizi "wb"%d "w"yaptý.", getName(playerid), miktar);
	AdminBilgi(id, str);
	format(str, sizeof(str), ""w"Baþarýyla "wb"%s "w"adlý oyuncunun EXP'ini "wb"%d "w"yaptýnýz.", getName(id), miktar);
	AdminBilgi(playerid, str);
	OyuncuKaydet(id);
	return true;
}

CMD:giveexp(playerid, params[])
{
	new id, miktar, str[512];
	if(pData[playerid][pAdmin] < 8) return YetersizSeviye(playerid, 8);
	if(sscanf(params, "ui", id, miktar)) return Kullanim(playerid, "giveexp [id/isim] [miktar]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	if(miktar < 1) return Hata(playerid, "Geçersiz miktar girdiniz.");
	pData[id][pExp] += miktar;
	format(str, sizeof(str), ""w"Yetkili "wb"%s "w"size "wb"%d "w"EXP verdi.", getName(playerid), miktar);
	AdminBilgi(id, str);
	format(str, sizeof(str), ""w"Baþarýyla "wb"%s "w"adlý oyuncuya "wb"%d "w"EXP verdiniz.", getName(id), miktar);
	AdminBilgi(playerid, str);
	OyuncuKaydet(id);
	return true;
}

CMD:klan(playerid, params[])
{
	new dialog[1024];
	if(pData[playerid][pKlan] == -1)
	{
		format(dialog, sizeof(dialog), ""w"Henüz bir klana mensup deðilsin.\n"w"Kendi klanýný kurmak ister misin?");
		ShowPlayerDialog(playerid, DIALOG_KLAN, DIALOG_STYLE_MSGBOX, "Klan", dialog, ""ad"Evet", ""r"Hayýr");
	}
	else
	{
		KlanMenusu(playerid);
	}
	return true;
}

CMD:mkapat(playerid, params[])
{
	StopAudioStreamForPlayer(playerid);
	AdminBilgi(playerid, "Müzik baþarýyla kapatýldý.");
	return true;
}

CMD:evial(playerid, params[])
{
	if(pData[playerid][pEv] != -1) return Hata(playerid, "Zaten bir eviniz var!");
	foreach(new i: evler)
	{
		if(IsPlayerInRangeOfPoint(playerid, 1.0, EvInfo[i][evX], EvInfo[i][evY], EvInfo[i][evZ]))
		{
			if(GetPlayerMoney(playerid) < EvInfo[i][evFiyat]) return Hata(playerid, "Evi almak için yeterli paranýz yok!");
			if(EvInfo[i][evSahip] != -1) return Hata(playerid, "Bu evin bir sahibi var!");

			SetPVarInt(playerid, "alinacak_ev", i);
			new str[2048], str2[500], id = i;
			format(str2, sizeof(str2), ""wb"» "w"Ev Ýsmi: "wb"%s\n", EvInfo[id][evIsim]);
			strcat(str, str2);
			format(str2, sizeof(str2), ""wb"» "w"Ev Fiyatý: "wb"%s TL\n", FormatMoney(EvInfo[id][evFiyat]));
			strcat(str, str2);
			format(str2, sizeof(str2), ""wb"» "w"Ev Bölgesi: "wb"%s\n\n", GetZoneName(EvInfo[id][evX], EvInfo[id][evY], EvInfo[id][evZ]));
			strcat(str, str2);
			format(str2, sizeof(str2), ""wb"» "w"Eve ödeyeceðiniz fiyat: "wb"%s TL\n", FormatMoney(EvInfo[id][evFiyat]));
			strcat(str, str2);
			format(str2, sizeof(str2), ""wb"» "w"Evi gerçekten almak istiyor musunuz?");
			strcat(str, str2);
			return ShowPlayerDialog(playerid, DIALOG_EV_SATINAL, DIALOG_STYLE_MSGBOX, "Ev Satýn Al", str, ""ad"Evet", ""r"Hayýr");
		}
	}
	Hata(playerid, "Bir evin üzerinde deðilsiniz!");
	return true;
}

CMD:evyarat(playerid, params[])
{
	new fiyat, interior, isim[100], id = Iter_Free(evler), Float: x, Float: y, Float: z, kilitstr[75], sahipstr[100], str[512], sql[500];

	if(pData[playerid][pAdmin] < 10) return YetersizSeviye(playerid, 10);
	if(sscanf(params, "dis[100]", fiyat, interior, isim)) return Kullanim(playerid, "evyarat [fiyat] [interior] [isim]"), Kullanim(playerid, "interiorlar: 1-lüks ev, 2-orta ev, 3-fakir evi");
	
	if(id == -1) return Hata(playerid, "Ev sýnýrý dolmuþ! (500)");

	GetPlayerPos(playerid, x, y, z);
	EvInfo[id][evID] = id;
	format(EvInfo[id][evIsim], 100, "%s", isim);
	EvInfo[id][evFiyat] = fiyat;
	EvInfo[id][evSahip] = -1;
	EvInfo[id][evX] = x;
	EvInfo[id][evY] = y;
	EvInfo[id][evZ] = z;
	EvInfo[id][evKilit] = 0;
	EvInfo[id][evMapIcon] = CreateDynamicMapIcon(EvInfo[id][evX], EvInfo[id][evY], EvInfo[id][evZ], 31, 0);
	for(new i; i < 10; i++)
	{
		if(IsValidDynamicObject(EvInfo[id][evObjeler][i])) DestroyDynamicObject(EvInfo[id][evObjeler][i]);
		EvInfo[id][evObjeler][i] = -1;
		evObjelerID[id][i] = -1;
		for(new u; u < 6; u++)
		{
			evObjelerPos[id][i][u] = -1.0;
		}
	}

	if(interior == 1)
	{
		EvInfo[id][evInterior] = 12;
	}
	else if(interior == 2)
	{
		EvInfo[id][evInterior] = 3;
	}
	else if(interior == 3)
	{
		EvInfo[id][evInterior] = 11;
	}

	if(EvInfo[id][evInterior] == 12)
	{
		EvInfo[id][evCikisX] = 2324.53;
		EvInfo[id][evCikisY] = -1149.54;
		EvInfo[id][evCikisZ] = 1050.71;
	}
	else if(EvInfo[id][evInterior] == 3)
	{
		EvInfo[id][evCikisX] = 235.34;
		EvInfo[id][evCikisY] = 1186.68;
		EvInfo[id][evCikisZ] = 1080.26;
	}
	else if(EvInfo[id][evInterior] == 11)
	{
		EvInfo[id][evCikisX] = 2283.04;
		EvInfo[id][evCikisY] = -1140.28;
		EvInfo[id][evCikisZ] = 1050.90;
	}

	switch(EvInfo[id][evKilit])
	{
		case 0: kilitstr = "Açýk";
		case 1: kilitstr = "Kilitli";
	}

	switch(EvInfo[id][evSahip])
	{
		case -1: sahipstr = "Yok";
		default: format(sahipstr, sizeof(sahipstr), "%s", SQL_Isim_Cek(EvInfo[id][evSahip]));
	}

	format(str, sizeof(str), ""wb"%s\n"w"Ev Fiyatý: "wb"%s TL\n"w"Ev Sahibi: "wb"%s\n"w"Ev Durumu: "wb"%s\n\n{999999}(Ýçeri girmek için '"wb"F{999999}' tuþuna basýnýz.)",
		EvInfo[id][evIsim], FormatMoney(EvInfo[id][evFiyat]), sahipstr, kilitstr);
	EvInfo[id][evLabel] = CreateDynamic3DTextLabel(str, -1, EvInfo[id][evX], EvInfo[id][evY], EvInfo[id][evZ], 35.0);
	EvInfo[id][evPickup] = CreateDynamicPickup(1273, 1, EvInfo[id][evX], EvInfo[id][evY], EvInfo[id][evZ]);

	format(sql, sizeof(sql), "INSERT INTO `evler` (`id`, `isim`, `fiyat`, `sahip`, `x`, `y`, `z`, `kilit`, `interior`) VALUES ('%d', '%s', '%d', '-1', '%f', '%f', '%f', '%d', '%d')", 
		id, isim, fiyat, x, y, z, 0, EvInfo[id][evInterior]);
	mysql_query(db, sql);

	Iter_Add(evler, id);

	format(str, sizeof(str), ""w"Ev baþarýyla yaratýldý! | ID: "wb"%d, "w"Interior: "wb"%d, "w"Fiyat: "wb"%s TL", id, EvInfo[id][evInterior], FormatMoney(fiyat));
	AdminBilgi(playerid, str);
	return true;
}

CMD:jetpack(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1 && pData[playerid][pAnim] < 1 && !IsPlayerAdmin(playerid))
	{
		if(GetPlayerMoney(playerid) < 150) return Hata(playerid, "Jetpack alabilmek için "wb"150 TL "w"paranýz olmalýdýr!");

		SetPlayerSpecialAction(playerid, 2);
		GivePlayerMoney(playerid, -150);

		AdminBilgi(playerid, "Baþarýyla "wb"150 TL "w"karþýlýðýnda jetpack aldýnýz.");
	}
	else
	{
		SetPlayerSpecialAction(playerid, 2);

		AdminBilgi(playerid, "Jetpackýnýz verilmiþtir.");
	}
	return true;
}

CMD:isyerim(playerid, params[])
{
	if(pData[playerid][pIsYeri] == -1) return Hata(playerid, "Bir iþyeriniz yok!");
	new idx = pData[playerid][pIsYeri];
	if(!IsPlayerInRangeOfPoint(playerid, 30.0, iData[idx][iX], iData[idx][iY], iData[idx][iZ])) return Hata(playerid, "Bu komutu kullanabilmek için iþyerinizin yakýnýnda olmalýsýnýz!");

	new dialog[2048], str[1024], id = pData[playerid][pIsYeri], kilitDurum[25];

	format(str, sizeof(str), ""w"Ýþyeri Ýsmi: "wb"%s\n", iData[id][iIsim]);
	strcat(dialog, str);

	format(str, sizeof(str), ""w"Ýþyeri Fiyatý: "wb"%s TL\n", FormatMoney(iData[id][iFiyat]));
	strcat(dialog, str);

	format(str, sizeof(str), ""w"Ýþyeri Leveli: "wb"%d\n", iData[id][iLevel]);
	strcat(dialog, str);

	format(str, sizeof(str), ""w"Ýþyeri Bölgesi: "wb"%s\n", GetZoneName(iData[id][iX], iData[id][iY], iData[id][iZ]));
	strcat(dialog, str);

	format(str, sizeof(str), ""w"Ýþyeri Kasasý: "wb"%s TL\n", FormatMoney(iData[id][iKasa]));
	strcat(dialog, str);

	format(str, sizeof(str), " \n");
	strcat(dialog, str);

	format(str, sizeof(str), ""w"Ýþyeri Bitiþ Tarihi: "wb"%s\n", convertDate(iData[id][iBitisZaman]));
	strcat(dialog, str);

	format(str, sizeof(str), ""w"Ýþyeri Kalan Süresi: "wb"%s\n", ConvertTime(iData[id][iBitisZaman] - gettime()));
	strcat(dialog, str);

	format(str, sizeof(str), " \n");
	strcat(dialog, str);

	format(str, sizeof(str), ""w"Ýþyeri Ýsmini Deðiþtir\n");
	strcat(dialog, str);

	format(str, sizeof(str), ""w"Kasadaki Parayý Çek\n");
	strcat(dialog, str);

	format(str, sizeof(str), ""w"Ýþyeri Levelini Arttýr\n");
	strcat(dialog, str);

	switch(iData[id][iKilit])
	{
		case 1: kilitDurum = ""r"Kapalý";
		case 0: kilitDurum = ""ad"Açýk";
	}

	format(str, sizeof(str), ""w"Ýþyeri Durumu: %s\n", kilitDurum);
	strcat(dialog, str);

	format(str, sizeof(str), " \n");
	strcat(dialog, str);

	format(str, sizeof(str), ""w"Ýþyerini Sat");
	strcat(dialog, str);

	ShowPlayerDialog(playerid, DIALOG_ISYERIM, DIALOG_STYLE_LIST, ""w"Ýþyeri Menüsü", dialog, ""w"Seç", ""w"Kapat");
	return true;
}

CMD:nban(playerid, params[])
{
	if(pData[playerid][pAnim] < 5 && pData[playerid][pAdmin] < 5) return YetersizSeviye(playerid, 5);
	new id, sebep[150], string[512], gun, dialog[2048], str[850];
	if(sscanf(params, "uds[150]", id, gun, sebep)) return Kullanim(playerid, "nban [ID/Isim] [Gün] [Sebep]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	if(pData[id][pAdmin] > pData[playerid][pAdmin]) return Hata(playerid, "Oyuncu sizden yüksek level!");
	if(gun <= 0) return Hata(playerid, "Gün deðerini hatalý girdiniz.");
	if(gun > 365) return Hata(playerid, "En az 1, en fazla 365 gün ban atabilirsiniz.");

	strcat(dialog, ""w"Sunucumuzdan N-banlandýnýz.\n");
	strcat(dialog, ""w"Eðer hatalý bir iþlem olduðunu düþünüyorsanýz, "wb"www.gamerlity.com "w"adresine\n");
	strcat(dialog, ""w"baþvurabilirsiniz.\n\n");
	format(str, sizeof(str), ""w"N-Banlayan Admin: "wb"%s\n", getName(playerid));
	strcat(dialog, str);
	format(str, sizeof(str), ""w"N-Banlanma Tarihi: "wb"%s\n", convertDate(gettime()));
	strcat(dialog, str);
	format(str, sizeof(str), ""w"N-Banlanma Sebebi: "wb"%s\n", sebep);
	strcat(dialog, str);
	format(str, sizeof(str), ""w"N-Banlanan Nick: "wb"%s\n", getName(id));
	strcat(dialog, str);
	format(str, sizeof(str), ""w"N-Banlanan Gün: "wb"%d\n", gun);
	strcat(dialog, str);
	format(str, sizeof(str), ""w"N-Banýn Açýlmasýna Kalan: "wb"%s\n\n", ConvertTime(gettime() + (gun * 86400) - gettime()));
	strcat(dialog, str);
	strcat(dialog, ""ad"Birdahaki sefere daha dikkatli ve daha zevkli bir oyun oynamaný\ntemenni ederiz.");

	format(string, sizeof(string), "Yetkili "wb"%s "w"sizi sunucudan N-banladý!", getName(playerid));
	AdminBilgi(id, string);
	format(string, sizeof(string), "Baþarýyla "wb"%s "w"adlý oyuncuyu sunucudan N-banladýnýz.", getName(id));
	AdminBilgi(playerid, string);

	ShowPlayerDialog(id, 0, DIALOG_STYLE_MSGBOX, ""w"N-Banlandýnýz.", dialog, ""w"Kapat", "");

	format(str, sizeof(str), "~p~[N-BAN] ~w~~h~~h~%s ~p~>> ~w~~h~~h~%s ~p~(Gun: %d) (Sebep: %s)", getName(playerid), getName(id), gun, sebep);
	TextMesaji(code(str));

	if(pData[id][pAdmin] == 10) return true;
	new sql[500];
	format(sql, sizeof(sql), "INSERT INTO `nbanlog` (`banlayan`, `banlanan`, `sebep`, `tarih`, `gun`, `asilgun`) VALUES ('%s', '%s', '%s', '%s', '%d', '%d')", 
		getName(playerid), getName(id), sebep, convertDate(gettime()), gettime() + (gun * 86400), gun);
	mysql_query(db, sql);
	NormalKick(id);
	return true;
}

CMD:ban(playerid, params[])
{
	if(pData[playerid][pAnim] < 5 && pData[playerid][pAdmin] < 5) return YetersizSeviye(playerid, 5);
	new id, sebep[150], ip[50], string[512], dialog[2048], str[850];
	if(sscanf(params, "us[150]", id, sebep)) return Kullanim(playerid, "ban [ID/Isim] [Sebep]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	if(pData[id][pAdmin] > pData[playerid][pAdmin]) return Hata(playerid, "Oyuncu sizden yüksek level!");
	
	GetPlayerIp(id, ip, 50);

	strcat(dialog, ""w"Sunucumuzdan banlandýnýz.\n");
	strcat(dialog, ""w"Eðer hatalý bir iþlem olduðunu düþünüyorsanýz, "wb"www.gamerlity.com "w"adresine\n");
	strcat(dialog, ""w"baþvurabilirsiniz.\n\n");
	format(str, sizeof(str), ""w"Banlayan Admin: "wb"%s\n", getName(playerid));
	strcat(dialog, str);
	format(str, sizeof(str), ""w"Banlanma Tarihi: "wb"%s\n", convertDate(gettime()));
	strcat(dialog, str);
	format(str, sizeof(str), ""w"Banlanma Sebebi: "wb"%s\n", sebep);
	strcat(dialog, str);
	format(str, sizeof(str), ""w"Banlanan IP Adresi: "wb"%s\n\n", ip);
	strcat(dialog, str);
	strcat(dialog, ""ad"Birdahaki sefere daha dikkatli ve daha zevkli bir oyun oynamaný\ntemenni ederiz.");

	format(string, sizeof(string), "Yetkili "wb"%s "w"sizi sunucudan banladý!", getName(playerid));
	AdminBilgi(id, string);
	format(string, sizeof(string), "Baþarýyla "wb"%s "w"adlý oyuncuyu sunucudan banladýnýz.", getName(id));
	AdminBilgi(playerid, string);

	ShowPlayerDialog(id, 0, DIALOG_STYLE_MSGBOX, ""w"Banlandýnýz.", dialog, ""w"Kapat", "");

	format(str, sizeof(str), "~p~[BAN] ~w~~h~~h~%s ~p~>> ~w~~h~~h~%s ~p~(Sebep: %s)", getName(playerid), getName(id), sebep);
	TextMesaji(code(str));

	if(pData[id][pAdmin] == 10) return true;
	new sql[500];
	format(sql, sizeof(sql), "INSERT INTO `banlog` (`banlanan`, `banlayan`, `sebep`, `ip`, `tarih`) VALUES ('%s', '%s', '%s', '%s', '%s')", 
		getName(id), getName(playerid), sebep, ip, convertDate(gettime()));
	mysql_query(db, sql);
	format(string, sizeof(string), "banip %s", ip);
	SendRconCommand(string);
	SendRconCommand("reloadbans");
	NormalKick(id);
	return true;
}

CMD:kick(playerid, params[])
{
	if(pData[playerid][pAnim] < 3 && pData[playerid][pAdmin] < 3) return YetersizSeviye(playerid, 3);

	new id, sebep[250], string[512], dialog[2048], str[850];
	if(sscanf(params, "us[250]", id, sebep)) return Kullanim(playerid, "kick [ID/Isim] [Sebep]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	if(pData[id][pAdmin] > pData[playerid][pAdmin]) return Hata(playerid, "Oyuncu sizden yüksek level!");

	strcat(dialog, ""w"Sunucumuzdan kicklendiniz.\n");
	strcat(dialog, ""w"Eðer hatalý bir iþlem olduðunu düþünüyorsanýz, "wb"www.gamerlity.com "w"adresine\n");
	strcat(dialog, ""w"baþvurabilirsiniz.\n\n");
	format(str, sizeof(str), ""w"Kickleyen Admin: "wb"%s\n", getName(playerid));
	strcat(dialog, str);
	format(str, sizeof(str), ""w"Kicklenme Tarihi: "wb"%s\n", convertDate(gettime()));
	strcat(dialog, str);
	format(str, sizeof(str), ""w"Kicklenme Sebebi: "wb"%s\n\n", sebep);
	strcat(dialog, str);
	strcat(dialog, ""ad"Birdahaki sefere daha dikkatli ve daha zevkli bir oyun oynamaný\ntemenni ederiz.");

	format(string, sizeof(string), "Yetkili "wb"%s "w"sizi sunucudan kickledi!", getName(playerid));
	AdminBilgi(id, string);
	format(string, sizeof(string), "Baþarýyla "wb"%s "w"adlý oyuncuyu sunucudan kicklediniz.", getName(id));
	AdminBilgi(playerid, string);

	format(str, sizeof(str), "~p~[KICK] ~w~~h~~h~%s ~p~>> ~w~~h~~h~%s ~p~(Sebep: %s)", getName(playerid), getName(id), sebep);
	TextMesaji(code(str));

	ShowPlayerDialog(id, 0, DIALOG_STYLE_MSGBOX, ""w"Kicklendiniz.", dialog, ""w"Kapat", "");

	NormalKick(id);
	return true;
}

CMD:spawn(playerid, params[])
{
	if(pData[playerid][pAnim] < 2 && pData[playerid][pAdmin] < 2) return YetersizSeviye(playerid, 2);

	new id, str[512];
	if(sscanf(params, "u", id)) return Kullanim(playerid, "spawn [Isim/ID]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	if(pData[id][pAdmin] > pData[playerid][pAdmin]) return Hata(playerid, "Oyuncu sizden yüksek level!");

	SpawnPlayer(id);
	format(str, sizeof(str), "Yetkili "wb"%s "w"sizi spawn etti!", getName(playerid));
	AdminBilgi(id, str);
	format(str, sizeof(str), "Baþarýyla "wb"%s "w"isimli oyuncuyu spawn ettiniz!", getName(id));
	AdminBilgi(playerid, str);
	return true;
}

CMD:kill(playerid, params[])
{
	if(GetPlayerMoney(playerid) < 10) return Hata(playerid, "Ýntihar etmek için "wb"10 TL "w"paranýz olmalýdýr.");
	if(pData[playerid][pGod] == true) return Hata(playerid, "God açýkken intihar edemezsiniz!");
	if(pData[playerid][pSpawnKorumasinda] == true) return Hata(playerid, "Spawn korumasýndayken intihar edemezsiniz!");
	if(spawnda[playerid] == true) return Hata(playerid, "Spawn bölgesi içerisindeyken intihar edemezsiniz!");

	ApplyAnimationEx(playerid, "SWEET", "Sweet_injuredloop", 4.1, 0, 0, 1, 900000, 0);
	SetTimerEx("geber", 2000, false, "i", playerid);
	return true;
}

CMD:isyerisat(playerid, params[])
{
	if(pData[playerid][pIsYeri] == -1) return Hata(playerid, "Zaten bir iþyeriniz yok!");

	foreach(new i: isyerleri)
	{
		if(IsPlayerInRangeOfPoint(playerid, 1.0, iData[i][iX], iData[i][iY], iData[i][iZ]))
		{
			if(iData[i][iSahip] == pData[playerid][pSQLID])
			{
				new str[512];

				iData[i][iSahip] = -1;
				iData[i][iKilit] = 0;
				iData[i][iLevel] = 1;
				iData[i][iKasa] = 0;
				pData[playerid][pIsYeri] = -1;
				iData[i][iBitisZaman] = -1;

				IsYeriLabelGuncelle(i);
				OyuncuKaydet(playerid);

				IsYeriKaydet(i);

				GivePlayerMoney(playerid, iData[i][iFiyat] / 2);

				format(str, sizeof(str), "Ýþyerinizi baþarýyla sattýnýz. ("wb"+%s TL"w")", FormatMoney((iData[i][iFiyat] / 2)));
				return AdminBilgi(playerid, str);
			}
			else
			{
				return Hata(playerid, "Ýþyerinin sahibi siz deðilsiniz!");
			}
		}
	}

	Hata(playerid, "Bir iþyerinin üstünde deðilsiniz!");
	return true;
}

CMD:isyerial(playerid, params[])
{
	if(pData[playerid][pIsYeri] != -1) return Hata(playerid, "Zaten bir iþyeriniz var!");

	foreach(new i: isyerleri)
	{
		if(IsPlayerInRangeOfPoint(playerid, 1.0, iData[i][iX], iData[i][iY], iData[i][iZ]))
		{
			if(GetPlayerMoney(playerid) < iData[i][iFiyat]) return Hata(playerid, "Bu iþyerini alabilmek için yeterli paranýz yok!");
			if(iData[i][iSahip] != -1) return Hata(playerid, "Bu iþyerinin bir sahibi var!");

			SetPVarInt(playerid, "alinacak_isyeri", i);
			new str[2048], str2[500], id = i;
			format(str2, sizeof(str2), ""wb"» "w"Ýþyeri Ýsmi: "wb"%s\n", iData[id][iIsim]);
			strcat(str, str2);
			format(str2, sizeof(str2), ""wb"» "w"Ýþyeri Fiyatý: "wb"%s TL\n", FormatMoney(iData[id][iFiyat]));
			strcat(str, str2);
			format(str2, sizeof(str2), ""wb"» "w"Ýþyeri Leveli: "wb"%d\n", iData[id][iLevel]);
			strcat(str, str2);
			format(str2, sizeof(str2), ""wb"» "w"Ýþyeri Bölgesi: "wb"%s\n", GetZoneName(iData[id][iX], iData[id][iY], iData[id][iZ]));
			strcat(str, str2);
			format(str2, sizeof(str2), ""wb"» "w"Ýþyeri Kasasý: "wb"%s TL\n\n", FormatMoney(iData[id][iKasa]));
			strcat(str, str2);
			format(str2, sizeof(str2), ""wb"» "w"Ýþyerinin Sizin Olacaðý Süre: "wb"7 GÜN\n\n");
			strcat(str, str2);
			format(str2, sizeof(str2), ""wb"» "w"Ýþyerine ödeyeceðiniz fiyat: "wb"%s TL\n", FormatMoney(iData[id][iFiyat]));
			strcat(str, str2);
			format(str2, sizeof(str2), ""wb"» "w"Ýþyerini gerçekten almak istiyor musunuz?");
			strcat(str, str2);
			return ShowPlayerDialog(playerid, DIALOG_ISYERI_SATINAL, DIALOG_STYLE_MSGBOX, "Ýþyeri Satýn Al", str, ""ad"Evet", ""r"Hayýr");
		}
	}

	Hata(playerid, "Bir iþyerinin üstünde deðilsiniz!");
	return true;
}

CMD:isyerisil(playerid, params[])
{
	if(pData[playerid][pAdmin] < 10) return YetersizSeviye(playerid, 10);

	new id = -2, sql[500];

	foreach(new i: isyerleri)
	{
		if(IsPlayerInRangeOfPoint(playerid, 1.0, iData[i][iX], iData[i][iY], iData[i][iZ]))
		{
			id = i;
			break;
		}
	}

	if(id == -2) return Hata(playerid, "Bir iþ yerinin yanýnda deðilsiniz!");

	format(sql, sizeof(sql), "DELETE FROM `is_yerleri` WHERE `id` = '%d'", id);
	mysql_query(db, sql);

	iData[id][iID] = -1;
	format(iData[id][iIsim], 128, " ");
	iData[id][iSahip] = -1;
	iData[id][iFiyat] = -1;
	iData[id][iX] = -1;
	iData[id][iY] = -1;
	iData[id][iZ] = -1;
	iData[id][iKilit] = 0;
	iData[id][iInterior] = -1;
	iData[id][iBitisZaman] = -1;
	if(IsValidDynamicPickup(iData[id][iPickup]))
		DestroyDynamicPickup(iData[id][iPickup]);
	if(IsValidDynamic3DTextLabel(iData[id][iLabel]))
		DestroyDynamic3DTextLabel(iData[id][iLabel]);
	DestroyDynamicMapIcon(iData[id][iMapIcon]);

	Iter_Remove(isyerleri, id);

	format(sql, sizeof(sql), ""wb"%d "w"ID'li iþyeri baþarýyla silindi!", id);
	Bilgi(playerid, sql);
	return true;
}

CMD:isyeriekle(playerid, params[])
{
	if(pData[playerid][pAdmin] < 10) return YetersizSeviye(playerid, 10);

	new isim[25], interior, fiyat, id = Iter_Free(isyerleri), sql[500], Float: x, Float: y, Float: z, KilitDurum[76], str[512], sahipstr[72];

	if(sscanf(params, "iis[25]", fiyat, interior, isim)) return Kullanim(playerid, "isyeriekle [Ýþyeri Fiyatý] [Ýþyeri Ýnterioru] [Ýþyeri Ýsmi]"), SCM(playerid, -1, "1 - market(1), 2 - market(2), 3 - silahçý(1),  4 - silahçý(2), 5 - pizzacý, 6 - tavukçu, 7 - burgerci");

	if(id == -1) return Hata(playerid, "Ýþyeri sýnýrý dolmuþ! (500)");

	GetPlayerPos(playerid, x, y, z);
	format(sql, sizeof(sql), "INSERT INTO `is_yerleri` (`id`, `isim`, `sahip`, `fiyat`, `kilit`, `x`, `y`, `z`, `interior`, `level`) VALUES \
		('%d', '%s', '-1', '%d', '0', '%f', '%f', '%f', '%d', '1')", id, isim, fiyat, x, y, z, interior);
	mysql_query(db, sql);

	iData[id][iID] = id;
	format(iData[id][iIsim], 128, "%s", isim);
	iData[id][iSahip] = -1;
	iData[id][iFiyat] = fiyat;
	iData[id][iX] = x;
	iData[id][iY] = y;
	iData[id][iZ] = z;
	iData[id][iKilit] = 0;
	iData[id][iInterior] = interior;
	iData[id][iPickup] = CreateDynamicPickup(1272, 1, iData[id][iX], iData[id][iY], iData[id][iZ]);
	iData[id][iLevel] = 1;
	iData[id][iMapIcon] = CreateDynamicMapIcon(iData[id][iX], iData[id][iY], iData[id][iZ], 51, 0);
	iData[id][iBitisZaman] = -1;

	switch(iData[id][iSahip])
	{
		case -1: format(sahipstr, sizeof(sahipstr), ""wb"Yok");
		default: format(sahipstr, sizeof(sahipstr), ""wb"%s", SQL_Isim_Cek(iData[id][iSahip]));
	}

	if(iData[id][iInterior] == 1)
	{
		iData[id][iCikisX] = -25.884498;
		iData[id][iCikisY] = -185.868988;
		iData[id][iCikisZ] = 1003.546875;
	}
	else if(iData[id][iInterior] == 2)
	{
		iData[id][iCikisX] = 6.091179;
		iData[id][iCikisY] = -29.271898;
		iData[id][iCikisZ] = 1003.549438;
	}
	else if(iData[id][iInterior] == 3)
	{
		iData[id][iCikisX] = 286.148986;
		iData[id][iCikisY] = -40.644397;
		iData[id][iCikisZ] = 1001.515625;
	}
	else if(iData[id][iInterior] == 4)
	{
		iData[id][iCikisX] = 286.800994;
		iData[id][iCikisY] = -82.547599;
		iData[id][iCikisZ] = 1001.515625;
	}
	else if(iData[id][iInterior] == 5)
	{
		iData[id][iCikisX] = 373.825653;
		iData[id][iCikisY] = -117.270904;
		iData[id][iCikisZ] = 1001.499511;
	}
	else if(iData[id][iInterior] == 6)
	{
		iData[id][iCikisX] = 369.579528;
		iData[id][iCikisY] = -4.487294;
		iData[id][iCikisZ] = 1001.858886;
	}
	else if(iData[id][iInterior] == 7)
	{
		iData[id][iCikisX] = 375.962463;
		iData[id][iCikisY] = -65.816848;
		iData[id][iCikisZ] = 1001.507812;
	}
	switch(iData[id][iKilit])
	{
		case 0:
		{
			KilitDurum = ""ad"Açýk";
		}
		case 1:
		{
			KilitDurum = ""r"Kapalý";
		}
	}
	format(str, sizeof(str), "\
			"wb"%s\n\
			"w"Ýþyeri Fiyatý: "wb"%s TL\n\
			"w"Ýþyeri Durumu: "wb"%s\n\
			"w"Ýþyeri Leveli: "wb"%d\n\
			"w"Ýþyeri Sahibi: %s\n\n\
			{999999}(Ýçeri girmek için '"wb"F{999999}' tuþuna basýnýz.)", iData[id][iIsim], FormatMoney(iData[id][iFiyat]), KilitDurum, iData[id][iLevel], sahipstr);
	iData[id][iLabel] = CreateDynamic3DTextLabel(str, -1, iData[id][iX], iData[id][iY], iData[id][iZ], 35.0);

	Iter_Add(isyerleri, id);

	format(str, sizeof(str), "Ýþyeri oluþturuldu! | ID: "wb"%d "w"- Ýsim: "wb"%s", id, isim);
	Bilgi(playerid, str);
	return true;
}

CMD:aracekle(playerid, params[])
{
	if(pData[playerid][pAdmin] < 10) return YetersizSeviye(playerid, 10);

	new aracid[50], aracc, id = Iter_Free(araclar), sql[500], rq1, rq2, Float: x, Float: y, Float: z, Float: f, str[512];

	if(sscanf(params, "s[50]", aracid)) return Kullanim(playerid, "aracekle [Araç Isim/Model]");

	if(!IsNumeric(aracid))
	{
		aracc = GetVehicleIDFromName(aracid);
	}
	else
	{
		aracc = strval(aracid);
	}

	if(aracc < 400 || aracc > 611) return Hata(playerid, "Böyle bir araç yok!");

	rq1 = random(255);
	rq2 = random(255);
	format(aData[id][aPlaka], 50, "%s", PlakaYarat(id));
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, f);
	format(sql, sizeof(sql), "INSERT INTO `araclar` (`id`, `sahip`, `model`, `x`, `y`, `z`, `f`, `renk1`, `renk2`, `plaka`) VALUES ('%d', '-1', '%d', '%f', '%f', '%f', '%f', '%d', '%d', '%s')", id, aracc, x, y, z, f, rq1, rq2, aData[id][aPlaka]);
	mysql_query(db, sql);

	aData[id][aSahip] = -1;
	aData[id][aModel] = aracc;
	aData[id][aMod1] = 0;
	aData[id][aMod2] = 0;
	aData[id][aMod3] = 0;
	aData[id][aMod4] = 0;
	aData[id][aMod5] = 0;
	aData[id][aMod6] = 0;
	aData[id][aMod7] = 0;
	aData[id][aMod8] = 0;
	aData[id][aMod9] = 0;
	aData[id][aMod10] = 0;
	aData[id][aMod11] = 0;
	aData[id][aMod12] = 0;
	aData[id][aMod13] = 0;
	aData[id][aMod14] = 0;
	aData[id][aMod15] = 0;
	aData[id][aMod16] = 0;
	aData[id][aMod17] = 0;
	aData[id][aPaintJob] = -1;
	aData[id][aRenk1] = rq1;
	aData[id][aRenk1] = rq2;
	aData[id][aX] = x;
	aData[id][aY] = y;
	aData[id][aZ] = z;
	aData[id][aF] = f;
	aData[id][aBenzin] = 100;
	aData[id][aKilit] = true;

	aData[id][aID] = CreateVehicle(aData[id][aModel], aData[id][aX], aData[id][aY], aData[id][aZ], aData[id][aF], aData[id][aRenk1], aData[id][aRenk2], -1);
	SetVehicleNumberPlate(aData[id][aID], aData[id][aPlaka]);
	SetVehicleToRespawn(aData[id][aID]);

	Iter_Add(araclar, id);

	format(str, sizeof(str), "Araç baþarýyla oluþturuldu! | ID: "wb"%d "w"- Model: "wb"%s", id, GetVehicleName(aData[id][aID]));
	AdminBilgi(playerid, str);

	new Float: xx, Float: yy, Float: zz;
	GetPlayerPos(playerid, xx, yy, zz);
	SetPlayerPos(playerid, xx + 3, yy, zz);
	return true;
}

CMD:bugrapor(playerid, params[])
{
	new string[2048], sql[2048 + 500];
	if(sscanf(params, "s[2048]", string)) return Kullanim(playerid, "bugrapor [Bildirim]");

	format(sql, sizeof(sql), "INSERT INTO `bugrapor_log` (`gonderen`, `tarih`, `mesaj`) VALUES ('%s', '%s', '%s')", getName(playerid), convertDate(gettime()), string);
	mysql_query(db, sql);

	Bilgi(playerid, "Bug raporunuz baþarýlý bir þekilde iletilmiþtir. Teþekkürler!");
	return true;
}

CMD:anims(playerid, params[])
{
	new string[1024], durum[50], sayim = 0;
	strcat(string, ""wb"#\t"w"Ýsim\t"w"Durum\t"w"Level\n");
	foreach(new i: Player)
	{
		if(pData[i][pAnim] > 0)
		{
			switch(pData[i][pAFK])
			{
				case true:
				{
					format(durum, sizeof(durum), ""wb"AFK");
				}
				case false:
				{
					format(durum, sizeof(durum), "{00F600}Müsait");
				}
				default:
				{
					format(durum, sizeof(durum), "{00F600}Müsait");
				}
			}
			format(string, sizeof(string), "\
				%s"wb"»\t"w"%s(%d)\t"w"%s\t"w"%d\n", string, getName(i), i, durum, pData[i][pAnim]);
			sayim++;
		}
	}
	if(sayim == 0) return Hata(playerid, "Çevrimiçi animatör yok!");
	else
	{
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, ""w"Çevrimiçi Animatörler", string, ""w"Kapat", "");
	}
	return true;
}

CMD:admins(playerid, params[])
{
	new string[1024], durum[50], sayim = 0;
	strcat(string, ""wb"#\t"w"Ýsim\t"w"Durum\t"w"Level\n");
	foreach(new i: Player)
	{
		if(pData[i][pAdmin] > 0)
		{
			switch(pData[i][pAFK])
			{
				case true:
				{
					format(durum, sizeof(durum), ""wb"AFK");
				}
				case false:
				{
					format(durum, sizeof(durum), "{00F600}Müsait");
				}
				default:
				{
					format(durum, sizeof(durum), "{00F600}Müsait");
				}
			}
			format(string, sizeof(string), "\
				%s"wb"»\t"w"%s(%d)\t"w"%s\t"w"%d\n", string, getName(i), i, durum, pData[i][pAdmin]);
			sayim++;
		}
	}
	if(sayim == 0) return Hata(playerid, "Çevrimiçi admin yok!");
	else
	{
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, ""w"Çevrimiçi Adminler", string, ""w"Kapat", "");
	}
	return true;
}

CMD:get(playerid, params[])
{
	new id, Float: x, Float: y, Float: z, string[512];
	if(pData[playerid][pAnim] < 2 && pData[playerid][pAdmin] < 2) return YetersizSeviye(playerid, 2);
	if(sscanf(params, "u", id)) return Kullanim(playerid, "get [ID/Isim]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	if(id == playerid) return Hata(playerid, "Kendinizi çekemezsiniz!");
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPV(id, x, y + 3, z);
	format(string, sizeof(string), "Yetkili "wb"%s "w"sizi yanýna çekti.", getName(playerid));
	AdminBilgi(id, string);
	format(string, sizeof(string), ""wb"%s "w"isimli oyuncuyu yanýnýza çektiniz.", getName(id));
	AdminBilgi(playerid, string);
	return true;
}

CMD:goto(playerid, params[])
{
	new id, Float: x, Float: y, Float: z, string[512];
	if(pData[playerid][pAnim] < 1 && pData[playerid][pAdmin] < 1) return YetersizSeviye(playerid, 1);
	if(sscanf(params, "u", id)) return Kullanim(playerid, "goto [ID/Isim]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	if(id == playerid) return Hata(playerid, "Kendinize ýþýnlanamazsýnýz!");
	GetPlayerPos(id, x, y, z);
	SetPlayerPV(playerid, x, y + 3, z);
	format(string, sizeof(string), "Yetkili "wb"%s "w"sizin yanýnýza ýþýnlandý.", getName(playerid));
	AdminBilgi(id, string);
	format(string, sizeof(string), ""wb"%s "w"isimli oyuncunun yanýna ýþýnlandýnýz.", getName(id));
	AdminBilgi(playerid, string);
	return true;
}

CMD:skinler(playerid, params[])
{
	ShowModelSelectionMenu(playerid, skin_listesi, "Skin Listesi");
	return true;
}

CMD:givemoney(playerid, params[])
{
	new id, miktar;
	if(pData[playerid][pAdmin] < 8) return YetersizSeviye(playerid, 8);
	if(sscanf(params, "ui", id, miktar)) return Kullanim(playerid, "givemoney [ID/Isim] [Miktar]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	GivePlayerMoney(id, miktar);

	new string[512];
	
	format(string, sizeof(string), "Yetkili "wb"%s "w"size "wb"%s TL "w"verdi!", getName(playerid), FormatMoney(miktar));
	AdminBilgi(id, string);

	format(string, sizeof(string), ""wb"%s "w"adlý oyuncuya "wb"%s TL "w"verdiniz!", getName(id), FormatMoney(miktar));
	AdminBilgi(playerid, string);
	return true;
}

CMD:setmoney(playerid, params[])
{
	new id, miktar;
	if(pData[playerid][pAdmin] < 8) return YetersizSeviye(playerid, 8);
	if(sscanf(params, "ui", id, miktar)) return Kullanim(playerid, "setmoney [ID/Isim] [Miktar]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	ResetPlayerMoney(id);
	GivePlayerMoney(id, miktar);

	new string[512];

	format(string, sizeof(string), "Yetkili "wb"%s "w"paranýzý "wb"%s "w"yaptý!", getName(playerid), FormatMoney(miktar));
	AdminBilgi(id, string);

	format(string, sizeof(string), ""wb"%s "w"adlý oyuncunun parasýný "wb"%s "w"yaptýnýz.", getName(id), FormatMoney(miktar));
	AdminBilgi(playerid, string);
	return true;
}

CMD:setscore(playerid, params[])
{
	new id, miktar;
	if(pData[playerid][pAdmin] < 9) return YetersizSeviye(playerid, 9);
	if(sscanf(params, "ui", id, miktar)) return Kullanim(playerid, "setscore [ID/Isim] [Miktar]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	SetPlayerScore(id, miktar);

	new string[512];

	format(string, sizeof(string), "Yetkili "wb"%s "w"skorunuzu "wb"%d "w"yaptý!", getName(playerid), miktar);
	AdminBilgi(id, string);

	format(string, sizeof(string), ""wb"%s "w"adlý oyuncunun skorunu "wb"%d "w"yaptýnýz.", getName(id), miktar);
	AdminBilgi(playerid, string);
	return true;
}

CMD:givescore(playerid, params[])
{
	new id, miktar;
	if(pData[playerid][pAdmin] < 9) return YetersizSeviye(playerid, 9);
	if(sscanf(params, "ui", id, miktar)) return Kullanim(playerid, "givescore [ID/Isim] [Miktar]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	SetPlayerScore(id, GetPlayerScore(id) + miktar);

	new string[512];

	format(string, sizeof(string), "Yetkili "wb"%s "w"size "wb"%d "w"skor verdi!", getName(playerid), miktar);
	AdminBilgi(id, string);

	format(string, sizeof(string), ""wb"%s "w"adlý oyuncuya "wb"%d "w"skor verdiniz!", getName(id), miktar);
	AdminBilgi(playerid, string);
	return true;
}

CMD:setadmin(playerid, params[])
{
	new id, seviye, str[512];
	if(pData[playerid][pAdmin] < 10 && !IsPlayerAdmin(playerid)) return YetersizSeviye(playerid, 10);
	if(sscanf(params, "ui", id, seviye)) return Kullanim(playerid, "setadmin [ID/Isim] [Seviye]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	if(seviye < 0 || seviye > 10) return Hata(playerid, "Seviye en az 0, en fazla 10 olabilir!");
	if(pData[id][pAdmin] == seviye) return Hata(playerid, "Oyuncu zaten o seviyede!");

	pData[id][pAnim] = 0;
	pData[id][pAdmin] = seviye;

	format(str, sizeof(str), ""wb"%s "w"adlý yönetici sizi "wb"%d "w"seviye admin yaptý.", getName(playerid), seviye);
	AdminBilgi(id, str);

	format(str, sizeof(str), ""wb"%s "w"adlý oyuncuyu "wb"%d "w"seviye admin yaptýnýz.", getName(id), seviye);
	AdminBilgi(playerid, str);

	OyuncuKaydet(id);
	return true;
}

CMD:setanim(playerid, params[])
{
	new id, seviye, str[512];
	if(pData[playerid][pAdmin] < 10 && !IsPlayerAdmin(playerid)) return YetersizSeviye(playerid, 10);
	if(sscanf(params, "ui", id, seviye)) return Kullanim(playerid, "setanim [ID/Isim] [Seviye]");
	if(!IsPlayerConnected(id)) return Hata(playerid, "Oyuncu oyunda deðil!");
	if(seviye < 0 || seviye > 5) return Hata(playerid, "Seviye en az 0, en fazla 5 olabilir!");
	if(pData[id][pAnim] == seviye) return Hata(playerid, "Oyuncu zaten o seviyede!");

	pData[id][pAnim] = seviye;
	pData[id][pAdmin] = 0;

	format(str, sizeof(str), ""wb"%s "w"adlý yönetici sizi "wb"%d "w"seviye animatör yaptý.", getName(playerid), seviye);
	AdminBilgi(id, str);

	format(str, sizeof(str), ""wb"%s "w"adlý oyuncuyu "wb"%d "w"seviye animatör yaptýnýz.", getName(id), seviye);
	AdminBilgi(playerid, str);

	OyuncuKaydet(id);
	return true;
}

CMD:local(playerid, params[])
{
	new yazi[250], str[512], Float: x, Float: y, Float: z;
	if(sscanf(params, "s[250]", yazi)) return Kullanim(playerid, "l(ocal) [Yazý]");
	GetPlayerPos(playerid, x, y, z);
	foreach(new i: Player)
	{
		if(IsPlayerInRangeOfPoint(i, 30.0, x, y, z))
		{
			format(str, sizeof(str), "{00FFC8}LOCAL - %s(%d): %s", getName(playerid), playerid, yazi);
			SCM(i, -1, str);
		}
	}
	return true;
}
alias:local("l");

CMD:a(playerid, params[])
{
	if(pData[playerid][pArac] == -1) return Hata(playerid, "Bir aracýnýz yok!");

	new string[2048], str2[512];

	new za_ = 100 / 30, Bar[128];
	new donusturulenHiz = aData[pData[playerid][pArac]][aBenzin] / za_;
	Bar[0] = '[';
	for(new x = 0; x < 30; x++)
	{
		if(x < donusturulenHiz)
		{
			Bar[x + 1] = 'I';
		}
		else
		{
			Bar[x + 1] = ' ';
		}
		if(x == 29) Bar[x + 1] = ']';
	}

	new za_2 = 1000 / 30, Bar2[128], Float: VHealth;
	GetVehicleHealth(aData[pData[playerid][pArac]][aID], VHealth);
	new donusturulenHiz2 = floatround(VHealth) / za_2;
	Bar2[0] = '[';
	for(new x = 0; x < 30; x++)
	{
		if(x < donusturulenHiz2)
		{
			Bar2[x + 1] = 'I';
		}
		else
		{
			Bar2[x + 1] = ' ';
		}
		if(x == 29) Bar2[x + 1] = ']';
	}

	strcat(string, ""wb"#\t"w"Ýþlem\t"w"Deðer\n");
	strcat(string, ""wb"»\t"w"Aracýmý getir\n");
	strcat(string, ""wb"»\t"w"Benzin al\n");
	strcat(string, ""wb"»\t"w"Kapýlarý kilitle\n");
	strcat(string, ""wb"»\t"w"Aracýmý sat\n");
	strcat(string, ""wb"»\t"w"Aracýmý buraya park et\n");
	strcat(string, ""wb"»\t"w"Aracýmýn Anahtarlarý\n");
	strcat(string, " \n");
	format(str2, sizeof(str2), ""wb"»\t"w"Benzin Göstergesi:\t"ad"%s\n", Bar);
	strcat(string, str2);
	format(str2, sizeof(str2), ""wb"»\t"w"Hasar Göstergesi:\t"ad"%s\n", Bar2);
	strcat(string, str2);
	format(str2, sizeof(str2), ""wb"»\t"w"Plaka:\t"ad"%s\n", aData[pData[playerid][pArac]][aPlaka]);
	strcat(string, str2);
	format(str2, sizeof(str2), ""wb"»\t"w"Model:\t"ad"%s\n", GetVehicleName(aData[pData[playerid][pArac]][aID]));
	strcat(string, str2);
	format(str2, sizeof(str2), ""wb"»\t"w"Sahip:\t"ad"%s", SQL_Isim_Cek(aData[pData[playerid][pArac]][aSahip]));
	strcat(string, str2);

	ShowPlayerDialog(playerid, DIALOG_ARACIM, DIALOG_STYLE_TABLIST_HEADERS, ""w"Araç Menüsü", string, ""w"Seç", ""w"Kapat");
	return true;
}

CMD:aracal(playerid, params[])
{
	if(pData[playerid][pArac] != -1) return Hata(playerid, "Zaten bir aracýnýz var!");
	
	if(IsPlayerInAnyVehicle(playerid))
	{
		foreach(new i: araclar)
		{
			if(GetPlayerVehicleID(playerid) == aData[i][aID] && aData[i][aSahip] == -1)
			{
				new str[512];
				format(str, sizeof(str), "\
					"w"Bu aracý almak istiyor musunuz?\n\n\
					"w"Fiyat: "wb"%s TL\n\
					"w"Plaka: "wb"%s\n\
					"w"Model: "wb"%s", FormatMoney(14000), aData[i][aPlaka], GetVehicleName(GetPlayerVehicleID(playerid)));
				ShowPlayerDialog(playerid, DIALOG_ARACIM_AL, DIALOG_STYLE_MSGBOX, ""w"Araç Alým", str, ""ad"Evet", ""r"Hayýr");
				break;
			}
			else if(GetPlayerVehicleID(playerid) == aData[i][aID] && aData[i][aSahip] != -1)
			{
				Hata(playerid, "Bu aracýn zaten bir sahibi var!");
				break;
			}
		}
	}
	else
	{
		Hata(playerid, "Bir araçta deðilsiniz!");
	}
	return true;
}

CMD:can(playerid, params[])
{
	if(GetPlayerMoney(playerid) < 25) return Hata(playerid, "Can alabilmek için "wb"25 TL "w"paranýz olmalýdýr.");
	if(GetPlayerHealth(playerid) == 100.0) return Hata(playerid, "Canýnýz zaten dolu!");
	if(spamProtect(playerid, "can", 25)) return true;

	SetPlayerHealth(playerid, 100.0);
	GivePlayerMoney(playerid, -25);

	AdminBilgi(playerid, "Canýnýzý "wb"25 TL "w"karþýlýðýnda doldurdunuz.");
	return true;
}

CMD:zirh(playerid, params[])
{
	if(GetPlayerMoney(playerid) < 25) return Hata(playerid, "Zýrh alabilmek için "wb"25 TL "w"paranýz olmalýdýr.");
	if(GetPlayerArmour(playerid) == 100.0) return Hata(playerid, "Zýrhýnýz zaten dolu!");
	if(spamProtect(playerid, "zirh", 25)) return true;

	SetPlayerArmour(playerid, 100.0);
	GivePlayerMoney(playerid, -25);

	AdminBilgi(playerid, "Zýrhýnýzý "wb"25 TL "w"karþýlýðýnda doldurdunuz.");
	return true;
}

CMD:cc(playerid, params[])
{
	if(pData[playerid][pAnim] < 1 && pData[playerid][pAdmin] < 1) return YetersizSeviye(playerid, 1);
	foreach(new i: Player)
	{
		CC(i);
	}
	new string[512];
	format(string, sizeof(string), "Yetkili "wb"%s "w"sohbet ekranýný temizledi.", getName(playerid));
	foreach(new i: Player)
	{
		AdminBilgi(i, string);
	}
	return true;
}

CMD:mod3(playerid, params[])
{
	SetPlayerPV(playerid, -2705.5503, 206.1621, 4.1797);
    GameTextForPlayer(playerid, "~r~~h~TELEPORT:~n~~w~~h~MODIFIYE 3", 3000, 5);
	return true;
}

CMD:gotopos(playerid, params[])
{
	new Float: x, Float: y, Float: z;
	if(pData[playerid][pAdmin] < 3) return YetersizSeviye(playerid, 3);
	if(sscanf(params, "p<,>fff", x, y, z)) return Kullanim(playerid, "gotopos [x], [y], [z]");
	SetPlayerPV(playerid, x, y, z);
	AdminBilgi(playerid, "Baþarýyla istediðiniz posa ýþýnlandýnýz.");
	return true;
}

CMD:credits(playerid, params[])
{
	new string[2500], adminler[1000], isim[24], level;
	format(string, sizeof(string), "\
		{ffa500}» Sahip:\n\
		\t{f82d2d}» {f8fafb}flareoNNN & Alper.\n\n\
		{ffa500}» Kodlama:\n\
		\t{f82d2d}» {f8fafb}flareoNNN\n\n\
		{ffa500}» Web:\n\
		\t{f82d2d}» {f8fafb}Alper.\n\n\
		{ffa500}» Testing:\n\
		\t{f82d2d}» {f8fafb}flareoNNN & Alper.\n\n\
		{ffa500}» Harita:\n\
		\t{f82d2d}» {f8fafb}Lordax\n\n");
	mysql_query(db, "SELECT * FROM `hesaplar` WHERE `admin` > '0' ORDER BY `admin` DESC");
	for(new i; i < cache_num_rows(); i++)
	{
		cache_get_value_name(i, "kullaniciadi", isim);
		cache_get_value_name_int(i, "admin", level);
		format(adminler, sizeof(adminler), "%s\t{f82d2d}» {f8fafb}%s - Level: %d\n", adminler, isim, level);
	}
	strcat(string, "{ffa500}» Adminler:\n");
	strcat(string, adminler);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{f8fafb}Yapýmcýlar", string, "{f8fafb}Kapat", "");
	return true;
}

CMD:giveweapon(playerid, params[])
{
	new id, miktar, silah_id[25], silah, str[1024], silahisim[50];

	if(pData[playerid][pAnim] < 3 && pData[playerid][pAdmin] < 3) return YetersizSeviye(playerid, 3);
	if(sscanf(params, "us[25]i", id, silah_id, miktar)) return Kullanim(playerid, "giveweapon [ID/Isim] [Silah ID/Isim] [Mermi]");

	if(!IsNumeric(silah_id))
	{
		silah = GetWeaponIDFromName(silah_id);
	}
	else
	{
		silah = strval(silah_id);
	}
	if(!IsValidWeapon(silah)) return Hata(playerid, "Böyle bir silah yok!");

	GivePlayerWeapon(id, silah, miktar);

	GetWeaponName(silah, silahisim, 50);
	format(str, sizeof(str), "Yetkili "wb"%s "w"size "wb"%s "w"silahýný "wb"%d "w"mermi ile verdi!", getName(playerid), silahisim, miktar);
	AdminBilgi(id, str);

	format(str, sizeof(str), ""wb"%s "w"isimli oyuncuya "wb"%s "w"silahýný "wb"%d "w"mermi ile verdiniz!", getName(id), silahisim, miktar);
	AdminBilgi(playerid, str);
	return true;
}

//=-=-==-=-==-=-==-=-==-=-==-=-= CALLBACK'LER =-=-==-=-==-=-==-=-==-=-==-=-=

CB: FlyKontrol(playerid)
{
	if(AnimCek(playerid))
	{
		new Float: x, Float: y, Float: z;
		GetPlayerPos(playerid, x, y, z);
		if(z > 1.0)
		{
			if(!PosCek(playerid))
			{
				SistemKick(playerid, "Fly Hack");
			}
		}
	}
	return true;
}

CB: YT_Arama(playerid, response_code, data[])
{
	new JSONNode: response = json_parse_string(data), JSONArray: results, string[10000];

	if(response_code != 200)
	{
		Hata(playerid, "Arama yaparken hata oluþtu!");
		YT_Islem = false;
		return true;
	}

	results = json_get_array(response, "results");

	strcat(string, ""w"Sýra\t"w"Video Ismi\t"w"Kanal\n");

	new baslik[128], link[256], kanal[128];
	for(new i = 0; i < json_array_count(results); i++)
	{
		new JSONNode:node = json_array_at(results, i);

		json_get_string(node, baslik, sizeof(baslik), "title");
		json_get_string(node, link, sizeof(link), "full_link");
		json_get_string(node, kanal, sizeof(kanal), "channel");

		format(Arama[playerid][i][Isim], 128, "%s", baslik);
		format(Arama[playerid][i][Link], 256, "%s", link);
		format(Arama[playerid][i][Kanal], 128, "%s", kanal);

		format(string, sizeof(string), "%s"wb"%d.\t"w"%s\t"ad"%s\n", string, i + 1, baslik, kanal);
	}

	ShowPlayerDialog(playerid, DIALOG_YOUTUBE_ARAMA, DIALOG_STYLE_TABLIST_HEADERS, "Arama Sonuçlarý", string, "Çal", "Kapat");
	return true;
}

CB: YT_Cal(index, response_code, data[])
{
	new string[1000];

	if(response_code != 200)
	{
		Hata(YT_Kullanan, "Þarký dönüþtürülürken bir hata oluþtu! (RESPONSE CODE)");
		YT_Islem = false;
		return true;
	}

	new JSONNode: response = json_parse_string(data);

	if(index == 9999)
	{
		Hata(YT_Kullanan, "Þarký dönüþtürülürken bir hata oluþtu! (INDEX 9999)");
		YT_Islem = false;
		return true;
	}

	if(json_get_bool(response, "error"))
	{
		Hata(YT_Kullanan, "Þarký dönüþtürülürken bir hata oluþtu! (JSON ERROR)");
		YT_Islem = false;
		return true;
	}

	if(index != 499)
	{
		if(YTInfo[index + 1][Caliniyor] == true || YTInfo[index + 1][Sirada] == true)
		{
			json_get_string(response, YTInfo[index][Isim], 100, "title");
			YTInfo[index][Sure] = json_get_int(response, "duration");
			json_get_string(response, YTInfo[index][Donusturulen], 500, "file");
			YTInfo[index][Sirada] = true;
			YTInfo[index][Doldu] = true;
			YTInfo[index][Caliniyor] = false;
			format(YTInfo[index][Ekleyen], 24, "%s", getName(YT_Kullanan));
			SCM(YT_Kullanan, -1, "{90C3D4}GL Youtube » {FFFFFF}Þarký listeye eklendi.");
			YT_Islem = false;
			return true;
		}
	}
	

	json_get_string(response, YTInfo[index][Isim], 100, "title");
	YTInfo[index][Sure] = json_get_int(response, "duration");
	json_get_string(response, YTInfo[index][Donusturulen], 500, "file");
	format(YTInfo[index][Ekleyen], 24, "%s", getName(YT_Kullanan));
	YTInfo[index][Caliniyor] = true;
	YTInfo[index][Doldu] = true;

	json_close(response);

	for(new i, j = GetPlayerPoolSize(); i <= j; i++)
	{
		StopAudioStreamForPlayer(i);
	}
	format(string, sizeof(string), "~p~[SARKI] ~w~~h~~h~%s ~p~>> ~w~~h~~h~%s", YTInfo[index][Ekleyen], YTInfo[index][Isim]);
	TextMesaji(code(string));
	for(new i, j = GetPlayerPoolSize(); i <= j; i++)
	{
		PlayAudioStreamForPlayer(i, YTInfo[index][Donusturulen]);
	}

	format(string, sizeof(string), "{90C3D4}GL Youtube » {FFFFFF}Çalan þarký listesi için {90C3D4}/youtube {FFFFFF}yazabilirsiniz.");
	SendClientMessageToAll(-1, string);

	KillTimer(YTInfo[index][Timer]);
	YTInfo[index][Timer] = SetTimerEx("SarkiBitti", YTInfo[index][Sure] * 1000, false, "d", index);

	YT_Islem = false;
	return true;
}

CB: SarkiBitti(index)
{
	format(YTInfo[index][Donusturulen], 500, "");
	format(YTInfo[index][Isim], 100, "");
	format(YTInfo[index][Link], 500, "");
	YTInfo[index][Sure] = -1;
	YTInfo[index][Caliniyor] = false;
	YTInfo[index][Sirada] = false;
	format(YTInfo[index][Ekleyen], 24, "");
	KillTimer(YTInfo[index][Timer]);
	YT_Islem = false;
	new string[1024];
	index -= 1;
	if(!strlen(YTInfo[index][Donusturulen]))
	{
		foreach(new i: Player)
		{
			SCM(i, -1, "{90C3D4}GL Youtube » {FFFFFF}Sýradaki þarkýlar bitti, radyo açýlýyor.");
			PlayAudioStreamForPlayer(i, RADYO_URL);
		}
		for(new i; i < 500; i++)
		{
			format(YTInfo[i][Donusturulen], 500, "");
			format(YTInfo[i][Isim], 100, "");
			format(YTInfo[i][Link], 500, "");
			format(YTInfo[i][Ekleyen], 24, "");
			YTInfo[i][Sure] = -1;
			YTInfo[i][Caliniyor] = false;
			YTInfo[i][Sirada] = false;
			YTInfo[i][Doldu] = false;
			KillTimer(YTInfo[i][Timer]);
		}
		return true;
	}
	YTInfo[index][Caliniyor] = true;
	for(new i, j = GetPlayerPoolSize(); i <= j; i++)
	{
		StopAudioStreamForPlayer(i);
	}
	format(string, sizeof(string), "~p~[SARKI] ~w~~h~~h~%s ~p~>> ~w~~h~~h~%s", YTInfo[index][Ekleyen], YTInfo[index][Isim]);
	TextMesaji(code(string));
	for(new i, j = GetPlayerPoolSize(); i <= j; i++)
	{
		PlayAudioStreamForPlayer(i, YTInfo[index][Donusturulen]);
	}
	format(string, sizeof(string), "{90C3D4}GL Youtube » {FFFFFF}Çalan þarký listesi için {90C3D4}/youtube {FFFFFF}yazabilirsiniz.");
	SendClientMessageToAll(-1, string);
	KillTimer(YTInfo[index][Timer]);
	YTInfo[index][Timer] = SetTimerEx("SarkiBitti", YTInfo[index][Sure] * 1000, false, "d", index);
	return true;
}

CB: p_geo_OnInformationRequested(playerid, response_code, data[])
{
	if(response_code == 200)
	{
		new xd[1000];
		format(xd, 1000, "%s", code(data));
		sscanf(xd, "p<,>s[32]s[32]s[12]s[12]s[32]s[6]",
			player_geoInfo[playerid][player_country],
			player_geoInfo[playerid][player_city],
			player_geoInfo[playerid][player_lat],
			player_geoInfo[playerid][player_lon],
			player_geoInfo[playerid][player_provider],
			player_geoInfo[playerid][player_proxy]);
	}
	else
	{
		strmid(player_geoInfo[playerid][player_country], "-", 0, GEO_MAX_COUNTRY_NAME_LENGTH);
		strmid(player_geoInfo[playerid][player_city], "-", 0, GEO_MAX_CITY_NAME_LENGTH);
		strmid(player_geoInfo[playerid][player_lat], "-", 0, GEO_MAX_LAT_LON_LENGTH);
		strmid(player_geoInfo[playerid][player_lon], "-", 0, GEO_MAX_LAT_LON_LENGTH);
		strmid(player_geoInfo[playerid][player_provider], "-", 0, GEO_MAX_PROVIDER_NAME_LENGTH);
		strmid(player_geoInfo[playerid][player_proxy], "-", 0, GEO_MAX_PROXY_LENGTH);
	}
	return true;
}

Menu:SILAHLAR(playerid, response, listitem)
{
	if(response == MENU_RESPONSE_SELECT)
	{
		GivePlayerWeapon(playerid, Silahlar[listitem][sID], 5000);
	}
	TogglePlayerControllable(playerid, true);
}

CB: tebrikgizle(playerid)
{
	TextDrawHideForPlayer(playerid, tebrik0[playerid]);
	TextDrawHideForPlayer(playerid, tebrik1[playerid]);
	TextDrawHideForPlayer(playerid, tebrik2[playerid]);
	TextDrawHideForPlayer(playerid, tebrik3[playerid]);
	TextDrawHideForPlayer(playerid, tebrik4[playerid]);
	TextDrawHideForPlayer(playerid, tebrik5[playerid]);
	TextDrawHideForPlayer(playerid, tebrik6[playerid]);
    return true;
}

CB: geber(playerid)
{
	ClearAnimationsEx(playerid);
	SetPlayerHealth(playerid, -1.0);
	GivePlayerMoney(playerid, -10);
	return true;
}

CB: OnAntiCheatAutoBullet(playerid, weaponid)
{
	SistemKick(playerid, "Auto Bullet");
	return true;
}

CB: ParalariSil(playerid)
{
	for(new n = 0; n < 10; n++)
	{
	    if(IsValidDynamicPickup(ParalarPickup[playerid][n])) DestroyDynamicPickup(ParalarPickup[playerid][n]);
	    if(IsValidDynamic3DTextLabel(ParalarLabel[playerid][n])) DestroyDynamic3DTextLabel(ParalarLabel[playerid][n]);
	}
	PickupuMevcut[playerid] = false;
}

CB: MesajSil0()
{
	format(MessageStr[1], 128, "");
	TextDrawSetString(OlayText[0], "");
	EVT[1] = SetTimer("MesajSil1", 3700, false);
	return true;
}

CB: MesajSil1()
{
	format(MessageStr[2], 128, "");
	TextDrawSetString(OlayText[1], "");
	EVT[2] = SetTimer("MesajSil2", 3900, false);
	return true;
}

CB: MesajSil2()
{
	format(MessageStr[3], 128, "");
	TextDrawSetString(OlayText[2], "");
	EVT[3] = SetTimer("MesajSil3", 4100, false);
	return true;
}

CB: MesajSil3()
{
	format(MessageStr[4], 128, "");
	TextDrawSetString(OlayText[3], "");
	EVT[4] = SetTimer("MesajSil4", 4300, false);
	return true;
}

CB: MesajSil4()
{
	format(MessageStr[0], 128, "");
	TextDrawSetString(OlayText[4], "");
	return true;
}

CB: ParaKapat(playerid)
{
	TextDrawHideForPlayer(playerid, Para[playerid][0]);
	return true;
}

CB: RastgeleKlanYarat()
{
	new id, renk, isim[100], tag[10], sql[1024];
	new harfler[] = "AaBbCcDdEeFfGgHhJjKkLMmNnOoPpRrSsTtUuVvYyZz";
	for(new i = 0; i < 148; i++)
	{
		id = Iter_Free(klanlar);
		renk = randomEx(0, 6);
		for(new x = 0; x < 15; x++)
		{
			isim[x] = harfler[randomEx(0, 42)];
		}
		for(new x = 0; x < 5; x++)
		{
			tag[x] = harfler[randomEx(0, 42)];
		}
		format(sql, sizeof(sql), "INSERT INTO `klanlar` (`id`, `isim`, `tag`, `kasa`, `renk`, `level`, `exp`, `maxexp`, `kurulus_tarihi`) VALUES \
			('%d', '%s', '%s', '%d', '%d', '%d', '%d', '%d', '%s')", id, isim, tag, 0, renk, 1, 0, 1000, convertDate(gettime()));
		mysql_query(db, sql);
		Iter_Add(klanlar, id);
	}
	return true;
}

CB: Lotto()
{
	if(lData[lAktif] == true) return true;
	lData[lSkor] = randomEx(2, 5);
	lData[lPara] = randomEx(10, 30);
	foreach(new i: Player) LottoSayisi[i] = -1;
	lData[lAktif] = true;
	KillTimer(lData[lTimer]);
	lData[lTimer] = SetTimer("LottoBitir", 120000, false);
	lData[lSayi] = randomEx(0, 100);

	new asilstr[500];
	format(asilstr, sizeof(asilstr), "{CFDE49}GL Lotto » "w"Lotto baþladý! {CFDE49}/lottokatil "w"ile katýlabilirsiniz. Ýkramiye: {CFDE49}%d skor + %s TL", lData[lSkor], FormatMoney(lData[lPara]));
	SendClientMessageToAll(-1, asilstr);

	foreach(new i: Player)
	{
		if(pData[i][pAdmin] == 10)
		{
			format(asilstr, sizeof(asilstr), "Lotto cevabý >> %d", lData[lSayi]);
			Bilgi(i, asilstr);
		}
	}
	return true;
}

CB: LottoBitir()
{
	new winner = -1;
	foreach(new i: Player)
	{
		if(LottoSayisi[i] == lData[lSayi])
		{
			winner = i;
		}
	}

	if(winner == -1)
	{
		lData[lAktif] = false;
		KillTimer(lData[lTimer]);
		foreach(new i: Player) LottoSayisi[i] = -1;
		lData[lSkor] = -1;
		lData[lPara] = -1;
		new asilstr[500];
		format(asilstr, sizeof(asilstr), "{CFDE49}GL Lotto » "w"Lottoyu tutturabilen olmadý. Bir dahaki lottoyu bekleyin.");
		SendClientMessageToAll(-1, asilstr);
	}
	else
	{
		if(!IsPlayerConnected(winner))
		{
			lData[lAktif] = false;
			KillTimer(lData[lTimer]);
			foreach(new i: Player) LottoSayisi[i] = -1;
			lData[lSkor] = -1;
			lData[lPara] = -1;
			return true;
		}
		new asilstr[500];
		format(asilstr, sizeof(asilstr), "{CFDE49}GL Lotto » {%06x}%s "w"adlý oyuncu lottoyu tutturdu. {CFDE49}Tebrikler!", GetPlayerColor(winner) >>> 8, getName(winner));
		SendClientMessageToAll(-1, asilstr);
		GivePlayerMoney(winner, lData[lPara]);
		SetPlayerScore(winner, GetPlayerScore(winner) + lData[lSkor]);
		lData[lAktif] = false;
		KillTimer(lData[lTimer]);
		foreach(new i: Player) LottoSayisi[i] = -1;
		lData[lSkor] = -1;
		lData[lPara] = -1;
	}
	return true;
}

CB: AFK_Kick(playerid)
{
	if(!IsPlayerConnected(playerid)) return KillTimer(pData[playerid][pAFK_Timer]);
	SistemKick(playerid, "AFK!");
	return true;
}

CB: MatematikTesti()
{
	if(mData[mDurum] == true) return true;

	new asilstr[500];

	mData[mIlkHarf] = randomEx(1, 50);
	mData[mIkinciHarf] = randomEx(1, 25);

	switch(random(4))
	{
		case 0: format(mData[mIslem], 5, "*");
		case 1: format(mData[mIslem], 5, "+");
		case 2: format(mData[mIslem], 5, "-");
		case 3: format(mData[mIslem], 5, "/");
	}

	mData[mSkor] = randomEx(2, 5);
	mData[mPara] = randomEx(10, 30);

	if(!strcmp(mData[mIslem], "+"))
		mData[mCevap] = mData[mIlkHarf] + mData[mIkinciHarf];
	else if(!strcmp(mData[mIslem], "-"))
		mData[mCevap] = mData[mIlkHarf] - mData[mIkinciHarf];
	else if(!strcmp(mData[mIslem], "*"))
		mData[mCevap] = mData[mIlkHarf] * mData[mIkinciHarf];
	else if(!strcmp(mData[mIslem], "/"))
	{
		do
		{
			mData[mIlkHarf] = randomEx(1, 50);
			mData[mIkinciHarf] = randomEx(1, 25);
			mData[mCevap] = mData[mIlkHarf] / mData[mIkinciHarf];
		}
		while(mData[mIlkHarf] % mData[mIkinciHarf]);
	}

	format(asilstr, sizeof(asilstr), "{E5FF00}GL Matematik » "w"Verdiðim {E5FF00}%d %s %d "w"iþlemini ilk çözen {E5FF00}%d skor ve %s TL "w"kazanacak!", mData[mIlkHarf], mData[mIslem], mData[mIkinciHarf], mData[mSkor], FormatMoney(mData[mPara]));
	SendClientMessageToAll(-1, asilstr);

	mData[mDurum] = true;
	mData[mTimer] = SetTimer("MatematikTesti_Bitir", 15000, false);
	return true;
}

CB: MatematikTesti_Bitir()
{
	KillTimer(mData[mTimer]);
	mData[mDurum] = false;
	mData[mSkor] = 0;
	mData[mPara] = 0;
	mData[mCevap] = 0;
	mData[mIlkHarf] = 0;
	mData[mIkinciHarf] = 0;
	format(mData[mIslem], 5, "");
	SendClientMessageToAll(-1, "{E5FF00}GL Matematik » "w"Testi kimse yapmadý! Bir sonraki testi bekleyin.");
	return true;
}

CB: GenelTimer()
{
	LabelUpdate();
	new strX[512];
	foreach(new i: Player)
	{
		if(pData[i][pGiris] == true && pData[i][pAFK] == false) pData[i][pOnlineSuresi]++;

		if(pData[i][pGiris] == true && pData[i][pExp] >= pData[i][pMaxExp])
		{
			new str[512];
			basla:
			pData[i][pLevel]++;
			pData[i][pExp] -= pData[i][pMaxExp];
			pData[i][pMaxExp] = pData[i][pLevel] * 250;
			if(pData[i][pExp] >= pData[i][pMaxExp]) goto basla;
			format(str, sizeof(str), "Tebrikler level atladýnýz! Yeni leveliniz: "wb"%d", pData[i][pLevel]);
			Bilgi(i, str);
			OyuncuKaydet(i);
			format(str, sizeof(str), "%d", pData[i][pLevel]);
			TextDrawSetString(tebrik5[i], str);
			TextDrawShowForPlayer(i, tebrik0[i]);
			TextDrawShowForPlayer(i, tebrik1[i]);
			TextDrawShowForPlayer(i, tebrik2[i]);
			TextDrawShowForPlayer(i, tebrik3[i]);
			TextDrawShowForPlayer(i, tebrik4[i]);
			TextDrawShowForPlayer(i, tebrik5[i]);
			TextDrawShowForPlayer(i, tebrik6[i]);
			SetTimerEx("tebrikgizle", 4000, false, "i", i);
		}

		if(pData[i][pGiris] == true && pData[i][pMute] > 0 && pData[i][pAFK] == false) pData[i][pMute]--;
		if(pData[i][pGiris] == true && pData[i][pJail] > 0 && pData[i][pAFK] == false)
		{
			pData[i][pJail]--;
			format(strX, sizeof(strX), "~r~] ~w~%d ~r~]", pData[i][pJail]);
			GameTextForPlayer(i, strX, 1000, 5);
			if(pData[i][pJail] <= 0)
			{
				SetPlayerTeam(i, 0);
				SetPlayerInterior(i, 0);
				SetPlayerVirtualWorld(i, 0);
				SetPlayerWorldBounds(i, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
				SpawnPlayer(i);
				pData[i][pJail] = 0;
				OyuncuKaydet(i);
			}
		}
	}
	return true;
}

CB: GenelTimer2()
{
	foreach(new i: isyerleri)
	{
		if(iData[i][iBitisZaman] < gettime() && iData[i][iSahip] != -1)
		{
			new sahip = iData[i][iSahip];
			iData[i][iKilit] = 0;
			iData[i][iLevel] = 1;
			iData[i][iKasa] = 0;
			iData[i][iBitisZaman] = -1;
			iData[i][iSahip] = -1;

			new id = GetPlayerID(SQL_Isim_Cek(sahip));
			if(IsPlayerConnected(id))
			{
				pData[id][pIsYeri] = -1;
				OyuncuKaydet(id);
			}
			else
			{
				new sql[500];
				format(sql, sizeof(sql), "UPDATE `hesaplar` SET `isyeri` = '-1' WHERE `sqlid` = '%d'", sahip);
				mysql_query(db, sql);
			}

			IsYeriLabelGuncelle(i);

			IsYeriKaydet(i);
		}
	}
	return true;
}

CB: IsYeriKasa()
{
	new deger;
	foreach(new i: isyerleri)
	{
		if(iData[i][iSahip] != -1 && iData[i][iKilit] == 0)
		{
			deger = (iData[i][iFiyat] / 120) + randomEx(1, 50);
			deger += iData[i][iLevel] * 3;
			iData[i][iKasa] += deger;

			IsYeriKaydet(i);
		}
	}
	return true;
}

CB: Kick_Timer(playerid)
{
	Kick(playerid);
	return true;
}

CB: KorumaBitir(playerid)
{
	KillTimer(pData[playerid][pSpawnKorumaTimer]);
	SetPlayerMaxHealth(playerid, 100.0);
	if(IsValidDynamic3DTextLabel(pData[playerid][pSpawnKorumaLabel]))
		DestroyDynamic3DTextLabel(pData[playerid][pSpawnKorumaLabel]);
	SetPlayerHealth(playerid, 100.0);
	for(new i = 0; i < 6; i++)
	{
		if(pData[playerid][pSilahlar][i] != -1) GivePlayerWeapon(playerid, pData[playerid][pSilahlar][i], 3131);
	}
	pData[playerid][pSpawnKorumasinda] = false;
	AdminBilgi(playerid, "10 saniyelik spawn korumanýz sona erdi.");
	return true;
}

CB: ReaksiyonTesti()
{
	if(rData[rDurum] == true) return true;

	new harfler[] = "AaBbCcDdEeFfGgHhJjKkLMmNnOoPpRrSsTtUuVvYyZz1234567890";
	new string[25], asilstr[512];

	for(new i = 0; i < 13; i++)
	{
		string[i] = harfler[randomEx(0, 52)];
	}

	rData[rSkor] = randomEx(2, 5);
	rData[rPara] = randomEx(10, 30);

	format(asilstr, sizeof(asilstr), "{A2FF00}GL FastFingers » "w"Verdiðim {A2FF00}%s "w"harflerini ilk yazan {A2FF00}%d skor ve %s TL "w"kazanacak!", string, rData[rSkor], FormatMoney(rData[rPara]));
	SendClientMessageToAll(-1, asilstr);
	rData[rDurum] = true;
	format(rData[rHarfler], 50, "%s", string);
	rData[rTimer] = SetTimer("ReaksiyonTesti_Bitir", 15000, false);
	return true;
}

CB: ReaksiyonTesti_Bitir()
{
	KillTimer(rData[rTimer]);
	rData[rDurum] = false;
	rData[rPara] = -1;
	rData[rSkor] = -1;
	format(rData[rHarfler], 50, " ");
	SendClientMessageToAll(-1, "{A2FF00}GL FastFingers » "w"Testi kimse yapmadý! Bir sonraki testi bekleyin.");
	return true;
}

CB: BenzinDusur()
{
	foreach(new i: Player)
	{
		if(IsPlayerInAnyVehicle(i) && GetPlayerState(i) == PLAYER_STATE_DRIVER)
		{
			foreach(new x: araclar)
			{
				//if(GetPlayerVehicleID(i) == aData[x][aID] && aData[x][aSahip] == pData[i][pSQLID] && BenzinDolduruyor[i] != true)
				if(GetPlayerVehicleID(i) == aData[x][aID] && BenzinDolduruyor[i] != true)
				{
					aData[x][aBenzin]--;
					break;
				}
			}
		}
	}
	return true;
}

CB: BenzinDolduruluyor(playerid, arabaid)
{
	if(!IsPlayerInAnyVehicle(playerid))
	{
		Bilgi(playerid, "Benzin deposu tam olarak dolmadý!");
		TogglePlayerControllable(playerid, true);
		BenzinDolduruyor[playerid] = false;
		GameTextForPlayer(playerid, " ", 1000, 4);
		return KillTimer(BenzinTimer[playerid]);
	}
	if(aData[arabaid][aBenzin] != 100)
	{
		if(GetPlayerMoney(playerid) < 6)
		{
			Bilgi(playerid, "Benzin deposu tam olarak dolmadý! Yetersiz bakiye!");
			GameTextForPlayer(playerid, " ", 1000, 4);
			TogglePlayerControllable(playerid, true);
			BenzinDolduruyor[playerid] = false;
			return KillTimer(BenzinTimer[playerid]);
		}
		new string[512];
		format(string, sizeof(string), "~r~~h~Benzin dolduruluyor...~n~~g~~h~%d", aData[arabaid][aBenzin]);
		GameTextForPlayer(playerid, string, 1000, 5);
		aData[arabaid][aBenzin]++;
		GivePlayerMoney(playerid, -6);
	}
	else
	{
		Bilgi(playerid, "Benzin deposu dolduruldu!");
		GameTextForPlayer(playerid, " ", 1000, 5);
		TogglePlayerControllable(playerid, true);
		BenzinDolduruyor[playerid] = false;
		KillTimer(BenzinTimer[playerid]);
	}
	return true;
}

CB: AracGostergesi_Guncelle(playerid, aracid)
{
	if(pData[playerid][pAFK] == true) return true;
	if(!IsPlayerConnected(playerid)) return KillTimer(AracGostergesi_Timer[playerid]);

	if(!IsPlayerInAnyVehicle(playerid))
	{
		for(new q = 0; q < 68; q++)
		{
			TextDrawHideForPlayer(playerid, Hiz_Benzin[playerid][q]);
		}
		KillTimer(AracGostergesi_Timer[playerid]);
	}

	if(aData[aracid][aBenzin] <= 0)
	{
		SetVehicleToRespawn(aData[aracid][aID]);
		aData[aracid][aBenzin] = randomEx(10, 20);
		AdminBilgi(playerid, "Aracýnýzýn benzini bitti! En kýsa sürede benzinciye gitmelisiniz!");
	}

	new Float:vx, Float:vy, Float:vz, Float:vel, donusturulenHiz;
	vel = GetVehicleVelocity(GetPlayerVehicleID(playerid), vx, vy, vz);
	vel = (floatsqroot(((vx * vx) + (vy * vy)) + (vz * vz)) * 181.5);
	new aracHiz = floatround(vel, floatround_round);

	new toplam = GetVehicleMaxSpeed(GetVehicleModel(GetPlayerVehicleID(playerid))) / 30;
	donusturulenHiz = aracHiz / toplam;
	for(new x = 0; x < 31; x++)
	{
		if(x < donusturulenHiz)
		{
			TextDrawColor(Hiz_Benzin[playerid][x + 35], HizBarRenkleri[x]);
		} else {
			TextDrawColor(Hiz_Benzin[playerid][x + 35], 0x66666644);
		}
		TextDrawShowForPlayer(playerid, Hiz_Benzin[playerid][x + 35]);
	}

	new toplam2 = 100 / 30;
	donusturulenHiz = aData[aracid][aBenzin] / toplam2;
	for(new x = 0; x < 30; x++)
	{
		if(x < donusturulenHiz)
		{
			TextDrawColor(Hiz_Benzin[playerid][x + 4], HizBarRenkleri[x]);
		} else {
			TextDrawColor(Hiz_Benzin[playerid][x + 4], 0x66666644);
		}
		TextDrawShowForPlayer(playerid, Hiz_Benzin[playerid][x + 4]);
	}

	new str[100];
	format(str, sizeof(str), "~r~~h~~h~Hiz: ~g~~h~~h~%d ~r~~h~~h~Benzin: ~g~~h~~h~%d", aracHiz, aData[aracid][aBenzin]);
	TextDrawSetString(Hiz_Benzin[playerid][67], str);
	return true;
}
