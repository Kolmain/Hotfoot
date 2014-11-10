enableSaving [false,false];
enableTeamswitch false;
private ["_colorWest", "_colorEast"];
_colorWest = [west] call BIS_fnc_sideColor;
_colorEast = [east] call BIS_fnc_sidecolor;
if (!isDedicated) then { 
	[
		hardpoint,
		"BATTLE OF ANTHRAKIA",//spawns the text
		400,//height
		500,//radius
		10,//angle
		(random 1),//clockwise\anit-clock
		[
			["\A3\ui_f\data\map\mapcontrol\Transmitter_CA.paa", _colorEast, hardpoint,  1, 1, 0, "ANTHRAKIA", 0]
		],
		0
	] call BIS_fnc_establishingShot;
};

call compile preprocessfile "SHK_pos\shk_pos_init.sqf";
KOL_fnc_createRespawnHeli = compile preprocessfilelinenumbers "functions\respawn\fn_createRespawnHeli.sqf";
KOL_fnc_createRespawnHeliPlayer = compile preprocessfilelinenumbers "functions\respawn\fn_createRespawnHeliPlayer.sqf";
KOL_fnc_createRespawnableAiGroup = compile preprocessfilelinenumbers "functions\respawn\fn_createRespawnableAiGroup.sqf";
KOL_fnc_changePlayerLoadout = compile preprocessfilelinenumbers "functions\loadout\fn_changePlayerLoadout.sqf";
KOL_fnc_initPlayerLoadout = compile preprocessfilelinenumbers "functions\loadout\fn_initPlayerLoadout.sqf";
KOL_fnc_createAmbientEnviroment = compile preprocessfilelinenumbers "functions\gamemode\fn_createAmbientEnviroment.sqf";
KOL_fnc_initPlayer = compile preprocessfilelinenumbers "functions\gamemode\fn_initPlayer.sqf";
KOL_fnc_initHotfoot = compile preprocessfilelinenumbers "functions\gamemode\fn_initHotfoot.sqf";
KOL_fnc_printText = compile preprocessfilelinenumbers "functions\gamemode\fn_printText.sqf";
KOL_fnc_mortarStrike = compile preprocessfilelinenumbers "functions\support\fn_mortarStrike.sqf";
KOL_fnc_artyStrike = compile preprocessfilelinenumbers "functions\support\fn_artyStrike.sqf";
KOL_fnc_fixedCasStrike = compile preprocessfilelinenumbers "functions\support\fn_fixedCas.sqf";
[] call KOL_fnc_initHotfoot;

// TcB AIS Wounding System --------------------------------------------------------------------------
if (!isDedicated) then {
	TCB_AIS_PATH = "ais_injury\";
	{[_x] call compile preprocessFile (TCB_AIS_PATH+"init_ais.sqf")} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});		// execute for every playable unit
	
	//{[_x] call compile preprocessFile (TCB_AIS_PATH+"init_ais.sqf")} forEach (units group player);													// only own group - you cant help strange group members
	
	//{[_x] call compile preprocessFile (TCB_AIS_PATH+"init_ais.sqf")} forEach [p1,p2,p3,p4,p5];														// only some defined units
};
// --------------------------------------------------------------------------------------------------------------

    

	  
