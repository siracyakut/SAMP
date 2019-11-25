#include <a_samp>
#include <streamer>
#include <RouteConnector>

#pragma dynamic 65536

enum Data
{
	RouteID,
	AreaID
}

new Storage[MAX_PLAYERS][Data];

enum POSx
{
	Float:posxX,
	Float:posxY,
	Float:posxZ
}

#define NAN (Float:0x7FFFFFFF)

public GPS_WhenRouteIsCalculated(routeid,node_id_array[],amount_of_nodes,Float:distance)
{
	SendClientMessage(routeid,-1,"Calculated... creating");
	new Float:Angle;
	new Less = (amount_of_nodes-1);
	new Float:CP[9][POSx];
	new Float:Polygon[4096] = {NAN,...};
	new Float:ReversePolygon[2048] = {NAN,...};
	Storage[routeid][RouteID] = StoreRouteArray(amount_of_nodes,node_id_array);
	new NodeIDs[3];
    //new Float:Heights[2322] = {NAN,...};
    //new Float:RHeights[1366];
    new Float:poses[2][2];
	for(new NodeID = 1; NodeID < Less; ++NodeID)
	{
		NodeIDs[0] = GetRouteAtPos(Storage[routeid][RouteID],NodeID-1);
		NodeIDs[1] = GetRouteAtPos(Storage[routeid][RouteID],NodeID);
		NodeIDs[2] = GetRouteAtPos(Storage[routeid][RouteID],NodeID+1);
		GetNodePos(NodeIDs[1],CP[0][posxX],CP[0][posxY],CP[0][posxZ]);
		GetNodePos(NodeIDs[2],CP[2][posxX],CP[2][posxY],CP[2][posxZ]);
		GetNodePos(NodeIDs[0],CP[1][posxX],CP[1][posxY],CP[1][posxZ]);
		
		Angle = GetAngleBetweenNodes(NodeIDs[0],NodeIDs[1],NodeIDs[2]);

		if(IsNodeIntersection(NodeIDs[1]) == 1)
	    {
			if(Angle < 178.0 && Angle > -178.0)
			{
			    CalculatePositions(CP[1][posxX],CP[1][posxY],CP[0][posxX],CP[0][posxY],CP[2][posxX],CP[2][posxY],15.0,poses[0][0],poses[0][1],poses[1][0],poses[1][1]);
				//Lets say that the center of the circle is (CP[0][posxX],CP[0][posxY]) and that the arc contains your two points (x1, y1) and (x2, y2). Then the radius is: r=sqrt((x1-x0)(x1-x0) + (y1-y0)(y1-y0)). So:
				//print("a");
				//new Float:r = 15.0;
				//new Float:x = CP[0][posxX]-r;
				//new Float:y = CP[0][posxY]-r;
				//new Float:width = 2.0*r;
				//new Float:height = 2.0*r;
				new Float:startAngle	= atan2(poses[0][1]-CP[0][posxY], poses[0][0]-CP[0][posxX])-5.0;
				new Float:endAngle		//= atan2(poses[1][1]-CP[0][posxY], poses[1][0]-CP[0][posxX]);
				= startAngle + (185.0-floatabs(Angle));
			    new Float:SinMin;
			    new Float:CosMin;
				new Float:Filler = endAngle-startAngle;
				new Float:Adder = startAngle;
				new Float:result = (CP[2][posxX] - CP[1][posxX]) * (CP[0][posxY] - CP[1][posxY]) - (CP[2][posxY] - CP[1][posxY]) * (CP[0][posxX] - CP[1][posxX]);
			    if(result > 0)
			    {
					for(new Float:x = 0.0; startAngle <= x <= endAngle; x+=Filler/20.0)
					{
					    Adder=startAngle+x;
					    //printf("%f %f %f %f",x,Adder,endAngle,startAngle);
						CosMin = CP[0][posxX]-floatcos(Adder,degrees)*10.0;
						SinMin = CP[0][posxY]-floatsin(Adder,degrees)*10.0;
				    	CreateDynamic3DTextLabel(">", 0xFF0000FF, CosMin,SinMin,CP[0][posxZ]+1.5, 50.0);
				    }
				}
				else
				{
					for(new Float:x = 0.0; startAngle <= x <= endAngle; x+=Filler/20.0)
					{
					    Adder=startAngle+x;
					    //printf("%f %f %f %f",x,Adder,endAngle,startAngle);
						CosMin = CP[0][posxX]+floatcos(Adder,degrees)*10.0;
						SinMin = CP[0][posxY]+floatsin(Adder,degrees)*10.0;
				    	CreateDynamic3DTextLabel("<", 0xFF0000FF, CosMin,SinMin,CP[0][posxZ]+1.5, 50.0);
				    }
				}

			    
			    
			    /*print("d");
				for(new Float:x = 0.0; Adder <= endAngle-startAngle; x+=1.0,Adder = (startAngle+(x*Filler))*(-1.0))
				{
					CosMin = CP[0][posxX]-floatcos(Adder,degrees)*15.0;
					SinMin = CP[0][posxY]-floatsin(Adder,degrees)*15.0;
			    	CreateDynamic3DTextLabel("<", 0x00FF00FF, CosMin,SinMin,CP[0][posxZ]+1.5, 50.0);
			    }
			    print("e");
				for(new Float:x = 0.0; Adder <= endAngle-startAngle; x+=1.0,Adder = (startAngle+(x*Filler))*(-1.0))
				{
					CosMin = CP[0][posxX]-floatcos(-Adder,degrees)*15.0;
					SinMin = CP[0][posxY]-floatsin(-Adder,degrees)*15.0;
			    	CreateDynamic3DTextLabel("<", 0x0000FFFF, CosMin,SinMin,CP[0][posxZ]+1.5, 50.0);
			    }
			    print("f");
				for(new Float:x = 0.0; Adder <= endAngle-startAngle; x+=1.0,Adder = (startAngle+(x*Filler))*(-1.0))
				{
					CosMin = CP[0][posxX]+floatcos(-Adder,degrees)*15.0;
					SinMin = CP[0][posxY]+floatsin(-Adder,degrees)*15.0;
			    	CreateDynamic3DTextLabel("<", 0x00FFFFFF, CosMin,SinMin,CP[0][posxZ]+1.5, 50.0);
			    }*/
				/*new Float:DeltaX;
				new Float:DeltaY;
				new Float:DeltaZ;
				new Float:AdderX;
				new Float:AdderY;
				new Float:AdderZ;
				new Float:Length;
				new Float:Distance = 15.0;
				DeltaX = CP[1][posxX] - CP[0][posxX];
		        DeltaY = CP[1][posxY] - CP[0][posxY];
		        DeltaZ = CP[1][posxZ] - CP[0][posxZ];
		        Length = floatsqroot(((DeltaX * DeltaX) + (DeltaY * DeltaY) + (DeltaZ * DeltaZ))) + 0.0000000001;
		        AdderX = (DeltaX / Length);
		        AdderY = (DeltaY / Length);
		        AdderZ = (DeltaZ / Length);
		        CP[3][posxX] = (CP[0][posxX] + (AdderX * Distance));
		        CP[3][posxY] = (CP[0][posxY] + (AdderY * Distance));
		        CP[3][posxZ] = (CP[0][posxZ]);

		        DeltaX = CP[2][posxX] - CP[0][posxX];
		        DeltaY = CP[2][posxY] - CP[0][posxY];
		        DeltaZ = CP[2][posxZ] - CP[0][posxZ];
		        Length = floatsqroot(((DeltaX * DeltaX) + (DeltaY * DeltaY) + (DeltaZ * DeltaZ))) + 0.0000000001;
		        AdderX = (DeltaX / Length);
		        AdderY = (DeltaY / Length);
		        AdderZ = (DeltaZ / Length);
		        CP[4][posxX] = (CP[0][posxX] + (AdderX * Distance));
		        CP[4][posxY] = (CP[0][posxY] + (AdderY * Distance));
		        CP[4][posxZ] = (CP[0][posxZ]);

		        DeltaX = CP[3][posxX] - CP[4][posxX];
		        DeltaY = CP[3][posxY] - CP[4][posxY];
		        DeltaZ = CP[3][posxZ] - CP[4][posxZ];
		        Length = floatsqroot(((DeltaX * DeltaX) + (DeltaY * DeltaY) + (DeltaZ * DeltaZ))) + 0.0000000001;
		        AdderX = (DeltaX / Length);
		        AdderY = (DeltaY / Length);
		        AdderZ = (DeltaY / Length);
		        CP[8][posxX] = (CP[4][posxX] + (AdderX * Length / 2.0));
		        CP[8][posxY] = (CP[4][posxY] + (AdderY * Length / 2.0));
		        CP[8][posxZ] = (CP[4][posxZ] + (AdderZ * Length / 2.0));

		        DeltaX = CP[8][posxX] - CP[0][posxX];
		        DeltaY = CP[8][posxY] - CP[0][posxY];
		        DeltaZ = CP[8][posxZ] - CP[0][posxZ];
		        Length = floatsqroot(((DeltaX * DeltaX) + (DeltaY * DeltaY) + (DeltaZ * DeltaZ))) + 0.0000000001;
		        AdderX = (DeltaX / Length);
		        AdderY = (DeltaY / Length);
		        AdderZ = (DeltaZ / Length);
		        CP[7][posxX] = (CP[0][posxX] - (AdderX * Distance));
		        CP[7][posxY] = (CP[0][posxY] - (AdderY * Distance));
		        CP[7][posxZ] = (CP[0][posxZ]);

		        DeltaX = CP[2][posxX] - CP[0][posxX];
		        DeltaY = CP[2][posxY] - CP[0][posxY];
		        DeltaZ = CP[2][posxZ] - CP[0][posxZ];
		        Length = floatsqroot(((DeltaX * DeltaX) + (DeltaY * DeltaY) + (DeltaZ * DeltaZ))) + 0.0000000001;
		        AdderX = (DeltaX / Length);
		        AdderY = (DeltaY / Length);
		        AdderZ = (DeltaZ / Length);
		        CP[5][posxX] = (CP[7][posxX] + (AdderX * Distance * 1.5));
		        CP[5][posxY] = (CP[7][posxY] + (AdderY * Distance * 1.5));
		        CP[5][posxZ] = (CP[7][posxZ]);

		        DeltaX = CP[1][posxX] - CP[0][posxX];
		        DeltaY = CP[1][posxY] - CP[0][posxY];
		        DeltaZ = CP[1][posxZ] - CP[0][posxZ];
		        Length = floatsqroot(((DeltaX * DeltaX) + (DeltaY * DeltaY) + (DeltaZ * DeltaZ))) + 0.0000000001;
		        AdderX = (DeltaX / Length);
		        AdderY = (DeltaY / Length);
		        AdderZ = (DeltaZ / Length);
		        CP[6][posxX] = (CP[7][posxX] + (AdderX * Distance * 1.5));
		        CP[6][posxY] = (CP[7][posxY] + (AdderY * Distance * 1.5));
		        CP[6][posxZ] = (CP[7][posxZ]);

		        DeltaX = CP[7][posxX] - CP[5][posxX];
		        DeltaY = CP[7][posxY] - CP[5][posxY];
		        DeltaZ = CP[7][posxZ] - CP[5][posxZ];
		        AdderX = (DeltaX / 20.0);
		        AdderY = (DeltaY / 20.0);
		        AdderZ = (DeltaZ / 20.0);
		        for(new i = 0; i < 21; ++i)
		        {
		            CreateDynamicObject(1318,CP[7][posxX]-((AdderX)*i),CP[7][posxY]-((AdderY)*i),CP[7][posxZ]-((AdderZ)*i)+1.5,0.0,0.0,0.0);
		        }

		        DeltaX = CP[7][posxX] - CP[6][posxX];
		        DeltaY = CP[7][posxY] - CP[6][posxY];
		        DeltaZ = CP[7][posxZ] - CP[6][posxZ];
		        AdderX = (DeltaX / 20.0);
		        AdderY = (DeltaY / 20.0);
		        AdderZ = (DeltaZ / 20.0);
		        for(new i = 0; i < 21; ++i)
		        {
		            CreateDynamicObject(1318,CP[7][posxX]-((AdderX)*i),CP[7][posxY]-((AdderY)*i),CP[7][posxZ]-((AdderZ)*i)+1.5,0.0,0.0,0.0);
		        }*/
			}
		}
		else
	    {
     		//GetNodePos(NodeIDs[1],CP[0][posxX],CP[0][posxY],CP[0][posxZ]);
       		//CreateDynamicObject(1318,CP[0][posxX],CP[0][posxY],CP[0][posxZ]+1.0,0.0,0.0,0.0);
	    }
	    if(NodeID == 1)
	    {
	    	StartPoints(CP[1][posxX],CP[1][posxY],CP[0][posxX],CP[0][posxY],-25.0,poses[0][0],poses[0][1],poses[1][0],poses[1][1]);
	    	//CreateDynamic3DTextLabel("###", 0xFF0000FF, poses[0][0],poses[0][1],CP[1][posxZ]+1.5, 100.0);
	    	//CreateDynamic3DTextLabel("###", 0x0000FFFF, poses[1][0],poses[1][1],CP[1][posxZ]+1.5, 100.0);
	    	for(new i = 0; i < 2048; ++i)
	    	{
	    	    if(Polygon[i] != Polygon[i])
	    	    {
	    			Polygon[i] = poses[0][0];
	    			Polygon[i+1] = poses[0][1];
	    			//Heights[i/2] = CP[0][posxZ];
	    			break;
	    		}
	    	}
	    	for(new i = 0; i < 2048; ++i)
	    	{
	    	    if(ReversePolygon[i] != ReversePolygon[i])
	    	    {
	    			ReversePolygon[i] = poses[1][0];
	    			ReversePolygon[i+1] = poses[1][1];
	    			//RHeights[i/2] = CP[1][posxZ];
	    			break;
	    		}
	    	}
	    }else
        if(NodeID == (Less-1))
        {
	    	FinishPoints(CP[0][posxX],CP[0][posxY],CP[2][posxX],CP[2][posxY],15.0,poses[0][0],poses[0][1],poses[1][0],poses[1][1]);
	    	//CreateDynamic3DTextLabel("###", 0xFF0000FF, poses[0][0],poses[0][1],CP[1][posxZ]+1.5, 100.0);
	    	//CreateDynamic3DTextLabel("###", 0x0000FFFF, poses[1][0],poses[1][1],CP[1][posxZ]+1.5, 100.0);
	    	for(new i = 0; i < 2048; ++i)
	    	{
	    	    if(Polygon[i] != Polygon[i])
	    	    {
	    			Polygon[i] = poses[0][0];
	    			Polygon[i+1] = poses[0][1];
	    			//Heights[i/2] = CP[0][posxZ];
	    			break;
	    		}
	    	}
	    	for(new i = 0; i < 2048; ++i)
	    	{
	    	    if(ReversePolygon[i] != ReversePolygon[i])
	    	    {
	    			ReversePolygon[i] = poses[1][0];
	    			ReversePolygon[i+1] = poses[1][1];
	    			//RHeights[i/2] = CP[1][posxZ];
	    			break;
	    		}
	    	}
        }else
	    if(Angle < 178.0 && Angle > -178.0)
	    {
            CalculatePositions(CP[1][posxX],CP[1][posxY],CP[0][posxX],CP[0][posxY],CP[2][posxX],CP[2][posxY],15.0,poses[0][0],poses[0][1],poses[1][0],poses[1][1]);
	    	//CreateDynamic3DTextLabel("###", 0xFF0000FF, poses[0][0],poses[0][1],CP[1][posxZ]+1.5, 100.0);
	    	//CreateDynamic3DTextLabel("###", 0x0000FFFF, poses[1][0],poses[1][1],CP[1][posxZ]+1.5, 100.0);
	    	for(new i = 0; i < 2048; ++i)
	    	{
	    	    if(Polygon[i] != Polygon[i])
	    	    {
	    			Polygon[i] = poses[0][0];
	    			Polygon[i+1] = poses[0][1];
	    			//Heights[i/2] = CP[0][posxZ];
	    			break;
	    		}
	    	}
	    	for(new i = 0; i < 2048; ++i)
	    	{
	    	    if(ReversePolygon[i] != ReversePolygon[i])
	    	    {
	    			ReversePolygon[i+1] = poses[1][0];
	    			ReversePolygon[i] = poses[1][1];
	    			//RHeights[i/2] = CP[1][posxZ];
	    			break;
	    		}
	    	}
	    }
	}
	new begin = 0;
	for(new i = 0; i < 4096; ++i)
	{
	    if(Polygon[i] != Polygon[i])
	    {
	        begin = i;
	        break;
		}
	}
	for(new i = 2047; i != (-1); --i)
	{
	    if(ReversePolygon[i] == ReversePolygon[i])
	    {
	        Polygon[begin++]=ReversePolygon[i];
	    }
	}
	/*begin = 0;
	for(new i = 0; i < 2322; ++i)
	{
	    if(Heights[i] != Heights[i])
	    {
	        begin = i;
	        break;
		}
	}
	for(new i = 1365; i != (-1); --i)
	{
	    if(RHeights[i] == RHeights[i])
	    {
	        Heights[begin++]=RHeights[i];
	    }
	}*/
	Polygon[4094] = Polygon[0];
	Polygon[4095] = Polygon[1];
	//new count = 0;
	for(new i = 0; i < 4094; ++i)
	{
	    if(Polygon[i] != Polygon[i])
	    {
	        //if(count == 0)
	        //{
	        //    count = i-1;
	        //}
	        Polygon[i] = Polygon[i-2];
	        Polygon[i+1] = Polygon[i-1];
	    }
	}
	/*printf("Count: %d|%d",count,count/2);
	
    new Float:DeltaX;
    new Float:DeltaY;
    new Float:DeltaZ;
    new Float:Length;
	new Float:AdderX;
	new Float:AdderY;
	new Float:AdderZ;

	for(new i = 1; i < (count/2); ++i)
	{
    	DeltaX = Polygon[i*2] - Polygon[(i*2)+2];
    	DeltaY = Polygon[(i*2)+1] - Polygon[(i*2)+3];
    	Length = floatsqroot( (DeltaX * DeltaX) + (DeltaY * DeltaY) + (DeltaZ * DeltaZ) ) + 0.0000000001;
	    AdderX = (DeltaX / Length);
	    AdderY = (DeltaY / Length);
	    AdderZ = (DeltaZ / Length);
		for(new Float:x = 0.0; x < Length; x+=1.0)
		{
	    	CreateDynamic3DTextLabel("#", 0xFF0000FF, Polygon[i*2]+AdderX*x,Polygon[(i*2)+1]+AdderY*x,Heights[i]+AdderZ*x, 60.0);
		}
	}*/
	Storage[routeid][AreaID] = CreateDynamicPolygon(Polygon);
	SendClientMessage(routeid,-1,"...DONE!");
	return 1;
}

