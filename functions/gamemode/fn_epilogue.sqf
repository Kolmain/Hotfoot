//end of match notification
//hotfoot_epilogue = true;
_sideArray = [west, east, independent];
_sideArray = _sideArray - [winningSide];
helicoptersEscaped = 0;
if (KOL_debug) then {
systemChat "EPILOGUE STARTED!";
};	
[[[], {
		_sideArray = [west, east, independent];
		_sideArray = _sideArray - [winningSide];
		if ((side player) in _sideArray) then {
			["Lost",[]] call BIS_fnc_showNotification;
		} else {
			["Won",[]] call BIS_fnc_showNotification;
		};
		sleep 3;
		[["gamemode", "epilogue"], 15, "", 35, "", true, true, true, true] call BIS_fnc_advHint; 
	}], "BIS_fnc_spawn", true] call BIS_fnc_MP;
{
	_side = _x;
	_hardpoint = hardpoint;
	_heli = init_obj;
	_grps = [0,0,0];
	_spawnPos = [0,0,0];
	_extractionPoint = [0,0,0];
	
	switch (_side) do {
	  case west: {
			_spawnPos = getMarkerPos "arespawn_west";
			_spawnPos = [((_spawnPos select 0) - 250), _spawnPos select 1, _spawnPos select 2];
			_ret = [_spawnPos, 0, "B_Heli_Transport_03_F", WEST] call bis_fnc_spawnvehicle;
			_heli = _ret select 0;
			extractionChopper_west = _heli;
			_extractionPoint = insertionPoint_west;
		};
	  case east: {
			_spawnPos = getMarkerPos "arespawn_east";
			_spawnPos = [((_spawnPos select 0) - 250), _spawnPos select 1, _spawnPos select 2];
			_ret = [_spawnPos, 0, "O_Heli_Transport_04_F", EAST] call bis_fnc_spawnvehicle;
			_heli = _ret select 0;
			extractionChopper_east = _heli;
			_extractionPoint = insertionPoint_east;
		};
		case RESISTANCE: {
			_spawnPos = getMarkerPos "arespawn_guerrila";
			_spawnPos = [((_spawnPos select 0) - 250), _spawnPos select 1, _spawnPos select 2];
			_ret = [_spawnPos, 0, "I_Heli_Transport_02_F", RESISTANCE] call bis_fnc_spawnvehicle;
			_heli = _ret select 0;
			extractionChopper_guerrila = _heli;
			_extractionPoint = insertionPoint_guerrila;
		};
	};
	
	_menInAO = nearestObjects [hardpoint, ["Man"], 1000];
	{
		if ((side _x) == _side) then {
			while {(count (waypoints (group _x))) > 0} do {
				deleteWaypoint ((waypoints (group _x)) select 0);
			};
			_exfilWP = (group _x) addWaypoint [_extractionPoint, 25, 0];
			_exfilWP setWPPos _extractionPoint;
			_exfilWP setWaypointBehaviour "AWARE";
			_exfilWP setWaypointCombatMode "RED";
			_exfilWP setWaypointSpeed "FAST";
			_exfilWP setWaypointType "MOVE";
			_exfilWP setWaypointFormation "DIAMOND";
		};
	} forEach _menInAO;
	
	_heliDriver = driver _heli;
	_heliGrp = group _heliDriver;
	sleep 20;
	_heli flyInHeight 30;
	_heliDriver move _extractionPoint;
	_heli setVariable ["exfil", false, true];

	_empty = [_heli] spawn {
		_heli = _this select 0;
		waitUntil {!(canMove _heli)};
		[_heli, format["Mayday! Mayday! %1 going down!", groupID (group _heli)]] call KOL_fnc_globalSideChat;
	};
	
	[_heli, format["All units be advised, %1 is en route to extract friendly units, out.", groupID (group _heli)]] call KOL_fnc_globalSideChat;
	sleep 2;

	waitUntil {(_heli distance _extractionPoint < 150)};

		_heli flyInHeight 0;
		_heli land "LAND";
		waitUntil {(isTouchingGround _heli)};
		_heli animateDoor ["Door_rear_source", 1];
		//get in task to all players
		_heliDriver action ["engineOn", vehicle _heliDriver];
		_heli flyInHeight 0;
		_heliDriver action ["engineOn", vehicle _heliDriver];
		[_heli, format["All units still in the AO- %1 is dusting off in 20 seconds, get in or hike it!", groupID (group _heli)]] call KOL_fnc_globalSideChat;
		{
			if ((side _x) == _side) then {
				_x assignAsCargo _heli;
			};
		} forEach _menInAO;
		sleep 20;
		
		{
			_x enableAI "MOVE";
			_x allowFleeing 0;
			_x enableAttack false;
		} forEach units _heliGrp;
		[_heli, "We are dusting off!"] call KOL_fnc_globalVehicleChat;
		_heli land "NONE";
		[_heli, format["%1 is RTB, out.", groupID (group _heli)]] call KOL_fnc_globalSideChat;
		_heliDriver disableAI "FSM";
		_heliDriver disableAI "TARGET";
		_heliDriver disableAI "AUTOTARGET";
		_heliDriver move _spawnPos;
		_heliGrp setBehaviour "AWARE";
		_heliGrp setCombatMode "RED";
		_heliGrp setSpeedMode "FULL";
		_heli flyInHeight 50;
		waitUntil {(_heli distance hardpoint > 1500) || !alive _heli || !canMove _heli};
		helicoptersEscaped = helicoptersEscaped + 1;
} forEach _sideArray;
		
waitUntil {helicoptersEscaped == 2};
	[[[], {
		_sideArray = [west, east, independent];
		_sideArray = _sideArray - [winningSide];
		if ((side player) in _sideArray) then {
			_dis = player distance hardpoint;
			if ((alive player) && (_dis > 1000)) then {
				"failed_escaped" call BIS_fnc_endMission;
			} else {
				"failed" call BIS_fnc_endMission;
			};
		} else {
			"success" call BIS_fnc_endMission;
		};
	}], "BIS_fnc_spawn", true] call BIS_fnc_MP;
