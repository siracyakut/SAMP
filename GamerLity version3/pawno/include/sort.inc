/*
 *       ==================================================================
 *                              Sort Plugin v1.0
 *          
 *                           Kodlama: Burak (NexoR)
 *                                22.04.2018
 *
 *          Bu plugin ile siralama islemlerinizi hizlica yapabilirsiniz.
 *       ==================================================================
 *
 */
 
#if defined _sort_included
	#endinput
#endif
#define _sort_included

native Sort_Asc(nxr_array[], len = sizeof(nxr_array));
native Sort_DeAsc(nxr_array[], len = sizeof(nxr_array));