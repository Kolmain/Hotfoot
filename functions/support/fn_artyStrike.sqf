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




_busy = false;
_busy = _arty getVariable "KOL_support_busy";
if (isNil "_busy") then { 
	_arty setVariable ["KOL_support_busy", false, true]; 
	_busy = false;
};
if(!_busy || isNil "_busy") then {

	_arty setVariable ["KOL_support_busy", true, true];
	[_caller, format["%1, this is %2, adjust fire, over.", groupID (group _arty), groupID (group _caller)]] call KOL_fnc_globalSideChat;
	sleep 3.5;
	[_arty, format["%2 this is %1, adjust fire, out.", groupID (group _arty), groupID (group _caller)]] call KOL_fnc_globalSideChat;
	sleep 3.5;
	[_caller, format["Grid %1, over.", mapGridPosition _pos]] call KOL_fnc_globalSideChat;
	sleep 3;

	_isInRange = _pos inRangeOfArtillery [[_arty], currentMagazine _arty];
	if (_isInRange) then {
		[_arty, format["Grid %1, out.", mapGridPosition _pos]] call KOL_fnc_globalSideChat;
		sleep 3;
		[_caller, "Fire for effect, over."] call KOL_fnc_globalSideChat;
		sleep 3;
		[_arty, "Fire for effect, out."] call KOL_fnc_globalSideChat;
		sleep 1.5;
		[_arty, "Firing for effect, three rounds, out."] call KOL_fnc_globalSideChat;
		sleep 3.5;
		[_arty, "Shot, over."] call KOL_fnc_globalSideChat;
		//fire!
		_eta = 0;
		_arty doArtilleryFire [_pos, currentMagazine _arty, 3];
		_eta = _arty getArtilleryETA [_pos, currentMagazine _arty];
		[_caller, "Shot, out."] call KOL_fnc_globalSideChat;
		sleep 3.5;
		_arty setVariable ["KOL_support_busy", false, true];
		[_arty, format["Splash in %1 seconds, over.", _eta]] call KOL_fnc_globalSideChat;
		sleep _eta;
		[_caller, "Splash, over."] call KOL_fnc_globalSideChat;
		sleep 3.5;
		[_arty, "Splash, out."] call KOL_fnc_globalSideChat;
	} else {
		[_arty, format["%2 this is %1, specified map grid is out of range, out.", groupID (group _arty), groupID (group _caller)]] call KOL_fnc_globalSideChat;
		_newartyStrike = [_caller, "artyStrike"] call BIS_fnc_addCommMenuItem;
	};

	} else {
		[_caller, format["%1, this is %2, adjust fire, over.", groupID (group _arty), groupID (group _caller)]] call KOL_fnc_globalSideChat;
		sleep 3.5;
		[_arty, format["%2 this is %1, we are already servicing a request, out.", groupID (group _arty), groupID (group _caller)]] call KOL_fnc_globalSideChat;
		_newartyStrike = [_caller, "artyStrike"] call BIS_fnc_addCommMenuItem;

};
