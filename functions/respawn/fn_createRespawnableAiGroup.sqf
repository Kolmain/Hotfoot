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


_empty = [_grpSide, (leader _spawnedGrp)] spawn BIS_fnc_addRespawnPosition;

{
	_x addEventHandler ["MPKilled",{
		_killed = _this select 0;
		_killer = _this select 1;
		if (_killer == player) then {
		_vis = lineIntersects [eyePos player, eyePos _killed, player, _killed];
			if(!_vis) then {
			_printText = [       
				["MINION KILL (+1pt)","<t align = 'right' shadow = '1' size = '0.7'>%1</t><br/>"],       
				["",""]   
			] spawn KOL_fnc_printText;  
			};
		};
		if (KOL_debug) then {
				systemChat format ["Respawnable AI %1 Died.", (name _x)];
		};
	}]
}  forEach units _spawnedGrp; 

if (!hootfoot_intro) then {

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
		//[_x] allowGetIn true;
		//[_x] orderGetIn true;
	} forEach units _spawnedGrp;


	//wait for chopper to land at ins
	waitUntil {_insertChopper distance _insertPoint < 100};
	waitUntil {(isTouchingGround _insertChopper)};
	{
		unassignVehicle _x;
	} forEach units _spawnedGrp;
	(leader _spawnedGrp) sideChat format["This is %1, we have entered the AO! Be advised, additional friendly forces are in the AO.", groupID _spawnedGrp];

} else {
	{
	_x setPos _insertPoint;
	 } forEach units _spawnedGrp;
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
			(leader _spawnedGrp) sideChat "Man down!";
		};
	} forEach _aliveUnits;
	sleep 1;
};
(leader _spawnedGrp) sideChat format["This is %2, %1 has taken causalities and are in need of reinforcements!", groupID _spawnedGrp, (name (leader _spawnedGrp))];
if (!hotfoot_epilogue) then {
	_reset = [_grpSide] call KOL_fnc_createRespawnableAiGroup;
} else {

};