new bool:PlayerOnRoute[MAX_PLAYERS] = {false,...};
public OnPlayerEnterDynamicArea(playerid, areaid)
{
    if(areaid == Storage[playerid][AreaID])
	{
	    PlayerOnRoute[playerid] = true;
		SendClientMessage(playerid,0x00FF00FF,"Entered the GPS route path");
	}
	return 1;
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
    if(areaid == Storage[playerid][AreaID])
	{
	    PlayerOnRoute[playerid] = false;
		SendClientMessage(playerid,0xFF0000FF,"Exited the GPS route path");
	}
	return 1;
}

public OnFilterScriptExit()
{
	DestroyAllDynamicObjects();
	DestroyAllDynamic3DTextLabels();
	DestroyAllDynamicAreas();
	for(new i = 0; i < MAX_PLAYERS; ++i)
	{
		if(Storage[i][RouteID] >= 0)
		{
			DeleteArray(Storage[i][RouteID]);
		}
	}
	return 1;
}

new calc[MAX_PLAYERS] = {0,...};

forward doit(playerid);
public doit(playerid)
{
	new Float:POS[3];
	GetNodePos(GetRouteAtPos(Storage[playerid][RouteID],0),POS[0],POS[1],POS[2]);
	PutPlayerInVehicle(playerid,CreateVehicle(411,POS[0],POS[1],POS[2]+3.0,0.0,0,0,999999),0);
	return 1;
}

