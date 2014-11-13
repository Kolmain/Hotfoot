_caller = _this select 0;
_pos = _this select 1;
_target = _this select 2;
_is3D = _this select 3;
_ID = _this select 4;
_grpSide = side _caller;
if (_grpSide == independent) then {_grpSide = RESISTANCE;};
_arty = _caller;



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

_ugv = [getPos player, 0, "B_UGV_01_rcws_F", WEST] call BIS_fnc_spawnVehicle;
createVehicleCrew (_ugv select 0);  
