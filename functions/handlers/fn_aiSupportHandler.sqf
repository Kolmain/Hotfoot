private ["_waitTime","_callSupport","_westUnits","_eastUnits","_indUnits","_sides","_callingSide","_caller","_support"];

_waitTime = "aiSupportTime" call BIS_fnc_getParamValue;

//_callSupport = [true, false] call BIS_fnc_selectRandom; //returns one of the variables
_callSupport = true;
_westUnits = [];
_eastUnits = [];
_indUnits = [];
_sides = [];
_callingSide = sideLogic;
if (_callSupport) then {
	{
		switch (side _x) do {
			case west: {
				_westUnits pushBack _x;
			};
			case east: {
				_eastUnits pushBack _x;
			};
			case RESISTANCE: {
				_indUnits pushBack _x;
			};
		};
	} forEach AllUnits;
	_sides = [_westUnits, _eastUnits, _indUnits];
	if (count _westUnits > count _eastUnits && count _westUnits > count _indUnits) then {_sides = _sides - [_westUnits]};
	if (count _eastUnits > count _westUnits && count _eastUnits > count _indUnits) then {_sides = _sides - [_eastUnits]};
	if (count _indUnits > count _westUnits && count _indUnits > count _eastUnits) then {_sides = _sides - [_indUnits]};

	//_callingSide = _sides call BIS_fnc_selectRandom;
	{
		_callingSide = _x;
		_caller = _callingSide call BIS_fnc_selectRandom;
		_support = ["ugvRequest", "qrfRequest", "createNonrespawnableAiGroup"] call BIS_fnc_selectRandom;
		switch (_support) do {
			case "ugvRequest": {
				[_caller, (getPos _caller), "null", false, 0] spawn KOL_fnc_ugvRequest;
			};
			case "qrfRequest": {
				[_caller, (getPos _caller), "null", false, 0] spawn KOL_fnc_qrfRequest;
			};
			case "createNonrespawnableAiGroup": {
				[_caller, (getPos _caller), "null", false, 0] spawn KOL_fnc_createNonrespawnableAiGroup;
			};
		};
		if (KOL_debug) then {
			systemChat format["%1 CALLING A %2", _caller, _support];
		};
	} forEach _sides;
};


sleep _waitTime;

if (!hotfoot_epilogue) then {[] spawn KOL_fnc_aiSupportHandler};
