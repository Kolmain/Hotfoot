_grpSide = _this select 0;
_va = init_obj;
switch (_grpSide) do {
    case west: {
		_va = va_west;
	};
    case east: {
		_va = va_east;
	};
	case independent: {
		_va = va_guerilla;
	};
};
//["Open",true] spawn BIS_fnc_arsenal;
doStop _va; 
_va disableAI "MOVE";  
_va disableAI "ANIM";
_va addaction ["<t color='#C2BF19'>Change Loadout</t>", { ["Open",true] call BIS_fnc_arsenal; }]; 
sleep 1;
_va switchmove "acts_StandingSpeakingUnarmed";
