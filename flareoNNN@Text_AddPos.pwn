// flareoNNN TextDraw Position Calculator

#include <a_samp>

#define EKLENECEK_POS 		(2.499961)
#define VARSAYILAN_POS      (55.270874)
#define URETILECEK_ADET     (60)
#define VARSAYILAN_SATIR    "%f|153.250045|0.607554|8.028333|60.270874|0.000000|1|-1|0|255|0|0|255|2|1|0|1|I|0|0.000000|0.000000|0.000000|0.000000|0|0"

public OnFilterScriptInit()
{
	for(new sil___; sil___ < 120; sil___++) print(" ");
	for(new __@ekleTD; __@ekleTD < URETILECEK_ADET; __@ekleTD++)
	{
	    printf(VARSAYILAN_SATIR, (VARSAYILAN_POS + (EKLENECEK_POS * (__@ekleTD + 1))));
	}
	return true;
}
