_caller = _this select 0;
_pos = _this select 1;
_target = _this select 2;
_is3D = _this select 3;
_ID = _this select 4;
_grpSide = side _caller;
if (_grpSide == independent) then {_grpSide = RESISTANCE;};
_grp = group caller;
_rifles = units group caller;
_pos2 = [0,0,0];



switch (_grpSide) do {
    case west: {
		_grp = [getMarkerPos "arespawn_west", WEST, ["B_soldier_F", "B_soldier_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
		_rifles = units _grp;
		_retArray = [getMarkerPos "arespawn_west", 180, "B_MRAP_01_hmg_F", _grp] call bis_fnc_spawnvehicle;
		_retArray2 = [getMarkerPos "arespawn_west", 180, "B_Heli_Transport_03_F", WEST] call bis_fnc_spawnvehicle;
		_pos2 = getMarkerPos "arespawn_west";
	};
    case east: {
		_grp = [getMarkerPos "arespawn_west", EAST, ["O_Soldier_F", "O_Soldier_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
		_rifles = units _grp;
		_retArray = [getMarkerPos "arespawn_east", 180, "O_MRAP_02_hmg_F", _grp] call bis_fnc_spawnvehicle;
		_retArray2 = [getMarkerPos "arespawn_east", 180, "O_Heli_Transport_04_F", EAST] call bis_fnc_spawnvehicle;
		_pos2 = getMarkerPos "arespawn_east";
	};
    case RESISTANCE: {
		_grp = [getMarkerPos "arespawn_west", RESISTANCE, ["I_soldier_F", "I_soldier_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
		_rifles = units _grp;
		_retArray = [getMarkerPos "arespawn_west", 180, "I_MRAP_03_hmg_F", _grp] call bis_fnc_spawnvehicle;
		_retArray2 = [getMarkerPos "arespawn_guerrila", 180, "I_Heli_Transport_02_F", RESISTANCE] call bis_fnc_spawnvehicle;
		_pos2 = getMarkerPos "arespawn_guerrila";
	};
};
	_vehicle = _retArray select 0;
	_crew = _retArray select 1;
	//_grp = _retArary select 2;

	_heli = _retArray2 select 0;
	_heliCrew = _retArray2 select 1;
	_heliGrp = _retArray2 select 2;
	_heliDriver = driver _heli;
	_heli setCaptive true;
	{
		_x assignAsCargo _vehicle;
		_x moveInCargo _vehicle;
		_x setSkill ("AISkill" call BIS_fnc_getParamValue);
		if (("nvgs" call BIS_fnc_getParamValue) == 1) then {
		_x unassignItem "NVGoggles";
		_x removeItem "NVGoggles";
		_x unassignItem "NVGoggles_OPFOR";
		_x removeItem "NVGoggles_OPFOR";
		_x unassignItem "NVGoggles_INDEP";
		_x removeItem "NVGoggles_INDEP";
	};
	} forEach _rifles;

[_caller, format["%2, this is %1, requesting QRF, over.", groupID (group _caller), groupID _grp]] call KOL_fnc_globalSideChat;
sleep 3;
[(leader _grp), format["%1, this is %2, copy your last. Send landing grid, over.", groupID (group _caller), groupID _grp]] call KOL_fnc_globalSideChat;
sleep 3;
[_caller, format["Grid %1, over.", mapGridPosition _pos]] call KOL_fnc_globalSideChat;
sleep 3;

_dis = _pos distance hardpoint;

if (_dis > 1200) then {

	[(leader _grp), format["%1, requested coordinates are outside of the AO, request denied, out.", groupID (group _caller), groupID _grp]] call KOL_fnc_globalSideChat;
	sleep 3;
	_newQrf = [_caller, "qrfRequest"] call BIS_fnc_addCommMenuItem;
	{
		deleteVehicle _x;
	} forEach _heliCrew;
	{
		deleteVehicle _x;
	} forEach units _grp;
	deleteVehicle _heli;
	deleteVehicle _vehicle;
	deleteGroup _heliGrp;
	deleteGroup _grp;
} else {
	[(leader _grp), format["Copy that %1, dispatching to requested coordinates, out.", groupID (group _caller), groupID _grp]] call KOL_fnc_globalSideChat;
	sleep 3;

	_heli setSlingLoad _vehicle;

	_heliDriver disableAI "FSM";
	_heliDriver disableAI "TARGET";
	_heliDriver disableAI "AUTOTARGET";
	_heliGrp setBehaviour "AWARE";
	_heliGrp setCombatMode "RED";
	_heliGrp setSpeedMode "NORMAL";

	_lz = [0,0,0];
	{
		_distanceToLz = _x distance _pos;
		_shortestDistance = _lz distance _pos;
		if (_distanceToLz < _shortestDistance) then { _x = _lz };
	} count landingArray;
	_heliDriver move _lz;
	_heli flyInHeight 50;
	_heli lock 3;

	if (isMultiplayer) then {
	{
		_x addMPEventHandler ["MPKilled", {_this spawn KOL_fnc_onUnitKilled}];
	}  forEach units _heliGrp;
	{
		_x addMPEventHandler ["MPKilled", {_this spawn KOL_fnc_onUnitKilled}];
	}  forEach units _grp;
	_heli addMPEventHandler ["MPKilled", {_this spawn KOL_fnc_onUnitKilled}];
	_vehicle addMPEventHandler ["MPKilled", {_this spawn KOL_fnc_onUnitKilled}];
} else {
	{
		_x addEventHandler ["Killed", {_this spawn KOL_fnc_onUnitKilled}];
	}  forEach units _heliGrp;
	{
		_x addEventHandler ["Killed", {_this spawn KOL_fnc_onUnitKilled}];
	}  forEach units _grp;
	_heli addEventHandler ["Killed", {_this spawn KOL_fnc_onUnitKilled}];
	_vehicle addEventHandler ["Killed", {_this spawn KOL_fnc_onUnitKilled}];
};

	waitUntil {(_heli distance _lz < 100)};
	_heli flyInHeight 0;
	_heli land "LAND";
	waitUntil {(isTouchingGround _vehicle)};
	{
		ropeCut [ _x, 5];
	} forEach ropes _heli;
	[(leader _grp), format["Be advised, QRF %1 is in the AO and engaging hostiles, out.", groupID _grp]] call KOL_fnc_globalSideChat;
	[(leader _grp) , "city", "ASSUALT"] execvm "scripts\UPSMON.sqf";
	_heli land "NONE";
	_heliDriver move _pos2;
	_heli flyInHeight 50;
	waitUntil {(_heli distance _pos2 < 300)};
	{
		deleteVehicle _x;
	} forEach _heliCrew;
	deleteVehicle _heli;
	deleteGroup _heliGrp;
};



