private ["_sideArray","_side","_hardpoint","_extractionVehicle","_extractionPoint","_menInAO","_exfilWP","_driver","_extractionGroup","_dis"];
sideArray = [];
if (west_active) then {
	sideArray pushBack west;
};
if (east_active) then {
	sideArray pushBack east;
};
if (indep_active) then {
	sideArray pushBack independent;
};

sideArray = sideArray - [winningSide];
publicVariable "_sideArray";
extractionsComplete = 0;
if (KOL_debug) then {
	systemChat "EPILOGUE STARTED!";
};
[[[], {
		if (!isServer && hasInterface && (side player) in sideArray) then {
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
	_extractionVehicle = init_obj;
	_extractionPoint = [];

	switch (_side) do {
	  case west: {
			_extractionVehicle = opVehicle_west;
			_extractionPoint = extract_west;
		};
	  case east: {
			_extractionVehicle = opVehicle_east;
			_extractionPoint = extract_east;
		};
		case RESISTANCE: {
			_extractionVehicle = opVehicle_guerrila;
			_extractionPoint = extract_guerrila;
		};
	};

	_menInAO = nearestObjects [hardpoint, ["Man"], 1200];
	if (count _menInAO < 1) exitwith {["No objects in array, _menInAO: %1", _menInAO] call BIS_fnc_error};
	{
		if ((side _x) == _side) then {
			while {(count (waypoints (group _x))) > 0} do {
				deleteWaypoint ((waypoints (group _x)) select 0);
			};
			_exfilWP = (group _x) addWaypoint [(getPos _extractionVehicle), 25, 0];
			_exfilWP setWPPos (getPos _extractionVehicle);
			_exfilWP setWaypointBehaviour "AWARE";
			_exfilWP setWaypointCombatMode "RED";
			_exfilWP setWaypointSpeed "FAST";
			_exfilWP setWaypointType "MOVE";
			_exfilWP setWaypointFormation "DIAMOND";
		};
	} forEach _menInAO;

	_driver = driver _extractionVehicle;
	_extractionGroup = group _extractionVehicle;
	{
			_x disableAI "MOVE";
			_x allowFleeing 0;
			_x enableAttack false;
		} forEach units _extractionGroup;
	sleep 20;

	[_extractionVehicle, format["All units be advised, %1 is awaiting extraction at the Obeservation Post, out.", groupID _extractionGroup]] call KOL_fnc_globalSideChat;
	sleep 2;


		{
			if ((side _x) == _side) then {
				_x assignAsCargo _extractionVehicle;
			};
		} forEach _menInAO;
		sleep 20;

		{
			_x enableAI "MOVE";
			_x allowFleeing 0;
			_x enableAttack false;
		} forEach units _extractionGroup;



		[_driver, format["%1 is RTB, out.", groupID (group _driver)]] call KOL_fnc_globalSideChat;
		_driver disableAI "FSM";
		_driver disableAI "TARGET";
		_driver disableAI "AUTOTARGET";
		_driver move _extractionPoint;
		_extractionGroup setBehaviour "AWARE";
		_extractionGroup setCombatMode "RED";
		_extractionGroup setSpeedMode "FULL";
		waitUntil {(_extractionVehicle distance hardpoint > 1000) || !alive _extractionVehicle || !canMove _extractionVehicle};
		extractionsComplete = extractionsComplete + 1;
} forEach sideArray;

waitUntil {extractionsComplete == 2};
	[[[], {
		if (!isServer && hasInterface && (side player) in sideArray) then {
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
