enableSaving [false,false];
enableTeamswitch false;

hotfoot_epilogue = false;
hotfoot_intro = true;
KOL_debug = true;
landingArray = [];
winningSide = sideLogic;
points_west = 0;
points_east = 0;
points_guerrila = 0;
scoreToWin = "winScore" call BIS_fnc_getParamValue;
_hc_param = "hc_param" call BIS_fnc_getParamValue;
_west_active = "west_active" call BIS_fnc_getParamValue;
_east_active = "east_active" call BIS_fnc_getParamValue;
_indep_active = "indep_active" call BIS_fnc_getParamValue;
_weaponFX = "weaponFX" call BIS_fnc_getParamValue;
_debug = "kol_debug" call BIS_fnc_getParamValue;
HC = false;
west_active = false;
east_active = false;
indep_active = false;
if (_debug > 0) then {
	KOL_debug = true;
} else {
	KOL_debug = false;
};
if (_weaponFX > 0) then {
	weaponFX = true;
} else {
	weaponFX = false;
};
if (_hc_param > 0) then {
	HC = true;
} else {
	HC = false;
};
if (_west_active > 0) then {
	west_active = true;
} else {
	west_active = false;
};
if (_east_active > 0) then {
	east_active = true;
} else {
	east_active = false;
};
if (_indep_active > 0) then {
	indep_active = true;
} else {
	indep_active = false;
};
publicVariable "HC";
publicVariable "west_active";
publicVariable "east_active";
publicVariable "indep_active";
publicVariable "weaponFX";
TimeHour = "TimeHour" call BIS_fnc_getParamValue;
setDate [2035, 7, 4, TimeHour, 0];
_ret = [] spawn KOL_fnc_initHotfoot;
call compile preprocessFileLineNumbers "scripts\Init_UPSMON.sqf";
call compile preprocessFileLineNumbers "scripts\randomWeather2.sqf";

