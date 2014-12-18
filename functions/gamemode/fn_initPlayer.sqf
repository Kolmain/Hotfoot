private ["_sideColor","_vis","_pos","_y","_hitID","_handleHealID","_score","_mus","_amb","_mark","_gridMark","_ao","_supports","_loadout"];
player setVariable ["KOL_score", 0, true];
_sideColor = [(side player)] call BIS_fnc_sideColor;

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
				switch (side _x) do {
				    case west: {
				    	drawIcon3D ["\A3\ui_f\data\map\markers\nato\b_mech_inf.paa", _sideColor, _pos, 1, 1, 0, "Reinforcement Truck", 0, 0.04];
				    };
				    case east: {
				    	drawIcon3D ["\A3\ui_f\data\map\markers\nato\o_mech_inf.paa", _sideColor, _pos, 1, 1, 0, "Reinforcement Truck", 0, 0.04];
				    };
				    case independent: {
				    	drawIcon3D ["\A3\ui_f\data\map\markers\nato\i_mech_inf.paa", _sideColor, _pos, 1, 1, 0, "Reinforcement Truck", 0, 0.04];
				    };
				};
			};
		};
	} foreach [opVehicle_west, opVehicle_east, opVehicle_guerrila];
}] call BIS_fnc_addStackedEventHandler;

_hitID = player addEventHandler ["Hit",{
	if (alive player) then {
		[["damage","fak"], 15, "", 35, "", true, true, true, true] call BIS_fnc_advHint;
		player removeEventHandler ["Hit", _hitID];
	};
}];

_handleHealID = player addEventHandler ["HandleHeal",{
	[[[_this select 1], {
		if (player == (_this select 1)) then {
			_score = player getVariable "KOL_score";
			_score = _score + 1;
			player setVariable ["KOL_score", _score, true];
			["PointsAdded",["Applied FAK to Friendly Unit.", 1]] call BIS_fnc_showNotification;
			[player, 1] call BIS_fnc_addScore;
		};
	}], "BIS_fnc_spawn", true] call BIS_fnc_MP;
}];


_mus = [] spawn BIS_fnc_jukebox;
_amb = [] spawn KOL_fnc_createAmbientEnviroment;
_gridMark = [] spawn KOL_fnc_gridMarkers;
_ao = [aoTrig] spawn BIS_fnc_drawAO;
_supports = [] spawn KOL_fnc_initPlayerSupports;
_rank = [player] spawn KOL_fnc_rankHandler;
/*
player createDiaryRecord ["Intel", ["Situation", "The captial of Altis, Pyrgos, is being assaulted by OPFOR infantry in order to seize a foothold for a counter offensive. Friendly forces are tasked with capturing and securing <marker name="city">Pyrgos</marker> before the OPFOR have the chance to."]];
player createDiaryRecord ["Intel", ["Enemy Forces", "Enemy forces will be moving infantry squads in from their Observation Posts on the outskirts of the city. These OP's are expected to be well defended, and you should avoid them at all costs. Expect heavy infantry and light vehicle support from OPFOR units."]];
player createDiaryRecord ["Intel", ["Friendly Forces", "Friendly forces will be accompanying your team in the assault. Additional support assets are available and will be standing by. In addition to infantry fireteams, HQ will be providing QRF, UGV, and fire support from the FOB."]];

_task = player createsimpletask ["obj0"];
_task setsimpletaskdescription ["ASSAULT PYRGOS", "Assault and secure the city of Pyrgos. Minimize civilian impact and counter-attacka any OPFOR infantry within the city.", "ASSAULT"];
_task setsimpletaskdestination hardpoint;
_task settaskstate "Current";
[nil, nil, _task, "created"] execvm "\ca\modules\mp\data\scriptcommands\taskhint.sqf";
*/

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
