_grpSide = _this select 0;
if (_grpSide == independent) then {_grpSide = RESISTANCE;};
_hardpoint = hardpoint;
_spawnPoint = [0,0,0];
_spawnVehicle = [0,0,0];
_standbyPos = [0,0,0];
_insertChopper = [0,0,0];
_insertPoint = [0,0,0];
_pickupPoint = [0,0,0];
_heli = init_obj;
_spawnPos = [0,0,0];
switch (_grpSide) do {
    case west: {
		_spawnPos = getMarkerPos "arespawn_west";
		_spawnPos = [((_spawnPos select 0) + 100), _spawnPos select 1, _spawnPos select 2];
		_ret = [_spawnPos, 0, "B_Heli_Transport_01_camo_F", WEST] call bis_fnc_spawnvehicle;
		_heli = _ret select 0;
		insertionChopper_west = _heli;
		_spawnPoint = getMarkerPos "arespawn_west";
		_spawnVehicle = respawnVehicle_west;
		_standbyPos = standbyPos_west;
		_insertChopper = insertionChopper_west;
		_insertPoint = insertionPoint_west;
		_pickupPoint = pickupPoint_west;
	};
    case east: {
		_spawnPos = getMarkerPos "arespawn_east";
		_spawnPos = [((_spawnPos select 0) + 100), _spawnPos select 1, _spawnPos select 2];
		_ret = [_spawnPos, 0, "O_Heli_Light_02_F", EAST] call bis_fnc_spawnvehicle;
		_heli = _ret select 0;
		insertionChopper_east = _heli;
		_spawnPoint = getMarkerPos "arespawn_east";
		_spawnVehicle = respawnVehicle_east;
		_standbyPos = standbyPos_east;
		_insertChopper = insertionChopper_east;
		_insertPoint = insertionPoint_east;
		_pickupPoint = pickupPoint_east;
	};
	case RESISTANCE: {
		_spawnPos = getMarkerPos "arespawn_guerrila";
		_spawnPos = [((_spawnPos select 0) + 100), _spawnPos select 1, _spawnPos select 2];
		_ret = [_spawnPos, 0, "I_Heli_light_03_F", RESISTANCE] call bis_fnc_spawnvehicle;
		//_ret = [getMarkerPos "arespawn_guerrila", 0, "I_Heli_Transport_02_F", RESISTANCE] call bis_fnc_spawnvehicle;
		_heli = _ret select 0;
		insertionChopper_guerrila = _heli;
		_spawnPoint = getMarkerPos "arespawn_guerrila";
		_spawnVehicle = respawnVehicle_guerrila;
		_standbyPos = standbyPos_guerrila;
		_insertChopper = insertionChopper_guerrila;
		_insertPoint = insertionPoint_guerrila;
		_pickupPoint = pickupPoint_guerrila;
	};
};

_heliDriver = driver _heli;
_heliGrp = group _heliDriver;
_heliDriver move _pickupPoint;
_heli setVariable ["transportReady", false, true];
_heli lock 3;