enum DIRECTION
{
	STRAIGHT,
	LEFT_LOW,
	LEFT_HIGH,
	RIGHT_LOW,
	RIGHT_HIGH,
	UTURN_LEFT,
	UTURN_RIGHT
}

new Text3D:PlayerLabels[MAX_PLAYERS][6];
public OnPlayerClosestNodeIDChange(playerid,old_NodeID,new_NodeID)
{
	if(new_NodeID >= 0)
	{
		if(calc[playerid] == 0)
		{
		    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		    {
			    calc[playerid] = 1;
			    CalculatePath(new_NodeID,24039,playerid);
			    SetTimerEx("doit",2000,0,"i",playerid);
		    }
		}
  		else
		{
			if(PlayerOnRoute[playerid] == true)
			{
			    new DIRECTION:result;
			    for(new i = 5,j = GetRouteArraySize(Storage[playerid][RouteID])-4; i < j; ++i)
			    {
			        if(GetRouteAtPos(Storage[playerid][RouteID],i-5) == new_NodeID)
			        {
			        	//SetNodeIDMarkInArray(Storage[playerid][RouteID],new_NodeID,1,1);
			        	if(IsNodeIntersection(GetRouteAtPos(Storage[playerid][RouteID],i+3)) == 1)
		    			{
		    			    DestroyDynamic3DTextLabel(PlayerLabels[playerid][0]);
		    			    PlayerLabels[playerid][0] = PlayerLabels[playerid][1];
		    			    PlayerLabels[playerid][1] = PlayerLabels[playerid][2];
		    			    PlayerLabels[playerid][2] = PlayerLabels[playerid][3];
		    			    PlayerLabels[playerid][3] = PlayerLabels[playerid][4];
		    			    PlayerLabels[playerid][4] = PlayerLabels[playerid][5];
				            result = IsLeftStraighRight(GetRouteAtPos(Storage[playerid][RouteID],i+2),GetRouteAtPos(Storage[playerid][RouteID],i+3),GetRouteAtPos(Storage[playerid][RouteID],i+4));
							new Float:POS[3];
							GetNodePos(GetRouteAtPos(Storage[playerid][RouteID],i+3),POS[0],POS[1],POS[2]);
							switch(result)
				            {
								//case STRAIGHT:
								//{
		                        //    //SendClientMessage(playerid,-1,"Please go STRAIGH at next intersection");
		                        //    PlayerLabels[playerid][5] = CreateDynamic3DTextLabel("GO STRAIGHT", 0xFF0000FF,POS[0],POS[1],POS[2]+1.0, 45.0);
		                        //    PlayAudioStreamForPlayer(playerid,"http://translate.google.com/translate_tts?q=go+straight.");
								//}
								case LEFT_LOW:
								{
									//SendClientMessage(playerid,-1,"Please turn LEFT_LOW at next intersection");
									PlayerLabels[playerid][5] = CreateDynamic3DTextLabel("TURN LEFT (LOW)", 0xFF0000FF,POS[0],POS[1],POS[2]+1.0, 45.0);
									PlayAudioStreamForPlayer(playerid,"http://translate.google.com/translate_tts?q=turn+left.");
								}
								case LEFT_HIGH:
								{
									//SendClientMessage(playerid,-1,"Please turn LEFT_HIGH at next intersection");
									PlayerLabels[playerid][5] = CreateDynamic3DTextLabel("TURN LEFT (HIGH)", 0xFF0000FF,POS[0],POS[1],POS[2]+1.0, 45.0);
									PlayAudioStreamForPlayer(playerid,"http://translate.google.com/translate_tts?q=turn+left.");
								}
								case RIGHT_LOW:
								{
									//SendClientMessage(playerid,-1,"Please turn RIGHT_LOW at next intersection");
									PlayerLabels[playerid][5] = CreateDynamic3DTextLabel("TURN RIGHT (LOW)", 0xFF0000FF,POS[0],POS[1],POS[2]+1.0, 45.0);
									PlayAudioStreamForPlayer(playerid,"http://translate.google.com/translate_tts?q=turn+right.");
								}
								case RIGHT_HIGH:
								{
									//SendClientMessage(playerid,-1,"Please turn RIGHT_HIGH at next intersection");
									PlayerLabels[playerid][5] = CreateDynamic3DTextLabel("TURN RIGHT (HIGH)", 0xFF0000FF,POS[0],POS[1],POS[2]+1.0, 45.0);
									PlayAudioStreamForPlayer(playerid,"http://translate.google.com/translate_tts?q=turn+right.");
								}
								case UTURN_LEFT:
								{
									//SendClientMessage(playerid,-1,"Please make a UTURN_LEFT at next intersection");
									PlayerLabels[playerid][5] = CreateDynamic3DTextLabel("TAKE UTURN TO LEFT", 0xFF0000FF,POS[0],POS[1],POS[2]+1.0, 45.0);
									PlayAudioStreamForPlayer(playerid,"http://translate.google.com/translate_tts?q=make+a+u+turn+to+the+left.");
								}
								case UTURN_RIGHT:
								{
									//SendClientMessage(playerid,-1,"Please make a UTURN_RIGHT at next intersection");
									PlayerLabels[playerid][5] = CreateDynamic3DTextLabel("TAKE UTURN TO RIGHT", 0xFF0000FF,POS[0],POS[1],POS[2]+1.0, 45.0);
									PlayAudioStreamForPlayer(playerid,"http://translate.google.com/translate_tts?q=make+a+u+turn+to+the+right.");
								}
				            }
				            return 1;
				        }
				        //not found on list
				    }
			    }
			}
			else
			{
			    //SendClientMessage(playerid,-1,"Please return to your route!");
			}
		}
	}
	return 1;
}

