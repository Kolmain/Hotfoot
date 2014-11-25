// [<oldUnit>, <killer>, <respawn>, <respawnDelay>]
_player = _this select 0;
_killer = _this select 1;
_grp = group _player;
_gcount = count units _grp;

if(not (isPlayer _killer) and side _killer == side _player) then
	{
	hint " Carefull, you've pissed off friendly AI!";
};//AI TK//working?

_camera = "camera" camCreate [(position _player select 0)-0.75, (position _player select 1)-0.75,(position _player select 2) + 0.5];
_preload = [] spawn {waitUntil{preloadCamera [4516.60,2606.42,1.73]}};
_camera cameraEffect ["internal","back"];

_camera camSetFOV 1;
_camera camSetTarget vehicle _player;
if(vehicle player != player) then {_camera camSetRelPos [0,10,1]}else{_camera camSetRelPos [0,2,1]};
	_camera camCommit 0;
waitUntil {camCommitted _camera}; // Look at player

_camera camCommand "inertia on";

sleep 2.0; // Time for death anim to play

if (not isNull vehicle _killer) then
	{
	_camera camSetTarget vehicle _killer;
	_camera camPreparePos [ getPos vehicle _killer select 0, (getPos vehicle _killer select 1) -10,getPos vehicle _killer select 2];
}else{
_camera camSetTarget vehicle _killer
};

_camera camSetFOV 0.3;
_camera camCommit 4;
waitUntil {camCommitted _camera}; // Look at killer

Sleep 3.0;

titleCut["", "BLACK out",2];

_player cameraEffect ["terminate","back"];
camUseNVG false;
camDestroy _camera;
titleCut["", "BLACK in",1];

private ["_soundvolume","_musicvolume"];

#define CONTROL (_display displayctrl _n)

disableserialization;
_player = _this select 0;
_killer = _this select 1;
if (isnull _killer) then {_killer = _player};

	_start = isnil "bis_fnc_death_start";
	if (_start) then {
		bis_fnc_death_start = [daytime,time / 3600];

		_musicvolume = musicvolume;
		_soundvolume = soundvolume; //MUF-TODO: check if this is done before sound is faded in fn_feedbackMain.fsm
//3.5 fadesound 0; //MUF-commented

sleep 2;
cutText ["","BLACK OUT",1];
sleep 1.5;
BIS_fnc_feedback_allowPP = false; //MUF-switch health PP off
(["HealthPP_black"] call bis_fnc_rscLayer) cutText ["","BLACK IN",1];//MUF-black in (remove black screen that was launched in FSM PP)

enableenddialog;
};

waituntil {!isnull (finddisplay 58)};
_display = finddisplay 58;

//--- Black fade in
_n = 1060;
CONTROL ctrlsetfade 1;
if (_start) then {

//--- Play ambient radio
setacctime 1;
0 fademusic 0;
4 fademusic 0.8;
playmusic format ['RadioAmbient%1',ceil random 1/*30*/];
_musicEH = addMusicEventHandler ["MusicStop",{_this call bis_fnc_log; [] spawn {playmusic format ['RadioAmbient%1',ceil random 1/*30*/];};}];
uinamespace setvariable ["bis_fnc_death_musicEH",_musicEH];
_display displayaddeventhandler ["unload","removeMusicEventHandler ['MusicStop',uinamespace getvariable ['bis_fnc_death_musicEH',-1]];"];

CONTROL ctrlcommit 4;
} else {
CONTROL ctrlcommit 0;
};
cuttext ["","plain"];

//--- HUD
_n = 5800;
CONTROL ctrlsettext gettext (configfile >> "cfgingameui" >> "cursor" >> "select");
CONTROL ctrlsetposition [-10,-10,safezoneH * 0.07 * 3/4,safezoneH * 0.07];
CONTROL ctrlsettextcolor [1,1,1,1];
CONTROL ctrlcommit 0;

//--- SITREP (ToDO: Localize)
_sitrep = "SITREP||";
if (name _player != "Error: No unit") then {
	_sitrep = _sitrep + "KIA: %4. %5|";
};
_sitrep = _sitrep + "TOD: %2 [%3]|LOC: %6 \ %7";
if (_killer != _player) then {
	_sitrep = _sitrep + "||ENY: %8";
	if (currentweapon _killer != "") then {
		_sitrep = _sitrep + "|ENW: %9</t>"
	};
};
_sitrep = format [
_sitrep,
1 * safezoneH,
[bis_fnc_death_start select 0,"HH:MM:SS"] call bis_fnc_timetostring,
[bis_fnc_death_start select 1,"HH:MM:SS"] call bis_fnc_timetostring,
toupper localize format ["STR_SHORT_%1",rank _player],
toupper name _player,
mapGridPosition _player,
toupper worldname,
toupper ((configfile >> "cfgvehicles" >> typeof _killer) call bis_fnc_displayname),
toupper ((configfile >> "cfgweapons" >> currentweapon _killer) call bis_fnc_displayname)

];

