_grp = _this select 0;
_gridmarkers = [];
_loop = true;
while {_loop} do {
	//if (isNull (leader _grp)) exitWith { _loop = false };
	_leader = leader _grp;
	if (!alive _leader) exitWith {_loop = false};
	_grpSide = side _leader;
    {deleteMarker _x;} forEach _gridmarkers;
    _gridmarkers = [];
	_pos = getPosATL _leader;
	_px = floor ( (_pos select 0) / 100);
	_py = floor ( (_pos select 1) / 100);
	_name = format["grid_%1_%2", _px, _py];
	//_color = format["Color%1", _grpSide];
	_color = [_grpSide, true] call BIS_fnc_sideColor;

	if ((markerShape _name) == "RECTANGLE") then {
		if ((markerColor _name) == _color) then {
			// nothing
		} else {
			_name setMarkerColor "ColorOrange"; // contested
		};
	} else {
		createMarker[_name, [_px + 50, _py + 50, 0]];
		_name setMarkerShape "RECTANGLE";
		_name setMarkerSize [100, 100];
		_name setMarkerColor _color;
		_name setMarkerAlpha 0.75;
		_gridmarkers pushBack _name;
	};
    sleep 10;
};