stock FinishPoints(Float:pX,Float:pY,Float:lX,Float:lY,Float:Distance,&Float:RedX,&Float:RedY,&Float:BlueX,&Float:BlueY)
{
    new Float:DeltaX;
    new Float:DeltaY;
    new Float:AdderX;
    new Float:AdderY;
    new Float:Length;
    DeltaX = pX - lX;
    DeltaY = pY - lY;
    Length = floatsqroot(((DeltaX * DeltaX) + (DeltaY * DeltaY))) + 0.0000000001;
    AdderX = (DeltaX / Length);
    AdderY = (DeltaY / Length);
    new Float:Angle01 = atan2(lX - pX, lY - pY);
    new Float:SinMin = floatsin(-Angle01,degrees);
    new Float:CosMin = floatcos(-Angle01,degrees);

    RedX = lX + (CosMin * Distance) - AdderX * Distance;//red
    RedY = lY + (SinMin * Distance) - AdderY * Distance;//red
    BlueX = lX - (CosMin * Distance) - AdderX * Distance;//blue
    BlueY = lY - (SinMin * Distance) - AdderY * Distance;//blue
    return 1;
}

stock StartPoints(Float:fX,Float:fY,Float:sX,Float:sY,Float:Distance,&Float:RedX,&Float:RedY,&Float:BlueX,&Float:BlueY)
{
    new Float:DeltaX;
    new Float:DeltaY;
    new Float:AdderX;
    new Float:AdderY;
    new Float:Length;
    DeltaX = sX - fX;
    DeltaY = sY - fY;
    Length = floatsqroot(((DeltaX * DeltaX) + (DeltaY * DeltaY))) + 0.0000000001;
    AdderX = (DeltaX / Length);
    AdderY = (DeltaY / Length);
    new Float:Angle01 = atan2(fX - sX, fY - sY);
    new Float:SinMin = floatsin(-Angle01,degrees);
    new Float:CosMin = floatcos(-Angle01,degrees);
    RedX = sX + (CosMin * Distance) + AdderX * Distance;//red
    RedY = sY + (SinMin * Distance) + AdderY * Distance;//red
    BlueX = sX - (CosMin * Distance) + AdderX * Distance;//blue
    BlueY = sY - (SinMin * Distance) + AdderY * Distance;//blue
	return 1;
}

