private ["_pos","_landingArray","_closest","_closestdist"];

_pos = _this select 0;
if (KOL_debug) then {systemChat "SEARCHING FOR NEAREST LZ"};

_landingArray = nearestObjects [hardpoint, ["Land_HelipadEmpty_F"], 1000];
_closest = [];
_closestdist = 100000;
{
  if (_x distance _pos < _closestdist) then {
	_closest = getPos _x;
	_closestdist = _x distance _pos;
  };
} count _landingArray;
if (count _landingArray < 1) exitwith {["No objects in array, _landingArray: %1", _landingArray] call BIS_fnc_error};
if (KOL_debug) then {systemChat "FOUND NEAREST LZ"};

_closest




