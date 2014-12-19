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
    	_spawnPos = [(getMarkerPos "arespawn_west"), 10, 500, 10, 0, 2, 0] call BIS_fnc_findSafePos;
		_spawnedGrp = [_spawnPos, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSquad")] call BIS_fnc_spawnGroup;
		_retArray = [getMarkerPos "arespawn_west", 180, "B_Heli_Transport_03_F", _heliGrp] call bis_fnc_spawnvehicle;
		_pos2 = getMarkerPos "arespawn_west";
	};
    case east: {
    	_spawnPos = [(getMarkerPos "arespawn_west"), 10, 500, 10, 0, 2, 0] call BIS_fnc_findSafePos;
		_spawnedGrp = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
		_retArray = [getMarkerPos "arespawn_east", 180, "O_Heli_Transport_04_F", _heliGrp] call bis_fnc_spawnvehicle;
		_pos2 = getMarkerPos "arespawn_east";
	};
    case RESISTANCE: {
    	_spawnPos = [(getMarkerPos "arespawn_west"), 10, 500, 10, 0, 2, 0] call BIS_fnc_findSafePos;
		_spawnedGrp = [_spawnPos, RESISTANCE, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
		_retArray = [getMarkerPos "arespawn_guerrila", 180, "I_Heli_Transport_02_F", _heliGrp] call bis_fnc_spawnvehicle;
		_pos2 = getMarkerPos "arespawn_guerrila";
	};
};
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
		_x setSkill ("AISkill" call BIS_fnc_getParamValue);
		if (("nvgs" call BIS_fnc_getParamValue) == 1) then {
			_x unassignItem "NVGoggles";
			_x removeItem "NVGoggles";
			_x unassignItem "NVGoggles_OPFOR";
			_x removeItem "NVGoggles_OPFOR";
			_x unassignItem "NVGoggles_INDEP";
			_x removeItem "NVGoggles_INDEP";
		};
		if (("weaponFX" call BIS_fnc_getParamValue) == 1) then {
			_x addEventHandler ["Fired", {_this execVM "scripts\L_Twitch.sqf";}];
		};
	} forEach units _spawnedGrp;

	_lz = [_pos] call KOL_fnc_findNearestLZ;

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