stock CalculatePositions(Float:startX,Float:startY, Float:middleX,Float:middleY, Float:endX,Float:endY, Float:Distance,&Float:RedX,&Float:RedY,&Float:BlueX,&Float:BlueY)
{
    new Float:DeltaX;
    new Float:DeltaY;
    new Float:AdderX;
    new Float:AdderY;
    new Float:Length;
    new Float:CP[10][2];
    CP[0][0] = middleX;
    CP[0][1] = middleY;
    CP[1][0] = startX;
    CP[1][1] = startY;
    CP[2][0] = endX;
    CP[2][1] = endY;
    
    DeltaX = CP[1][0] - CP[0][0];
    DeltaY = CP[1][1] - CP[0][1];
    Length = floatsqroot(((DeltaX * DeltaX) + (DeltaY * DeltaY))) + 0.0000000001;
    AdderX = (DeltaX / Length);
    AdderY = (DeltaY / Length);
    CP[3][0] = (CP[0][0] + (AdderX * Distance));
    CP[3][1] = (CP[0][1] + (AdderY * Distance));

    DeltaX = CP[2][0] - CP[0][0];
    DeltaY = CP[2][1] - CP[0][1];
    Length = floatsqroot(((DeltaX * DeltaX) + (DeltaY * DeltaY))) + 0.0000000001;
    AdderX = (DeltaX / Length);
    AdderY = (DeltaY / Length);
    CP[4][0] = (CP[0][0] + (AdderX * Distance));
    CP[4][1] = (CP[0][1] + (AdderY * Distance));

    DeltaX = CP[3][0] - CP[4][0];
    DeltaY = CP[3][1] - CP[4][1];
    Length = floatsqroot(((DeltaX * DeltaX) + (DeltaY * DeltaY))) + 0.0000000001;
    AdderX = (DeltaX / Length);
    AdderY = (DeltaY / Length);
    CP[8][0] = (CP[4][0] + (AdderX * Length / 2.0));
    CP[8][1] = (CP[4][1] + (AdderY * Length / 2.0));

    DeltaX = CP[8][0] - CP[0][0];
    DeltaY = CP[8][1] - CP[0][1];
    Length = floatsqroot(((DeltaX * DeltaX) + (DeltaY * DeltaY))) + 0.0000000001;
    AdderX = (DeltaX / Length);
    AdderY = (DeltaY / Length);
    CP[7][0] = (CP[0][0] - (AdderX * Distance));
    CP[7][1] = (CP[0][1] - (AdderY * Distance));
    CP[9][0] = (CP[0][0] + (AdderX * Distance));
    CP[9][1] = (CP[0][1] + (AdderY * Distance));
    
    if((endX - startX) * (CP[7][1] - startY) - (endY - startY) * (CP[7][0] - startX) > 0)
    {
        CP[7][0] = (CP[0][0] + (AdderX * Distance));
        CP[7][1] = (CP[0][1] + (AdderY * Distance));
        CP[9][0] = (CP[0][0] - (AdderX * Distance));
        CP[9][1] = (CP[0][1] - (AdderY * Distance));
	}
	
	RedX = CP[7][0];//red
	RedY = CP[7][1];//red
	BlueX = CP[9][0];//blue
	BlueY = CP[9][1];//blue
    return 1;
}

