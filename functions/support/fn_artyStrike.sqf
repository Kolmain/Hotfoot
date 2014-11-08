/*[caller,pos,target,is3D,ID]
caller: Object - unit which called the item, usually player
pos: Array in format Position - cursor position
target: Object - cursor target
is3D: Boolean - true when in 3D scene, false when in map
ID: String - item ID as returned by BIS_fnc_addCommMenuItem function*/

_caller = _this select 0;
_pos = _this select 1;
_target = _this select 2;
_is3D = _this select 3;
_ID = _this select 4;
_grpSide = side _caller;
if (_grpSide == independent) then {_grpSide = RESISTANCE;};



switch (_grpSide) do {
  case west: {
    _arty = arty_west;
	};
  
  case east: {
	  _arty = arty_east;
	};

	case RESISTANCE: {
	  _arty = arty_guerrila;
	};
};



_caller sideChat format["%1, this is %2, adjust fire, over.", groupID (group _arty), groupID (group _caller)];
sleep 3.5;
_arty sideChat format["%2 this is %1, adjust fire, out.", groupID (group _arty), groupID (group _caller)];
sleep 3.5;
_caller sideChat format["Grid %1, over.", mapGridPosition _pos];
sleep 3;

_isInRange = _pos inRangeOfArtillery [[_arty], currentMagazine _arty];
if (_isInRange) then {
	_arty sideChat format["Grid %1, out.", mapGridPosition _pos];
	sleep 3;
	_caller sideChat "Fire for effect, over.";
	sleep 3;
	_arty sideChat "Fire for effect, out.";
	sleep 1.5;
	_arty sideChat "Firing for effect, five rounds, out.";
	sleep 3.5;
	_arty sideChat "Shot, over.";
	//fire!
	_eta = 0;
	_arty doArtilleryFire [_pos, currentMagazine _arty, 5];
	_eta = _arty getArtilleryETA [_pos, currentMagazine _arty];
	_caller sideChat "Shot, out.";
	sleep 3.5;
	_arty sideChat format["Splash in %1 seconds, over.", _eta];
	sleep _eta;
	_caller sideChat "Splash, over.";
	sleep 3.5;
	_arty sideChat "Splash, out.";
} else {
	_arty sideChat format["%2 this is %1, specified map grid is out of range, out.", groupID (group _arty), groupID (group _caller)];
	_newartyStrike = [_caller, "artyStrike"] call BIS_fnc_addCommMenuItem;
};
