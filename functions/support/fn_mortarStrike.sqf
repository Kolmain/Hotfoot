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
    _mortarGrp = mortarGrp_west;
	};
  
  case east: {
	  _mortarGrp = mortarGrp_east;
	};

	case RESISTANCE: {
	  _mortarGrp = mortarGrp_guerrila;
	};
};

_caller sideChat format["%1, this is %2, adjust fire, over.", groupID _mortarGrp, groupID (group _caller)];
sleep 2;
(leader _mortarGrp) sideChat format["%2 this is %1, adjust fire, out.", groupID _mortarGrp, groupID (group _caller)];
sleep 2;
_caller sideChat format["Grid %1, over.", mapGridPosition _pos];
sleep 3;
(leader _mortarGrp) sideChat format["Grid %1, out.", mapGridPosition _pos];
sleep 3;
_caller sideChat "Fire for effect, over.";
sleep 1.5;
(leader _mortarGrp) sideChat "Fire for effect, out.";
sleep 1.5;
(leader _mortarGrp) sideChat "Firing for effect, four rounds, out.";
sleep 2;
(leader _mortarGrp) sideChat "Shot, over.";
//fire!
{
_x doArtilleryFire [_pos, 8Rnd_82mm_Mo_shells, 2];
} forEach units _mortarGrp;

_eta = (leader _mortarGrp) getArtilleryETA [_pos, currentMagazine (leader _mortarGrp)];
sleep 2;
_caller sideChat "Shot, out.";
sleep 2;
(leader _mortarGrp) sideChat format["Splash in %1 seconds, over.", _eta];
sleep _eta;
_caller sideChat "Splash, over.";
sleep 2;
(leader _mortarGrp) sideChat "Splash, out.";

