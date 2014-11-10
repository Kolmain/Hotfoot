_grpSide = _this select 0;
if (_grpSide == independent) then {_grpSide = RESISTANCE;};
_hardpoint = hardpoint;
_spawnPoint = [0,0,0];
_spawnVehicle = [0,0,0];
_standbyPos = [0,0,0];
_insertChopper = init_obj;
_insertPoint = [0,0,0];
_pickupPoint = [0,0,0];
_heli = init_obj;

switch (_grpSide) do {
    case west: {
		_ret = [getMarkerPos "arespawn_west", 0, "B_Heli_Light_01_F", WEST] call bis_fnc_spawnvehicle;
		_heli = _ret select 0;
		insertionChopperPlayer_west = _heli;
		_spawnPoint = getMarkerPos "arespawn_west";
		_spawnVehicle = respawnVehicle_west;
		_standbyPos = standbyPos_west;
		_insertChopper = insertionChopperPlayer_west;
		_insertPoint = insertionPoint_west;
		_pickupPoint = pickupPoint_west;
	};
    case east: {
		_ret = [ getMarkerPos "arespawn_east", 0, "O_Heli_Light_02_unarmed_F", EAST] call bis_fnc_spawnvehicle;
		_heli = _ret select 0;
		insertionChopperPlayer_east = _heli;
		_spawnPoint = getMarkerPos "arespawn_east";
		_spawnVehicle = respawnVehicle_east;
		_standbyPos = standbyPos_east;
		_insertChopper = insertionChopperPlayer_east;
		_insertPoint = insertionPoint_east;
		_pickupPoint = pickupPoint_east;
	};
	case RESISTANCE: {
		_ret = [getMarkerPos "arespawn_guerrila", 0, "I_Heli_light_03_unarmed_F", RESISTANCE] call bis_fnc_spawnvehicle;
		//_ret = [getMarkerPos "arespawn_guerrila", 0, "I_Heli_Transport_02_F", RESISTANCE] call bis_fnc_spawnvehicle;
		_heli = _ret select 0;
		insertionChopperPlayer_guerrila = _heli;
		_spawnPoint = getMarkerPos "arespawn_guerrila";
		_spawnVehicle = respawnVehicle_guerrila;
		_standbyPos = standbyPos_guerrila;
		_insertChopper = insertionChopperPlayer_guerrila;
		_insertPoint = insertionPoint_guerrila;
		_pickupPoint = pickupPoint_guerrila;
	};
};

_heliDriver = driver _heli;
_heliGrp = group _heliDriver;
_heliDriver move _pickupPoint;
_heli setVariable ["transportReady", false, true];
// _heli lock 3;

_empty = [_heli, _grpSide] spawn {
	_heli = _this select 0;
	_grpSide = _this select 1;
	waitUntil {!(canMove _heli)};
	_heli sideChat format["Mayday! Mayday! %1 going down!", groupID (group _heli)];
	_attackWP2 = (group driver _heli) addWaypoint [hardpoint, 25];
	_attackWP2 setWPPos hardpoint;
	_attackWP2 setWaypointBehaviour "AWARE";
	_attackWP2 setWaypointCombatMode "RED";
	_attackWP2 setWaypointSpeed "NORMAL";
	_attackWP2 setWaypointType "SAD";
	_attackWP2 setWaypointFormation "DIAMOND";
	if (!hotfoot_epilogue) then {
		sleep 15;
		_reset = [_grpSide] call KOL_fnc_createRespawnHeliPlayer;
	} else {

	};

};
_heli sideChat format["%1 is now servicing all small transport requests, over.", groupID (group _heli)];
while {alive _heli} do 
{	
	_heli sideChat format["%1 is heading back to FOB, over.", groupID (group _heli)];
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
	
	
	
	
	_loop = true;
	_takeOffAction = _heli addaction ["<t color='#FF0000'>Take Off</t>", { 
		(_this select 0) setVariable ["transportReady", false, true];
		(_this select 1) vehicleChat "All in, dust off!";
		sleep 2;
	}]; 
	while {_loop} do {
		_ready = true;
		_ready = _insertChopper getVariable "transportReady";
		if (! _ready) then {
			_heli sideChat format["%1 is departing in 10 seconds with loaded troops, over.", groupID (group _heli)];
			sleep 10;
			_loop = false;
		};
	};
	
	_heli removeAction _takeOffAction;
	
	if (KOL_debug) then {
		{
			//systemChat format ["%1 Assigned Cargo: %2", _heli,(name _x)];
		} forEach assignedCargo _heli;
	};
	_heli setVariable ["transportReady", false, true];
	_unitsIn = count (crew _heli);
	while {_unitsIn != 2} do
	{
		_unitsIn = count (crew _heli);
		sleep 1;
	};

	{
		_x enableAI "MOVE";
		_x allowFleeing 0;
		//_x enableAttack false;
	} forEach units _heliGrp;
	_heli vehicleChat "All in, thats it!";
	_heli land "NONE";
	_heli animateDoor ["doors", 0];
	_heli animateDoor ["door_L", 0];
	_heli animateDoor ["door_R", 0];
	_heli sideChat format["%1 is heading to AO for insertion, over.", groupID (group _heli)];
	//_heliDriver disableAI "FSM";
	//_heliDriver disableAI "TARGET";
	//_heliDriver disableAI "AUTOTARGET";
	_heliDriver move _insertPoint;
	_heliGrp setBehaviour "AWARE";
	_heliGrp setCombatMode "RED";
	_heliGrp setSpeedMode "NORMAL";
	_heli flyInHeight 50;
	waitUntil {(_heli distance _insertPoint < 150)};
	_heli sideChat format["%1 is at the insertion point, over.", groupID (group _heli)];
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
		//_x enableAttack false;
	} forEach units _heliGrp;
	_heli land "NONE";
	_heli animateDoor ["doors", 0];
	_heli animateDoor ["door_L", 0];
	_heli animateDoor ["door_R", 0];
	_heliDriver disableAI "FSM";
	_heliDriver disableAI "TARGET";
	_heliDriver disableAI "AUTOTARGET";
	_heliDriver move _pickupPoint;
	_heliGrp setBehaviour "CARELESS";
	_heliGrp setCombatMode "GREEN";
	_heliGrp setSpeedMode "NORMAL";
	_heli flyInHeight 50;
	
};


