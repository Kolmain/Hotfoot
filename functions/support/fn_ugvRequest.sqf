_caller = _this select 0;
_pos = _this select 1;
_target = _this select 2;
_is3D = _this select 3;
_ID = _this select 4;
_grpSide = side _caller;
if (_grpSide == independent) then {_grpSide = RESISTANCE;};
_grp = group _caller;
_ugvArray = [_caller];
_ugv = _caller;
_pos2 = [0,0,0];


switch (_grpSide) do {
    case west: {
		_pos2 = getMarkerPos "arespawn_west";
		_retArray = [_pos2, 0, "B_UGV_01_rcws_F", WEST] call BIS_fnc_spawnVehicle;
		_retArray2 = [getMarkerPos "arespawn_west", 180, "B_Heli_Transport_03_F", WEST] call bis_fnc_spawnvehicle;
		
	};
    case east: {
		_pos2 = getMarkerPos "arespawn_east";
		_retArray = [_pos2, 0, "O_UGV_01_rcws_F", WEST] call BIS_fnc_spawnVehicle;
		_retArray2 = [getMarkerPos "arespawn_east", 180, "O_Heli_Transport_04_F", EAST] call bis_fnc_spawnvehicle;
		
	};
    case RESISTANCE: {
		_pos2 = getMarkerPos "arespawn_guerrila";
		_retArray = [_pos2, 0, "I_UGV_01_rcws_F", WEST] call BIS_fnc_spawnVehicle;
		_retArray2 = [getMarkerPos "arespawn_guerrila", 180, "I_Heli_Transport_02_F", RESISTANCE] call bis_fnc_spawnvehicle;
		
	};
};
	_vehicle = _retArray select 0;
	createVehicleCrew _vehicle;
	//_crew = _retArray select 1;
	_grp = _retArray select 2;
	
	_heli = _retArray2 select 0;
	_heliCrew = _retArray2 select 1;
	_heliGrp = _retArray2 select 2;
	_heliDriver = driver _heli;
	
[_caller, format["%2, this is %1, requesting a UGV, over.", groupID (group _caller), groupID _grp]] call KOL_fnc_globalSideChat;
sleep 3;
[(leader _grp), format["%1, this is %2, copy your last. Send landing grid, over.", groupID (group _caller), groupID _grp]] call KOL_fnc_globalSideChat;
sleep 3;
[_caller, format["Grid %1, over.", mapGridPosition _pos]] call KOL_fnc_globalSideChat;
sleep 3;

_dis = _pos distance hardpoint;

if (_dis > 1200) then {

	[(leader _grp), format["%1, requested coordinates are outside of the AO, request denied, out.", groupID (group _caller), groupID _grp]] call KOL_fnc_globalSideChat;
	sleep 3;
	_newQrf = [_caller, "ugvRequest"] call BIS_fnc_addCommMenuItem;
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
	
	_attackWP =_grp addWaypoint [_hardpoint, 25];
	_attackWP setWPPos _hardpoint;
	_attackWP setWaypointBehaviour "AWARE";
	_attackWP setWaypointCombatMode "RED";
	_attackWP setWaypointSpeed "NORMAL";
	_attackWP setWaypointType "SAD";
	_attackWP setWaypointFormation "DIAMOND";
	
	_heliDriver move _pos;
	_heli flyInHeight 150;
	_heli lock 3;
if (isMultiplayer) then {
	{
		_x addMPEventHandler ["MPKilled", {_this spawn KOL_fnc_onUnitKilled}];
	}  forEach units _heliGrp; 
	_heli addMPEventHandler ["MPKilled", {_this spawn KOL_fnc_onUnitKilled}];
	_vehicle addMPEventHandler ["MPKilled", {_this spawn KOL_fnc_onUnitKilled}];
} else {
	{
		_x addEventHandler ["Killed", {_this spawn KOL_fnc_onUnitKilled}]; 
	}  forEach units _heliGrp; 
	_heli addEventHandler ["Killed", {_this spawn KOL_fnc_onUnitKilled}]; 
	_vehicle addEventHandler ["Killed", {_this spawn KOL_fnc_onUnitKilled}]; 
};
	waitUntil {(_heli distance _pos < 200)};
	_heli flyInHeight 0;
	_heli land "LAND";
	waitUntil {(isTouchingGround _vehicle)};
	{
		ropeCut [ _x, 5];
	} forEach ropes _heli;
	[(leader _grp), format["Be advised, UGV %1 is in the AO and engaging hostiles, out.", groupID _grp]] call KOL_fnc_globalSideChat;
	_heli land "NONE";
	_heliDriver move _pos2;
	_heli flyInHeight 90;
	waitUntil {(_heli distance _pos2 < 300)};
	{
		deleteVehicle _x;
	} forEach _heliCrew;
	deleteVehicle _heli;
	deleteGroup _heliGrp;
};



