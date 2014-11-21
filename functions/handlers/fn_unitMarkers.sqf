//track squads per side
_target = _this select 0;
_markerType = _this select 1;
_name = "";
if ((side player) == (side _target)) then {
	_color = [side _target, true] call BIS_fnc_sideColor;
	_name = format["marker_%1", name _target];
	createMarkerLocal [_name, getPos _target];
	_name setMarkerShapeLocal "ICON";
	_name setMarkerColorLocal _color;

	if (isPlayer _target) then {
	  _name setMarkerTextLocal format["%1", name _target];
	  _name setMarkerTypeLocal "waypoint"; 
	} else {
	  _name setMarkerTextLocal format["%1", groupID group _target];
	  _name setMarkerTypeLocal _markerType; 
	};
};
while { alive _target } do {
  [[[_target, _name], {
		_target = _this select 0;
		_name = _this select 1;
		if ((side player) == (side _target)) then {
			_name setMarkerPosLocal getPos _target;
		 };
	}], "BIS_fnc_spawn", true] call BIS_fnc_MP; 
  sleep 10;
};

 [[[_name], { 
		(_this select 0) setMarkerTypeLocal "KIA";
		sleep 20;
		deleteMarkerLocal (_this select 0);
 }], "BIS_fnc_spawn", true] call BIS_fnc_MP; 