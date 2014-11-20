_grpSide = _this select 0;

if (_grpSide == independent) then {_grpSide = RESISTANCE;};
_hardpoint = hardpoint;
_spawnPoint = [0,0,0];
_spawnVehicle = init_obj;
_standbyPos = [0,0,0];
_insertChopper = init_obj;
_insertPoint = [0,0,0];
_pickupPoint = [0,0,0];
_spawnedGrp = createGroup _grpSide;
_wentToStandby = false;
_respawnPos = [0,0];

switch (_grpSide) do {
    case west: {
		_spawnedGrp = [getMarkerPos "arespawn_west", WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam")] call BIS_fnc_spawnGroup;
		_spawnPoint = getMarkerPos "arespawn_west";
		_spawnVehicle = respawnVehicle_west;
		_standbyPos = standbyPos_west;
		_insertChopper = insertionChopper_west;
		_insertPoint = insertionPoint_west;
		_pickupPoint = pickupPoint_west;
	};
    case east: {
		_spawnedGrp = [getMarkerPos "arespawn_east", EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		_spawnPoint = getMarkerPos "arespawn_east";
		_spawnVehicle = respawnVehicle_east;
		_standbyPos = standbyPos_east;
		_insertChopper = insertionChopper_east;
		_insertPoint = insertionPoint_east;
		_pickupPoint = pickupPoint_east;
	};
	case RESISTANCE: {
		_spawnedGrp = [getMarkerPos "arespawn_guerrila", RESISTANCE, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
		_spawnPoint = getMarkerPos "arespawn_guerrila";
		_spawnVehicle = respawnVehicle_guerrila;
		_standbyPos = standbyPos_guerrila;
		_insertChopper = insertionChopper_guerrila;
		_insertPoint = insertionPoint_guerrila;
		_pickupPoint = pickupPoint_guerrila;
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
if (!hotfoot_intro) then {
	{
	_x moveInCargo _spawnVehicle;
	 unassignVehicle _x; 
	 doGetOut _x;
	 //[_x] call compile preprocessFile (TCB_AIS_PATH+"init_ais.sqf");
	 } forEach units _spawnedGrp;
	 
	_standbyWP =_spawnedGrp addWaypoint [_standbyPos, 5];
	_standbyWP setWPPos _standbyPos;
	_standbyWP setWaypointBehaviour "SAFE";
	_standbyWP setWaypointCombatMode "RED";
	_standbyWP setWaypointSpeed "NORMAL";
	_standbyWP setWaypointType "MOVE";
	_standbyWP setWaypointFormation "DIAMOND";

	_loop = true;
	_ready = false;
	while {_loop} do {
		_ready = _insertChopper getVariable "transportReady";
		_assignedCount = count (assignedCargo _insertChopper);
		if (_assignedCount >= 8) then {
		_loop = true;
		} else {
			if (_ready) then { _loop = false };
		};
	};

	//get in chopper
	deleteWaypoint _standbyWP;
	{
		_x assignAsCargo _insertChopper;
		_x moveInCargo _insertChopper;
		_rand = random 100;
		if (_rand > 65) then {
			[_x] call compile preprocessFile "ais_injury\init_ais.sqf";
		};
	} forEach units _spawnedGrp;


	//wait for chopper to land at ins
	waitUntil {_insertChopper distance _insertPoint < 100};
	waitUntil {(isTouchingGround _insertChopper)};
	{
		unassignVehicle _x;
	} forEach units _spawnedGrp;
	[(leader _spawnedGrp),format["All units be advised, %1 are entering the AO, out.", groupID _spawnedGrp]] call KOL_fnc_globalSideChat;
} else {
	{
	_x setPos _insertPoint;
	 } forEach units _spawnedGrp;
};
switch (_grpSide) do {
		case west: {
			activeGrps_west = activeGrps_west + [_spawnedGrp];
		};
		case east: {
			activeGrps_east = activeGrps_east + [_spawnedGrp];
		};
		case RESISTANCE: {
			activeGrps_guerrila = activeGrps_guerrila  + [_spawnedGrp];
		};
	};
//assault hard point
_attackWP =_spawnedGrp addWaypoint [_hardpoint, 25];
_attackWP setWPPos _hardpoint;
_attackWP setWaypointBehaviour "AWARE";
_attackWP setWaypointCombatMode "RED";
_attackWP setWaypointSpeed "NORMAL";
_attackWP setWaypointType "SAD";
_attackWP setWaypointFormation "DIAMOND";


_aliveUnits = units _spawnedGrp;
while {count _aliveUnits > 2} do
{
	{ 
		if (!alive _x) then { 
			_aliveUnits = _aliveUnits - [_x];
			//[{ (leader _spawnedGrp) sideChat "Man down!" },"BIS_fnc_spawn",true] call BIS_fnc_MP;
			_respawnPos call BIS_fnc_removeRespawnPosition;
			_respawnPos = [_grpSide, (leader _spawnedGrp)] spawn BIS_fnc_addRespawnPosition;
			
		};
	} forEach _aliveUnits;
	sleep 1;
};

[(leader _spawnedGrp), format["This is %2, %1 has taken causalities and are in need of reinforcements!", groupID _spawnedGrp, (name (leader _spawnedGrp))]] call KOL_fnc_globalSideChat;

	switch (_grpSide) do {
		case west: {
			activeGrps_west = activeGrps_west - [_spawnedGrp];
		};
		case east: {
			activeGrps_east = activeGrps_east - [_spawnedGrp];
		};
		case RESISTANCE: {
			activeGrps_guerrila = activeGrps_guerrila  - [_spawnedGrp];
		};
	};
	
if (!hotfoot_epilogue) then {
	_reset = [_grpSide] spawn KOL_fnc_createRespawnableAiGroup;
} else {
	
};
