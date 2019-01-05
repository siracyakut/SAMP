/*
		==============================================================
								Date Plugin v0.1
				Kodlama:
							Burak (NexoR)
				Tarih:
							15.04.2018

			Bu plugin ile tarih işlerini hızlıca kullanabilirsiniz.
		==============================================================
*/

#if defined _date_included
	#endinput
#endif
#define _date_included

native GunGoster(dplugin_str[], len = sizeof(dplugin_str));
native AyGoster(dplugin_str[], len = sizeof(dplugin_str));
native TarihGoster(dplugin_str[], len = sizeof(dplugin_str));
native SaatGoster(dplugin_str[], len = sizeof(dplugin_str));
native TimeStampTamTarih(dplugin_int, dplugin_str[], len = sizeof(dplugin_str));
native TimeStampCevir(dplugin_int, dplugin_str[], len = sizeof(dplugin_str));
native TimeStampTarih(dplugin_int, dplugin_str[], len = sizeof(dplugin_str));
native TimeStampSaat(dplugin_int, dplugin_str[], len = sizeof(dplugin_str));
native TimeStampManuel(dplugin_int = 0, &dplugin_yil = 0, &dplugin_ay = 0, &dplugin_gun = 0, &dplugin_saat = 0, &dplugin_dakika = 0, &dplugin_saniye = 0);