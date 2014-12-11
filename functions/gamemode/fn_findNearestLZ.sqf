_pos = _this select 0;
if (KOL_debug) then {systemChat "SEARCHING FOR NEAREST LZ"};
/*
_landingArray = nearestObjects [[hardpoint], ["Land_HelipadEmpty_F"], 1000];
_closest = [];
_closestdist = 100000;
{
  if (_x distance _pos < _closestdist) then {
	_closest = _x;
	_closestdist = _x distance _pos;
  };
} count _landingArray;

_closest
*/
//_object = nearestObject [_pos, "Land_HelipadEmpty_F"];
_nearObjects = nearestObjects [hardpoint, ["Man"], 1000];
_object = [_nearObjects] BIS_fnc_selectRandom;
_closest = getPos _object;
if (KOL_debug) then {player setPos _closest};

_closest