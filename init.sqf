enableSaving [false,false];
enableTeamswitch false;

hotfoot_epilogue = false;
hotfoot_intro = true;
KOL_debug = true;
landingArray = [(getPos landingArrayStart)];
winningSide = sideLogic;
points_west = 0;
points_east = 0;
points_guerrila = 0;
scoreToWin = "winScore" call BIS_fnc_getParamValue;
TimeHour = "TimeHour" call BIS_fnc_getParamValue;
setDate [2035, 7, 4, TimeHour, 0];


call compile preprocessFileLineNumbers "scripts\Init_UPSMON.sqf";
call compile preprocessFileLineNumbers "scripts\randomWeather2.sqf";


call KOL_fnc_initHotfoot;
