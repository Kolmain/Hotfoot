
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
