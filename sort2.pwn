#include <a_samp>

#define BUYUK_KUCUK 0
#define KUCUK_BUYUK 1

public OnFilterScriptInit()
{
	new array[25];
	
	for(new i; i < sizeof(array); i++) array[i] = random(25) + 5;
	
	for(new i; i < sizeof(array); i++) printf("%d", array[i]);
	
	print("=====================");
	
	Duzenle(array, sizeof(array), BUYUK_KUCUK);
	//Duzenle(array, sizeof(array), KUCUK_BUYUK);
	return true;
}

stock Duzenle(arr[], size, type)
{
	new _max, _min;
	
	for(new i; i < size; i++)
	{
	    if(arr[i] > _max)
	    {
	        _max = arr[i];
	    }
	}
	_min = _max;
	for(new i; i < size; i++)
	{
	    if(_min > arr[i])
	    {
	        _min = arr[i];
	    }
	}
	
	switch(type)
	{
	    case BUYUK_KUCUK: // 0
	    {
			for(new x = _max; x != -1; x--)
			{
			    for(new i; i < size; i++)
			    {
			        if(arr[i] == x)
			        {
			            printf("%d", arr[i]);
			        }
			    }
			}
	    }
	    case KUCUK_BUYUK: // 1
	    {
			for(new x = _min; x < _max; x++)
			{
			    for(new i; i < size; i++)
			    {
			        if(arr[i] == x)
			        {
			            printf("%d", arr[i]);
			        }
			    }
			}
	    }
	}
	return true;
}
