private ["_sideColor","_vis","_pos","_y","_hitID","_handleHealID","_score","_mus","_amb","_mark","_gridMark","_ao","_supports","_loadout"];

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
	if (alive player) then {
		[["damage","fak"], 15, "", 35, "", true, true, true, true] call BIS_fnc_advHint;
		player removeEventHandler ["Hit", 0];
	};
}];

_handleHealID = player addEventHandler ["HandleHeal",{
	[[[_this select 1], {
		if (player == (_this select 1)) then {
			_score = player getVariable "KOL_score";
			_score = _score + 1;
			player setVariable ["KOL_score", _score, true];
			["PointsAdded",["Applied FAK to Friendly Unit", 1]] call BIS_fnc_showNotification;
			[player, 1] call BIS_fnc_addScore;
		};
	}], "BIS_fnc_spawn", true] call BIS_fnc_MP;
}];


_mus = [] spawn BIS_fnc_jukebox;
_amb = [] spawn KOL_fnc_createAmbientEnviroment;
//_mark = [player, "PLAYER"] spawn KOL_fnc_unitMarkers;
_gridMark = [] spawn KOL_fnc_gridMarkers;
_ao = [aoTrig] spawn BIS_fnc_drawAO;
_supports = [] spawn KOL_fnc_initPlayerSupports;
_loadout = [(side player)] spawn KOL_fnc_initPlayerLoadout;



	[
		hardpoint,
		"BATTLE OF PYRGOS",//spawns the text
		400,//height
		500,//radius
		10,//angle
		(random 1),//clockwise\anit-clock
		[
			["\A3\ui_f\data\map\markers\flags\Altis_ca.paa", [1,1,1,1], hardpoint,  1, 1, 0, "Pyrgos", 0]
		],
		0
	] call BIS_fnc_establishingShot;
