private ["_s","_a","_config","_caliber","_force","_length","_frequency","_maxDist","_dist","_intensity","_dBlur","_blurStrength"];

_s	= _this select 0;			// Shooting unit
_a	= _this select 4;			// Ammo used


// -------------------------------------------------------------------------------------------
// Exit Checks
if (player == _s) exitWith {};
if ((vehicle player) != player) exitWith {};
if ((player distance _s) > 60) exitWith {};
_dist		= (player distance _s);

// -------------------------------------------------------------------------------------------
// Get the caliber
_config 	= configFile >> "CfgAmmo" >> _a;
_caliber 	= getNumber (_config >> "caliber");
if (_caliber == 0) exitWith {};
_maxDist 	= 14 + (_caliber / 1.1);
// if (_dist > _maxDist) exitWith {};
_intensity = (_dist / _maxDist);
if (_intensity >= 1) exitWith {};
_intensity = 1 - _intensity;


// -------------------------------------------------------------------------------------------
// Calculate the intensity based on the caliber
_force 		= (0.4	+ (_caliber / 23)) * _intensity;
_length 	= (0.2 	+ (_caliber / 45));
_frequency	= (35 	+ (_caliber /  6)) * _intensity;	

if (_force < 0) then {_force = 0};
if (_length < 0) then {_length = 0};
if (_frequency < 0) then {_frequency = 0};


// -------------------------------------------------------------------------------------------
// Actual CamShake & blur
addCamShake [_force, _length, _frequency];

if (_caliber > 2.1) then
{
	if (_intensity > 0.6) then
	{
		_blurStrength = (0.45 + (_caliber * 0.03)) * _intensity;
		_dBlur = ppEffectCreate ["DynamicBlur", 500];
		_dBlur ppeffectenable true;
		_dBlur ppeffectadjust [_blurStrength];
		_dBlur ppeffectcommit 0;
		_dBlur ppeffectadjust [0];
		_dBlur ppeffectcommit 0.8;
		sleep 0.8;
		ppEffectDestroy _dBlur;
	};
};
