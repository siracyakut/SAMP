#include "a_samp"

public OnFilterScriptInit()
{
	new sayilar[10];
	for(new i; i < 10; i++) sayilar[i] = random(10) + 1, printf("[%d]: %d", i, sayilar[i]);
	printf("=============================================");
	BubbleSort(sayilar, 10);
	for(new i; i < 10; i++) printf("[%d]: %d", i, sayilar[i]);
	return true;
}

stock BubbleSort(array[], a_size = sizeof(array))
{
	new temp;
	for(new i = 0, j; i < a_size; i++)
	{
		for(j = 0; j < (a_size - i); j++)
		{
			if(array[j] > array[j + 1])
			{
				temp = array[j];
				array[j] = array[j + 1];
				array[j + 1] = temp;
			}
		}
	}
	return true;
}
