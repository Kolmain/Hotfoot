private ["_s","_a","_config","_p"];

_a	= _this select 4;			// Ammo used
_p	= _this select 5;			// projectile
_s = "";						// script

_config 	= configFile >> "CfgAmmo" >> _a;

switch (_config) do {
	case: "LaserBombCore" {
		_s = "scripts\explosions\BigBomb.sqf
	};
	case: "MissleCore" {
		_s = "scripts\explosions\BigRocket.sqf
	};
	case: "RocketCore" {
		_s = "scripts\explosions\SmallRocket.sqf
	};
	case: "Default" {
		_s = "scripts\explosions\Grenade.sqf
	};
	case: "GrenadeCore" {
		_s = "scripts\explosions\Grenade.sqf
	};
	
};

[_p] execVM _s;

