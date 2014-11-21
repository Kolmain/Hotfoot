_sideColor = [(side player)] call BIS_fnc_sideColor;
setViewDistance ("viewDistanceParam" call BIS_fnc_getParamValue);
["armory3DText", "onEachFrame", {
	private["_vis","_pos"];
	{
		_sideColor = [(side player)] call BIS_fnc_sideColor;
		if (player distance _x < 100) then
		{
			_vis = lineIntersects [eyePos player, eyePos _x, player, _x];
			if(!_vis) then
			{
				_pos = visiblePosition _x;
				_pos set[2,(getPosATL _x select 2) + 2.2];
				drawIcon3D ["\A3\ui_f\data\map\markers\military\pickup_CA.paa",_sideColor,_pos,1,1,0, "Armory Officer",0,0.04];
			};
		};
	} foreach [va_west, va_east, va_guerrilla];	
}] call BIS_fnc_addStackedEventHandler;
	
["respawnVehicle3DText", "onEachFrame", {
	private["_vis","_pos"];
	{
		_sideColor = [(side player)] call BIS_fnc_sideColor;
		if(player distance _x < 100) then
		{
			_vis = lineIntersects [eyePos player, eyePos _x, player, _x];
			if(!_vis) then
			{
				_pos = visiblePosition _x;
				_pos set[2,(getPosATL _x select 2) + 2.2];
				drawIcon3D ["\A3\ui_f\data\map\markers\nato\b_mech_inf.paa", _sideColor, _pos, 1, 1, 0, "Arrival Truck", 0, 0.04];
			};
		};
	} foreach [respawnVehicle_west, respawnVehicle_east, respawnVehicle_guerrilla];
}] call BIS_fnc_addStackedEventHandler;

	
["fob3DText", "onEachFrame", {
	private["_vis","_pos"];
	{
	_sideColor = [(side player)] call BIS_fnc_sideColor;
	_y = getMarkerPos _x;
		if((player distance _y < 600) && (player distance _y > 150)) then
		{
				_pos = visiblePosition _y;
				_pos set[2,(getPosATL _y select 2) + 2.2];
				drawIcon3D ["\A3\ui_f\data\map\markers\nato\b_hq.paa", _sideColor,_pos,1,1,0, "Forward Operating Base",0,0.04];
		};
	} foreach [fob_west, fob_east, fob_guerrilla];
}] call BIS_fnc_addStackedEventHandler;

_hitID = player addEventHandler ["Hit",{ 
	_agony = player getVariable "tcb_ais_agony";
	if ((alive player) && (!_agony)) then {
		[["damage","fak"], 15, "", 35, "", true, true, true, true] call BIS_fnc_advHint; 
		player removeEventHandler ["Hit", 0];
	};
}];


_mus = [] spawn BIS_fnc_jukebox;
_amb = [] spawn KOL_fnc_createAmbientEnviroment;
_mark = [player, "PLAYER"] spawn KOL_fnc_unitMarkers;
_ao = [aoTrig] spawn BIS_fnc_drawAO; 
[] spawn KOL_fnc_initPlayerSupports;


_loadout = [(side player)] spawn KOL_fnc_initPlayerLoadout;


_colorWest = [west] call BIS_fnc_sideColor;
_colorEast = [east] call BIS_fnc_sidecolor;

	[
		hardpoint,
		"BATTLE OF Pyrgos",//spawns the text
		400,//height
		500,//radius
		10,//angle
		(random 1),//clockwise\anit-clock
		[
			["\A3\ui_f\data\map\markers\flags\Altis_ca.paa", _sideColor, hardpoint,  1, 1, 0, "Pyrgos", 0]
		],
		0
	] call BIS_fnc_establishingShot;