forward DIRECTION:IsLeftStraighRight(NodeFrom,NodeMiddle,NodeTo,&Float:refAngle=0.0);
stock DIRECTION:IsLeftStraighRight(NodeFrom,NodeMiddle,NodeTo,&Float:refAngle=0.0)
{
    new Float:DeltaX;
    new Float:DeltaY;
    new Float:AdderX;
    new Float:AdderY;
    new Float:Length;
    new Float:CP[9][2];
    
    GetNodePos(NodeFrom,CP[1][0],CP[1][1],DeltaX);
    GetNodePos(NodeMiddle,CP[0][0],CP[0][1],DeltaX);
    GetNodePos(NodeTo,CP[2][0],CP[2][1],DeltaX);
    
    DeltaX = CP[1][0] - CP[0][0];
    DeltaY = CP[1][1] - CP[0][1];
    Length = floatsqroot(((DeltaX * DeltaX) + (DeltaY * DeltaY))) + 0.0000000001;
    AdderX = (DeltaX / Length);
    AdderY = (DeltaY / Length);
    CP[3][0] = (CP[0][0] + (AdderX * 30.0));
    CP[3][1] = (CP[0][1] + (AdderY * 30.0));

    DeltaX = CP[2][0] - CP[0][0];
    DeltaY = CP[2][1] - CP[0][1];
    Length = floatsqroot(((DeltaX * DeltaX) + (DeltaY * DeltaY))) + 0.0000000001;
    AdderX = (DeltaX / Length);
    AdderY = (DeltaY / Length);
    CP[4][0] = (CP[0][0] + (AdderX * 30.0));
    CP[4][1] = (CP[0][1] + (AdderY * 30.0));

    DeltaX = CP[3][0] - CP[4][0];
    DeltaY = CP[3][1] - CP[4][1];
    Length = floatsqroot(((DeltaX * DeltaX) + (DeltaY * DeltaY))) + 0.0000000001;
    AdderX = (DeltaX / Length);
    AdderY = (DeltaY / Length);
    CP[8][0] = (CP[4][0] + (AdderX * Length / 2.0));
    CP[8][1] = (CP[4][1] + (AdderY * Length / 2.0));

    DeltaX = CP[8][0] - CP[0][0];
    DeltaY = CP[8][1] - CP[0][1];
    Length = floatsqroot(((DeltaX * DeltaX) + (DeltaY * DeltaY))) + 0.0000000001;
    AdderX = (DeltaX / Length);
    AdderY = (DeltaY / Length);
    CP[7][0] = (CP[0][0] - (AdderX * 30.0));
    CP[7][1] = (CP[0][1] - (AdderY * 30.0));

	new Float:result = (CP[2][0] - CP[1][0]) * (CP[7][1] - CP[1][1]) - (CP[2][1] - CP[1][1]) * (CP[7][0] - CP[1][0]);
	new Float:Angle = floatabs(GetAngleBetweenNodes(NodeFrom,NodeMiddle,NodeTo));
	refAngle = Angle;
    if(result < 0.0)
    {
		if(Angle <= 75.0)
		{
		    return UTURN_LEFT;
		}else
		if(Angle <= 135.0)
		{
			return LEFT_HIGH;
		}else
		if(Angle <= 177.5)
		{
		    return LEFT_LOW;
		}
		else
		{
		    return STRAIGHT;
		}
	}else
	if(result == 0.0)
	{
	    return STRAIGHT;
	}else
	if(result > 0.0)
	{
		if(Angle <= 75.0)
		{
		    return UTURN_RIGHT;
		}else
		if(Angle <= 135.0)
		{
			return RIGHT_HIGH;
		}else
		if(Angle <= 177.5)
		{
		    return RIGHT_LOW;
		}
		else
		{
		    return STRAIGHT;
		}
	}
	return STRAIGHT;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
    CalculatePath(NearestPlayerNode(playerid), NearestNodeFromPoint(fX,fY,fZ), playerid, true, 12.0);
	return true;
}
