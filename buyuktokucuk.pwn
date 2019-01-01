#include <a_samp>

public OnFilterScriptInit()
{
	new array[10];
	for(new i; i < 10; i++) array[i] = random(7) + 1, printf("%d", array[i]);
	printf("===================================");
	sirala(array, 10);
	for(new i; i < 10; i++) printf("%d", array[i]);
	return true;
}

stock sirala(array[], lenarray)
{
	new temp;
	for(new i = 0, j; i < lenarray; i++)
	{
		for(j = 0; j < (lenarray - i); j++)
		{
			if(array[j] < array[j + 1])
			{
				temp = array[j];
				array[j] = array[j + 1];
				array[j + 1] = temp;
			}
		}
	}
	return true;
}
