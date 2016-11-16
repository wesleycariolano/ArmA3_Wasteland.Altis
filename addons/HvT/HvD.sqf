//	@file Version: 1.0
//	@file Name: HvD.sqf
//	@file Author: Based on HvT.sqf by Cael817, CRE4MPIE. Rewrite by LouD.
//	@file Info:

if (isDedicated) exitWith {};
waitUntil {!isNull player};
waitUntil {!isNil "playerSpawning" && {!playerSpawning}};

for "_i" from 0 to 1 step 0 do 
{
	_lsdInv = mf_inventory select 10; _lsd = _lsdInv select 1;
	_marInv = mf_inventory select 11; _mar = _marInv select 1;
	_cocInv = mf_inventory select 12; _coc = _cocInv select 1;
	_herInv = mf_inventory select 13; _her = _herInv select 1;
	
	if (_lsd > 2 || _mar > 2 || _coc > 2 || _her > 2) then
		{
			_title  = "<t color='#ff0000' size='1.2' align='center'>Usuário de Drogas! </t><br />";
			_name = format ["%1<br /> ",name player];     
			_text = "<t color='#FFFFFF' shadow='1' shadowColor='#000000' align='center'>Alguém está carregando uma grande quantidade de drogas, sua posição foi espotada no mapa. Peguem esse drogado!</t><br />";     
			hint parsetext (_title +  _name +  _text); 
			playsound "Topic_Done";

			_markerName = format ["%1_drugMarker",name player];     
			_drugMarker = createMarker [_markerName, getPos (vehicle player)];
			_drugMarker setMarkerShape "ICON";
			_drugMarker setMarkerText (format ["Drogado: %1", name player]);
			_drugMarker setMarkerColor "ColorRed";
			_drugMarker setMarkerType "mil_dot";
			sleep 10;
			deleteMarker _markerName;
		};
}; //will run infinitely
