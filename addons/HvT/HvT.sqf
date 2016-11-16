//	@file Version: 1.0
//	@file Name: HvT.sqf
//	@file Author: Cael817, CRE4MPIE, rewrite by LouD.
//	@file Info:

if (isDedicated) exitWith {};
waitUntil {!isNull player};
waitUntil {!isNil "playerSpawning" && {!playerSpawning}};

for "_i" from 0 to 1 step 0 do 
{
	if (player getvariable "cmoney" > 150000) then
		{
			_title  = "<t color='#ff0000' size='1.2' align='center'>Alvo de alto valor!! </t><br />";
			_name = format ["%1<br /> ",name player];     
			_text = "<t color='#FFFFFF' shadow='1' shadowColor='#000000' align='center'>Alguém carregando uma grande quantia foi espotada no mapa, peguem ele!!</t><br />";     
			hint parsetext (_title +  _name +  _text); 
			playsound "Topic_Done";

			_markerName = format ["%1_bountyMarker",name player];  
			_bountyMarker = createMarker [_markerName, getPos (vehicle player)];
			_bountyMarker setMarkerShape "ICON";
			_bounty = [player getVariable ["cmoney", 0]] call fn_numbersText;
			_bountyMarker setMarkerText (format ["Alvo de grande valor: %1 (%2$)", name player, _bounty]);
			_bountyMarker setMarkerColor "ColorRed";
			_bountyMarker setMarkerType "mil_dot";
			sleep 10;
			deleteMarker _markerName;
		};
}; //will run infinitely
