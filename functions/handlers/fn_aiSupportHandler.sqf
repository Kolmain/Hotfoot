private ["_callingSide","_waitTime","_sleep","_callSupport","_callers","_sides","_caller","_support"];
_callingSide = _this select 0;
if (_callingSide == independent) then {_grpSide = resistance;};
_waitTime = "aiSupportTime" call BIS_fnc_getParamValue;
_sleep = _waitTime + (random _waitTime);
//_callSupport = [true, false] call BIS_fnc_selectRandom; //returns one of the variables
_callSupport = true;
_callers = [];
//_sides = [west, east, resistance];
//_callingSide = _sides call BIS_fnc_selectRandom;
switch (_callingSide) do {
    case west: {
    	//_caller = opVehicle_west;
    	_callers pushBack opVehicle_west;
	};
    case east: {
    	//_caller = opVehicle_east;
    	_callers pushBack opVehicle_east;
	};
    case resistance: {
    	//_caller = opVehicle_guerrila;
    	_callers pushBack opVehicle_guerrila;
	};
};

{
	if ((alive _x) && (side _x == _callingSide)) then {
		_callers pushBack _x;
	};
} forEach nearestObjects [hardpoint, ["Man"], 1000];
if (count _callers <=1) exitwith {["No units in array, _callers: %1", _callers] call BIS_fnc_error};
_caller = _callers call BIS_fnc_selectRandom;
_support = ["ugvRequest", "qrfRequest", "createNonrespawnableAiGroup"] call BIS_fnc_selectRandom;
switch (_support) do {
	case "ugvRequest": {
		[_caller, (getPos _caller), "null", false, 0] spawn KOL_fnc_ugvRequest;
	};
	case "qrfRequest": {
		[_caller, (getPos _caller), "null", false, 0] spawn KOL_fnc_qrfRequest;
	};
	case "createNonrespawnableAiGroup": {
		[side _caller, (getPos _caller), "null", false, 0] spawn KOL_fnc_createNonrespawnableAiGroup;
	};
};
if (KOL_debug) then {
		systemChat format["%3: %1 CALLING A %2", name _caller, _support, side _caller];
};


sleep _sleep;

if (!hotfoot_epilogue) then {[] spawn KOL_fnc_aiSupportHandler};