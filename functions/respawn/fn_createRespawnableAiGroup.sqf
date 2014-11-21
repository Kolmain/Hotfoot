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

[(leader _spawnedGrp), "b_inf"] spawn KOL_fnc_unitMarkers;


if (isMultiplayer) then {
	{
		_x addMPEventHandler ["MPKilled", {_this spawn KOL_fnc_onUnitKilled}]; 
	}  forEach units _spawnedGrp; 
} else {
	{
		_x addEventHandler ["Killed", {_this spawn KOL_fnc_onUnitKilled}]; 
	}  forEach units _spawnedGrp; 

};

{
	_x setPos _insertPoint;
} forEach units _spawnedGrp;

[(leader _spawnedGrp),format["All units be advised, %1 are entering the AO, out.", groupID _spawnedGrp]] call KOL_fnc_globalSideChat;
_respawnPos = [_grpSide, (leader _spawnedGrp)] spawn BIS_fnc_addRespawnPosition;

/*
//assault hard point
_attackWP =_spawnedGrp addWaypoint [_hardpoint, 25];
_attackWP setWPPos _hardpoint;
_attackWP setWaypointBehaviour "AWARE";
_attackWP setWaypointCombatMode "RED";
_attackWP setWaypointSpeed "NORMAL";
_attackWP setWaypointType "SAD";
_attackWP setWaypointFormation "DIAMOND";
*/
[(leader _spawnedGrp) , "city", "ASSUALT"] execvm "scripts\UPSMON.sqf";


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

sleep (random 30);
	
if (!hotfoot_epilogue) then {
	_reset = [_grpSide] spawn KOL_fnc_createRespawnableAiGroup;
} else {
	
};

