/*=================================================================================================================
  Timed Restart Script
  
  by Weeks
 [15thMEU(SOC)]
=================================================================================================================*/

ServerDuration = (3* 60 * 60);
DebugServerDuration = (20 * 60);



private ["_timeStart","_timeSinceStart","_shutdownSuccess","_isDebug","_msg30mins","_msg15mins","_msg5mins","_timeUntilRestart","_30minspassed","_15minspassed","_5minspassed","_60secondspassed"];

_isDebug = false;

if(_isDebug) then
{
	ServerDuration = DebugServerDuration;
};

_msg30mins = "<t color='#FFFF00' size='1.25'>Server Restart</t><br/> Este servidor ira reiniciar em menos de 30 minutos.";
_msg15mins = "<t color='#FF9D47' size='1.25'>Server Restart</t><br/> Este servidor ira reiniciar em menos de 15 minutos.";
_msg5mins = "<t color='#FF5500' size='1.25'>Server Restart</t><br/> Este servidor ira reiniciar em menos de 05 minutos.";
_msg1mins = "<t color='#FF0000' size='1.25'>Server Restart</t><br/> Este servidor ira reiniciar em menos de 60 segundos! FACA LOG OUT AGORA!";

_30minspassed = false;
_15minspassed = false;
_5minspassed = false;
_60secondspassed = false;

_timeStart = diag_tickTime;

while{true} do
{
	_timeSinceStart = diag_tickTime - _timeStart;
	_timeUntilRestart = ServerDuration - _timeSinceStart;
	
	if(_isDebug) then
	{
		diag_log format ["Time Since Start: %1, Time Until Restart: %2", _timeSinceStart, _timeUntilRestart];
	};
	
	switch true do
	{
		case ((_timeUntilRestart < (1 * 60)) && !_60secondspassed) : 
		{
			//_msg1mins call DMS_fnc_BroadcastMissionStatus; // using Defent's mission broadcast format for our messages
			_msg1mins remoteExecCall ["DMS_CLIENT_fnc_spawnDynamicText", -2];
			diag_log "60 segundos ate o servidor reiniciar.";
			_60secondspassed = true;
			_5minspassed = true;
			_15minspassed = true;
			_30minspassed = true;
		};
		case ((_timeUntilRestart < (5 * 60)) && !_5minspassed) : 
		{
			//_msg5mins call DMS_fnc_BroadcastMissionStatus;
			_msg5mins remoteExecCall ["DMS_CLIENT_fnc_spawnDynamicText", -2];
			diag_log "5 minutos ate o servidor reiniciar.";
			_5minspassed = true;
			_15minspassed = true;
			_30minspassed = true;
		};
		case ((_timeUntilRestart < (15 * 60)) && !_15minspassed) : 
		{
			//_msg15mins call DMS_fnc_BroadcastMissionStatus;
			_msg15mins remoteExecCall ["DMS_CLIENT_fnc_spawnDynamicText", -2];
			diag_log "15 minutos ate o servidor reiniciar.";
			_15minspassed = true;
			_30minspassed = true;
		};
		case ((_timeUntilRestart < (30 * 60)) && !_30minspassed) : 
		{
			//_msg30mins call DMS_fnc_BroadcastMissionStatus;
			_msg30mins remoteExecCall ["DMS_CLIENT_fnc_spawnDynamicText", -2];
			diag_log "30 minutos ate o servidor reiniciar.";
			_30minspassed = true;
		};
	};
	
	if(_timeSinceStart > ServerDuration) then
	{
		diag_log "Restart timeout elapsed, attempting server shutdown.";
		_shutdownSuccess = "[server rcon password]" serverCommand "#shutdown";
		if(_shutdownSuccess) then
		{
			diag_log "Reiniciando o Servidor!";
		}
		else
		{
			diag_log "Restart falhou!";
		};
		
	};
	
	sleep 15;
};