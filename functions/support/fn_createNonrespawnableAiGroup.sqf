private ["_grpSide","_pos","_hardpoint","_spawnedGrp","_retArray","_heli","_heliCrew","_heliGrp","_pos2","_respawnPos","_heliDriver","_closest","_closestdist","_lz"];

_grpSide = _this select 0;
_pos = _this select 1;
if (_grpSide == independent) then {_grpSide = RESISTANCE;};
_hardpoint = hardpoint;
_spawnedGrp = group init_obj;
//_retArray = [init_obj];
//_heli = init_obj;
//_heliCrew = [init_obj];
_heliGrp = createGroup _grpSide;

switch (_grpSide) do {
    case west: {
		_spawnedGrp = [getMarkerPos "arespawn_west", WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSquad")] call BIS_fnc_spawnGroup;
		_retArray = [getMarkerPos "arespawn_west", 180, "B_Heli_Transport_03_F", _heliGrp] call bis_fnc_spawnvehicle;
		_pos2 = getMarkerPos "arespawn_west";
	};
    case east: {
		_spawnedGrp = [getMarkerPos "arespawn_east", EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
		_retArray = [getMarkerPos "arespawn_east", 180, "O_Heli_Transport_04_F", _heliGrp] call bis_fnc_spawnvehicle;
		_pos2 = getMarkerPos "arespawn_east";
	};
    case RESISTANCE: {
		_spawnedGrp = [getMarkerPos "arespawn_guerrila", RESISTANCE, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
		_retArray = [getMarkerPos "arespawn_guerrila", 180, "I_Heli_Transport_02_F", _heliGrp] call bis_fnc_spawnvehicle;
		_pos2 = getMarkerPos "arespawn_guerrila";
	};
};
_respawnPos = [_grpSide, (leader _spawnedGrp)] spawn BIS_fnc_addRespawnPosition;
if (isMultiplayer) then {
	{
		_x addMPEventHandler ["MPKilled", {_this spawn KOL_fnc_onUnitKilled}];
	}  forEach units _spawnedGrp;
} else {
	{
		_x addEventHandler ["Killed", {_this spawn KOL_fnc_onUnitKilled}];
	}  forEach units _spawnedGrp;

};
	[(leader _heliGrp), format["%1 is en-route with friendly reinforcements, out.", groupID _heliGrp]] call KOL_fnc_globalSideChat;
	_heli = vehicle leader _heliGrp;
	_heliDriver = driver _heli;
	_heliCrew = crew _heli;
	_heli setCaptive true;
	//_heli = _retArray select 0;
	//_heliCrew = _retArray select 1;
	//_heliGrp = _retArray select 2;

	_heliDriver = driver _heli;
	_heliDriver disableAI "FSM";
	_heliDriver disableAI "TARGET";
	_heliDriver disableAI "AUTOTARGET";
	_heliGrp setBehaviour "AWARE";
	_heliGrp setCombatMode "RED";
	_heliGrp setSpeedMode "NORMAL";
	{
		_x moveInCargo _heli;
		_x assignAsCargo _heli;
	} forEach units _spawnedGrp;

	_closest = getPos init_obj;
	_closestdist = 100000;
	{
	  if (_x distance _pos < _closestdist) then {
		_closest = _x;
		_closestdist = _x distance _pos;
	  };
	} forEach landingArray;
	_lz = _closest;

	_heliDriver move _lz;
	_heli flyInHeight 50;
	_heli lock 3;
if (isMultiplayer) then {
	{
		_x addMPEventHandler ["MPKilled", {_this spawn KOL_fnc_onUnitKilled}];
	}  forEach units _heliGrp;
	_heli addMPEventHandler ["MPKilled", {_this spawn KOL_fnc_onUnitKilled}];
} else {
	{
		_x addEventHandler ["Killed", {_this spawn KOL_fnc_onUnitKilled}];
	}  forEach units _heliGrp;
	_heli addEventHandler ["Killed", {_this spawn KOL_fnc_onUnitKilled}];
};
	waitUntil {(_heli distance _lz < 100)};
	{
		_x moveInCargo _heli;
		_x assignAsCargo _heli;
	} forEach units _spawnedGrp;
	_heli flyInHeight 0;
	_heli land "LAND";
	waitUntil {(isTouchingGround _heli)};
	_spawnedGrp leaveVehicle _heli;
	[(leader _spawnedGrp), format["Be advised, %1 is in the AO and engaging, out.", groupID _spawnedGrp]] call KOL_fnc_globalSideChat;
	[(leader _spawnedGrp) , "city", "ASSUALT"] execvm "scripts\UPSMON.sqf";
	_heli land "NONE";
	_heliDriver move _pos2;
	_heli flyInHeight 50;
	waitUntil {(_heli distance _pos2 < 300)};
	{
		deleteVehicle _x;
	} forEach _heliCrew;
	deleteVehicle _heli;
	deleteGroup _heliGrp;