_n = 11000;
_bcgPos = ctrlposition CONTROL;
_n = 5858;
//CONTROL ctrlsetposition [_bcgPos select 0,safezoneY + ((_bcgPos select 0) - safezoneX) * 4/3,safezoneW - 2 * (_bcgPos select 2),safezoneH / 2];
CONTROL ctrlsetposition [(((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX),
((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY),
safezoneW - 2 * (_bcgPos select 2),
safezoneH / 2];
CONTROL ctrlcommit 0;
[CONTROL,_sitrep] spawn {
scriptname "BIS_fnc_death: SITREP";
disableserialization;
_control = _this select 0;
_sitrepArray = toarray (_this select 1);
{_sitrepArray set [_foreachindex,tostring [_x]]} foreach _sitrepArray;
_sitrep = "";
//_sitrepFormat = "<t align='left' font='EtelkaMonospaceProBold' shadow='1' size='" + str safezoneH + "'>%1</t>";
_sitrepFormat = "<t align='left' font='EtelkaMonospaceProBold' shadow='1'>%1</t>";

sleep 1;
for "_i" from 0 to (count _sitrepArray - 1) do {
	_letter = _sitrepArray select _i;
	_delay = if (_letter == "|") then {_letter = "<br />"; 1} else {0.01};
	_sitrep = _sitrep + _letter;
	_control ctrlsetstructuredtext parsetext format [_sitrepFormat,_sitrep + "_"];
//playsound ["IncomingChallenge",true];
sleep _delay;
if (isnull _control) exitwith {};
};
_control ctrlsetstructuredtext parsetext format [_sitrepFormat,_sitrep];
};


//--- Create UAV camera
_camera = "camera" camcreate position player;
_camera cameraeffect ["internal","back"];
_camera campreparefov 0.4;
_camera campreparetarget _killer;
showcinemaborder false;

//--- Set PP effects
_saturation = 0.2 + random 0.3;
_ppColor = ppEffectCreate ["ColorCorrections", 1999];
_ppColor ppEffectEnable true;
_ppColor ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [1 - _saturation, 1 - _saturation, 1 - _saturation, _saturation], [1, 1, 1, 1.0]];
_ppColor ppEffectCommit 0;

_ppGrain = ppEffectCreate ["filmGrain", 2012];
_ppGrain ppEffectEnable true;
_ppGrain ppEffectAdjust [random 0.2, 1, 1, 0, 1];
_ppGrain ppEffectCommit 0;

//--- Camera update executed every frame
bis_fnc_death_player = _player;
bis_fnc_death_killer = _killer;
bis_fnc_death_camera = _camera;
bis_fnc_death_loop = {
scriptname "BIS_fnc_death: camera";
_display = _this select 0;
_player = bis_fnc_death_player;
_killer = bis_fnc_death_killer;
_camera = bis_fnc_death_camera;

_sin = 20 * sin (time * 7);
_killerPos = [
(getposasl _killer select 0),
(getposasl _killer select 1) + (_sin),
(getposasl _killer select 2) + (_sin)
];

_dirToKiller = if (_killer == _player) then {
direction _player;
} else {
([_player,_killerPos] call bis_fnc_dirto) + _sin;
};
_pos = [
getposasl _killer,
-20,
_dirToKiller
] call bis_fnc_relpos;
_pos set [2,((_pos select 2) + 7) max (getterrainheightasl _pos + 7)];

//--- Pitch
_heightCamera = getterrainheightasl _pos;
_heightKiller = getterrainheightasl _killerPos;
_height = _heightCamera - _heightKiller;
_dis = _killerPos distance _pos;
_angle = (asin (_height/_dis));

_camera setdir _dirtokiller;
[_camera,-_angle,_sin] call bis_fnc_setpitchbank;
_camera setposasl _pos;

//--- HUD
_n = 5800;
_hudPos = (worldtoscreen position _killer);
if (count _hudPos > 0) then {
	_hudPosW = ctrlposition CONTROL select 2;
	_hudPosH = ctrlposition CONTROL select 3;
	_hudPos = [
	(_hudPos select 0) - _hudPosW / 2,
	(_hudPos select 1) - _hudPosH / 2,
	_hudPosW,
	_hudPosH
	];
	CONTROL ctrlsetposition _hudPos;
	CONTROL ctrlcommit 0;
};
};

bis_fnc_death_keydown = {
_key = _this select 1;

if (_key in (actionkeys 'nightvision') || _key < 0) then {
	bis_fnc_death_vision = bis_fnc_death_vision + 1;
	_vision = bis_fnc_death_vision % 4;
	switch (_vision) do {
	case 0: {
	camusenvg false;
	call compile 'false SetCamUseTi 0';
};
case 1: {
camusenvg true;
call compile 'false SetCamUseTi 0';
};
case 2: {
camusenvg false;
call compile 'true SetCamUseTi 0';
};
case 3: {
camusenvg false;
call compile 'true SetCamUseTi 1';
};
};
};
};
//bis_fnc_death_vision = (1 + floor random 3) % 4; //--- Random vision (not NVG)
bis_fnc_death_vision = -1;
[-1,-1] call bis_fnc_death_keydown;

_display displayaddeventhandler ["mousemoving","_this call bis_fnc_death_loop"];
_display displayaddeventhandler ["mouseholding","_this call bis_fnc_death_loop"];
_display displayaddeventhandler ["keydown","_this call bis_fnc_death_keydown"];


//--- Team Switch display opened
waituntil {isnull _display};
_displayTeamSwitch = finddisplay 632;

//--- Team Switch display closed - cleanup and restart the view
waituntil {isnull _displayTeamSwitch};

_camera cameraeffect ["terminate","back"];
camdestroy _camera;

bis_fnc_death_player = nil;
bis_fnc_death_killer = nil;
bis_fnc_death_camera = nil;
bis_fnc_death_loop = nil;

ppeffectdestroy _ppColor;
ppeffectdestroy _ppGrain;

if (!alive player) exitwith {_this call bis_fnc_death;};


//--- Resurrection!
BIS_fnc_feedback_allowPP = true;
0 fadesound _soundvolume;
0 fademusic _musicvolume;
bis_fnc_death_start = nil;