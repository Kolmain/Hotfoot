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
_mortar = _caller;



switch (_grpSide) do {
  case west: {
    _mortar = mortar_west;
	};
  
  case east: {
	  _mortar = mortar_east;
	};

	case RESISTANCE: {
	  _mortar = mortar_guerrila;
	};
};




_busy = false;
_busy = _mortar getVariable "KOL_support_busy";
if (isNil "_busy") then { 
	_mortar setVariable ["KOL_support_busy", false, true]; 
	_busy = false;
};

if(!_busy || isNil "_busy") then {
	[_caller, format["%1, this is %2, adjust fire, over.", groupID (group _mortar), groupID (group _caller)]] call KOL_fnc_globalSideChat;
	sleep 3.5;

	[_mortar, format["%2 this is %1, adjust fire, out.", groupID (group _mortar), groupID (group _caller)]] call KOL_fnc_globalSideChat;
	sleep 3.5;
	[_caller, format["Grid %1, over.", mapGridPosition _pos]] call KOL_fnc_globalSideChat;
	sleep 3;

	_isInRange = _pos inRangeOfArtillery [[_mortar], currentMagazine _mortar];
	if (_isInRange) then {
		[_mortar, format["Grid %1, out.", mapGridPosition _pos]] call KOL_fnc_globalSideChat;
		sleep 3;
		[_caller, "Fire for effect, over."] call KOL_fnc_globalSideChat;
		sleep 3;
		[_mortar, "Fire for effect, out."] call KOL_fnc_globalSideChat;
		sleep 1.5;
		[_mortar, "Firing for effect, five rounds, out."] call KOL_fnc_globalSideChat;
		sleep 3.5;
		[_mortar, "Shot, over."] call KOL_fnc_globalSideChat;
		//fire!
		_eta = 0;
		_mortar doArtilleryFire [_pos, currentMagazine _mortar, 5];
		_eta = _mortar getArtilleryETA [_pos, currentMagazine _mortar];
		[_caller, "Shot, out."] call KOL_fnc_globalSideChat;
		sleep 3.5;
		_mortar setVariable ["KOL_support_busy", false, true];
		[_mortar, format["Splash in %1 seconds, over.", _eta]] call KOL_fnc_globalSideChat;
		sleep _eta;
		[_caller, "Splash, over."] call KOL_fnc_globalSideChat;
		sleep 3.5;
		[_mortar, "Splash, out."] call KOL_fnc_globalSideChat;
	} else {
		[_mortar, format["%2 this is %1, specified map grid is out of range, out.", groupID (group _mortar), groupID (group _caller)]] call KOL_fnc_globalSideChat;
		_newMortarStrike = [_caller, "mortarStrike"] call BIS_fnc_addCommMenuItem;
	};
	
	} else {
		[_caller, format["%1, this is %2, adjust fire, over.", groupID (group _mortar), groupID (group _caller)]] call KOL_fnc_globalSideChat;
		sleep 3.5;
		[_mortar, format["%2 this is %1, we are already servicing a request, out.", groupID (group _arty), groupID (group _caller)]] call KOL_fnc_globalSideChat;
		_newMortarStrike = [_caller, "mortarStrike"] call BIS_fnc_addCommMenuItem;

};