_empty = [_heli, _grpSide] spawn {
	_heli = _this select 0;
	_grpSide = _this select 1;
	waitUntil {!(canMove _heli)};
	[{ _heli sideChat format["Mayday! Mayday! %1 going down!", groupID (group _heli)] },"BIS_fnc_spawn",true] call BIS_fnc_MP;
	{
		
		unassignVehicle _x;
		//assault hard point
		if (_x == (leader (group _x))) then {
			deleteWaypoint [(group _x), all];
			_attackWP =_spawnedGrp addWaypoint [hardpoint, 25];
			_attackWP setWPPos hardpoint;
			_attackWP setWaypointBehaviour "AWARE";
			_attackWP setWaypointCombatMode "RED";
			_attackWP setWaypointSpeed "NORMAL";
			_attackWP setWaypointType "SAD";
			_attackWP setWaypointFormation "DIAMOND";
		};
	} forEach assignedCargo _heli;
	_attackWP2 = (group driver _heli) addWaypoint [hardpoint, 25];
	_attackWP2 setWPPos hardpoint;
	_attackWP2 setWaypointBehaviour "AWARE";
	_attackWP2 setWaypointCombatMode "RED";
	_attackWP2 setWaypointSpeed "NORMAL";
	_attackWP2 setWaypointType "SAD";
	_attackWP2 setWaypointFormation "DIAMOND";
	if (!hotfoot_epilogue) then {
		sleep 15;
		_reset = [_grpSide] call KOL_fnc_createRespawnHeli;
	} else {

	};

};
[{ _heli sideChat format["%1 is now servicing all transport requests, over.", groupID (group _heli)] },"BIS_fnc_spawn",true] call BIS_fnc_MP;
while {alive _heli} do 
{	
	[{ _heli sideChat format["%1 is heading back to FOB, over.", groupID (group _heli)] },"BIS_fnc_spawn",true] call BIS_fnc_MP;
	_heli animateDoor ["doors", 0];
	_heli animateDoor ["door_L", 0];
	_heli animateDoor ["door_R", 0];
	waitUntil {(_heli distance _pickupPoint < 150)};

	_heli flyInHeight 0;
	_heli land "LAND";
	waitUntil {(isTouchingGround _heli)};
	_heliDriver action ["engineOn", vehicle _heliDriver];
	_heli flyInHeight 0;
	_heli animateDoor ["door_L", 1];
	_heli animateDoor ["door_R", 1];
	_heli animateDoor ["doors", 1];
	_heli setVariable ["transportReady", true, true];
	_heliDriver action ["engineOn", vehicle _heliDriver];
	
	
	
	_unitsIn = 0;
	_loop = true;
	//_takeOffAction = _heli addaction ["Take Off", { 
	//	(_this select 0) setVariable ["transportReady", false, true];
	//}]; 
	while {_loop} do {
		_ready = _insertChopper getVariable "transportReady";
		if (count assignedCargo _heli >= 8) then {
			_heli setVariable ["transportReady", false, true];
			_loop = false;
		};
		if (!_ready) then {
			//_heli sideChat format["%1 is departing in 10 seconds with loaded troops, over.", groupID (group _heli)];
			sleep 10;
			_loop = false;
		} else {
			if (count assignedCargo _heli >= 4) then {
				//_heli sideChat format["%1 is departing in 15 seconds with loaded troops, over.", groupID (group _heli)];
				sleep 15;
				_loop = false;
			};
		};
	};
	
	//_heli removeAction _takeOffAction;
	
	_heli setVariable ["transportReady", false, true];
	while {_unitsIn < (count assignedCargo _heli)} do
	{
		{
			if (vehicle _x == _heli) then { 
				_unitsIn = _unitsIn + 1;
				_x vehicleChat "In!";
			};
		} forEach assignedCargo _heli;
		sleep 1;
	};

	{
		_x enableAI "MOVE";
		_x allowFleeing 0;
		_x enableAttack false;
	} forEach units _heliGrp;
	_heli vehicleChat "All in, thats it!";
	_heli land "NONE";
	_heli animateDoor ["doors", 0];
	_heli animateDoor ["door_L", 0];
	_heli animateDoor ["door_R", 0];
	[{ _heli sideChat format["%1 is heading to AO for insertion, over.", groupID (group _heli)] },"BIS_fnc_spawn",true] call BIS_fnc_MP;
	//_heliDriver disableAI "FSM";
	//_heliDriver disableAI "TARGET";
	//_heliDriver disableAI "AUTOTARGET";
	_heliDriver move _insertPoint;
	_heliGrp setBehaviour "AWARE";
	_heliGrp setCombatMode "RED";
	_heliGrp setSpeedMode "NORMAL";
	_heli flyInHeight 50;
	waitUntil {(_heli distance _insertPoint < 150)};
	[{ _heli sideChat format["%1 is at the insertion point, over.", groupID (group _heli)] },"BIS_fnc_spawn",true] call BIS_fnc_MP;
	_heli flyInHeight 0;
	_heli land "LAND";
	_heliDriver action ["engineOn", vehicle _heliDriver];
	waitUntil {(isTouchingGround _heli)};
	_heliDriver action ["engineOn", vehicle _heliDriver];
	_heli flyInHeight 0;
	_heli animateDoor ["door_L", 1];
	_heli animateDoor ["door_R", 1];
	_heli animateDoor ["doors", 1];
	_heli vehicleChat "This is your stop gentlemen, see you back home!";
	_unitsOut = 0;
	_assignedUnits = assignedCargo _heli;
	_heliDriver action ["engineOn", vehicle _heliDriver];
	while {_unitsOut < count _assignedUnits} do
	{
		{
			if (vehicle _x != _heli) then { 
				_unitsOut = _unitsOut + 1
			};
		} forEach _assignedUnits;
		sleep 1;
	};

	{
		_x enableAI "MOVE";
		_x allowFleeing 0;
		_x enableAttack false;
	} forEach units _heliGrp;
	_heli land "NONE";
	_heli animateDoor ["doors", 0];
	_heli animateDoor ["door_L", 0];
	_heli animateDoor ["door_R", 0];
	//_heliDriver disableAI "FSM";
	//_heliDriver disableAI "TARGET";
	//_heliDriver disableAI "AUTOTARGET";
	_heliDriver move _pickupPoint;
	_heliGrp setBehaviour "AWARE";
	_heliGrp setCombatMode "RED";
	_heliGrp setSpeedMode "NORMAL";
	_heli flyInHeight 50;
	
};


