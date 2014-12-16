private ["_waitTime","_callSupport","_westUnits","_eastUnits","_indUnits","_sides","_callingSide","_caller","_support"];

_waitTime = "aiSupportTime" call BIS_fnc_getParamValue;
//_callSupport = [true, false] call BIS_fnc_selectRandom; //returns one of the variables
_callSupport = true;
_callers = [];
_sides = [west, east, resistance];
_callingSide = _sides call BIS_fnc_selectRandom;
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
	systemChat format["%1 CALLING A %2", name _caller, _support];
};
/*

sleep _waitTime;

if (!hotfoot_epilogue) then {[] spawn KOL_fnc_aiSupportHandler};
*/
