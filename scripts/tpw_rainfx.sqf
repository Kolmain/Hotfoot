/*
TPW RAINFX - rain droplet fx on the ground, player goggles and vehicle windscreens.
Version: 1.08
Author: tpw
Date: 20141113
Requires: CBA A3, tpw_core.sqf
Compatibility: SP

Disclaimer: Feel free to use and modify this code, on the proviso that you post back changes and improvements so that everyone can benefit from them, and acknowledge the original author (tpw) in any derivative works. 

To use: 
1 - Save this script into your mission directory as eg tpw_rainfx.sqf
2 - Call it with 0 = [] execvm "tpw_rainfx.sqf"; 

THIS SCRIPT WON'T RUN ON DEDICATED SERVERS
*/

if (isDedicated) exitWith {};
WaitUntil {!isNull FindDisplay 46};

//VARIABLES
tpw_rain_version = "1.08";
tpw_rain_active = true;
tpw_rain_fx = false; // are rain fx running?
tpw_rain_falling = false; // is it raining?
tpw_rain_cover = false; // is unit under cover?

//COLOURED BALL
tpw_rain_fnc_colourball = 
	{
	private ["_ball"];
	_ball = _this select 0;
	_ball setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.2,0.2,0.2,0.2,ca)"];
	};	

// SET UP ARRAY OF DROPLET OBJECTS, SO THEY DON'T HAVE TO BE SPAWNED AND REMOVED
tpw_rain_droparray = [];
for "_i" from 1 to 10 do
	{
	_rdrop = "sign_sphere10cm_F" createvehicle [0,0,0];
	if !(isMultiplayer) then 
		{
		_rdrop  setObjectTexture [0,"#(argb,8,8,3)color(0.2,0.2,0.2,0.2,ca)"];
		}
	else
		{
		[[_rdrop], "tpw_rain_fnc_colourball",false] spawn BIS_fnc_MP;
		};
	tpw_rain_droparray set [count tpw_rain_droparray, _rdrop]; 
	};

// SHOULD RAIN FX FUNCTIONS RUN?	
tpw_rain_fnc_check =
	{
	private ["_pos","_highpos"];
	while {true} do
		{
		tpw_rain_stop = false; // should raindrop functions be stopped
		_pos = eyepos player;
		_highpos = [_pos select 0,_pos select 1,(_pos select 2) + 10];
		
		// Under cover?
		if (lineintersects [_pos,_highpos]) then 
			{
			tpw_rain_cover = true;
			}
		else
			{
			tpw_rain_cover = false;
			};
			
		// Raining?
		if (rain > 0.1) then 
			{
			tpw_rain_falling = true;
			}
		else
			{
			tpw_rain_falling = false;
			};
		
		// Run ground fx functions
		if (!tpw_rain_cover && tpw_rain_falling && !tpw_rain_fx) then 
			{
			[] spawn tpw_rain_fnc_random; 
			};
			
		// Run window/goggle droplet functions
		if (tpw_rain_falling) then
			{
			[] spawn tpw_rain_fnc_raindrops; 
			};
		
		// Stop fx functions
		if (tpw_rain_cover || !tpw_rain_falling) then 
			{
			tpw_rain_stop = true; // flag to stop fx
			};
		sleep 1;	
		};
	};
	
// DISPLAY RAIN GROUND DROPLET	
tpw_rain_fnc_drop =
	{
	private ["_rpos","_rdrop"];
	_rpos = _this select 0;
	_rdrop = tpw_rain_droparray call bis_fnc_selectrandom; // pick random droplet
	_rdrop setposatl _rpos; // move it to position near player
	sleep 0.2;
	_rdrop setposatl [0,0,0]; // hide droplet
	};

// RANDOM POSTIONS FOR RAIN GROUND DROPLETS	
tpw_rain_fnc_random =
	{
	private ["_pos","_dir","_posx","_posy","_droppos"];
	while {true} do
		{
		tpw_rain_fx = true; // running flag

		if (tpw_rain_stop) exitwith // quit if stop flag has been set
			{
			tpw_rain_fx = false;
			};
		
		for "_i" from 1 to (rain * 10) do // heavier rain = more droplet fx
			{
			// random position within 5m of player
			_pos = getpos player;
			_dir = random 360;
			_dist = random 5;
			_posx = (_pos select 0) + (_dist * sin _dir);
			_posy = (_pos select 1) +  (_dist * cos _dir);
			_droppos = [_posx,_posy,0]; 
			[_droppos] spawn tpw_rain_fnc_drop; // spawn droplet
			};
		sleep  0.1;
		};
	};
	
// RAIN DROPS ON VEHICLE WINDOWS AND PLAYER GOGGLES
tpw_rain_fnc_raindrops =
	{
	private ["_int","_rainemitter","_drop","_lt","_sz","_dst"];
	if (alive player && cameraview == "internal") then 
		{
		_drop = false;
		if (
		vehicle player == player && // player on foot
		{goggles player !=""} &&  // wearing goggles
		{!tpw_rain_cover} &&  // not under cover
		{!(underwater player)} && // not underwater
		{(positionCameraToWorld [0,0,1] select 2) > ((positionCameraToWorld [0,0,0] select 2) -0.2) || speed player > 5} // either not looking down or running
		) then
			{
			_int = 0.01 / rain; // more drops if heavier rain
			_lt = 0.05; // droplet lifetime
			_sz = 0.3; // drop size
			_dst = 2; // max spawn distance
			_drop = true; // drops only if not under cover
			} else
			{
			// Player in car (not tank, boat, heli etc).
			if (vehicle player iskindof "car_f") then
				{
				_int = 0.0001 / rain; 
				_sz = rain * 0.1; // heavier rain = bigger drops 
				_dst = 5;
				if (speed player  > 10) then 
					{
					_int = _int / (speed player / 10); // more drops if moving
					};
				_lt = 0.05;
				_drop = true;
				};
			};
		// Display drops
		if (_drop) then
			{
			_rainemitter = "#particlesource" createVehicleLocal getpos player;
			_rainemitter setParticleCircle [0.0, [0, 0, 0]];
			_rainemitter setParticleRandom [0, [_dst,_dst,_dst], [0, 0, 0], 0, 0.01, [0, 0, 0, 0.1], 0, 0];
			_rainemitter setParticleParams 
			[["\A3\data_f\ParticleEffects\Universal\Refract",1,0,1],
			"",
			"Billboard", 1,_lt, [0,0,0], [0,0,0], 1, 1000, 0.000, 1.7,[_sz],[[1,1,1,1]],[0,1], 0.2, 1.2, "", "", vehicle player];
			_rainemitter setDropInterval _int;    
			_rainemitter attachto [vehicle player,[0,0,0]];
			sleep 1;
			deletevehicle _rainemitter;
			};
		};	
	};
		
// RUN IT	
[] spawn tpw_rain_fnc_check;

while {true} do
	{
	// dummy loop so script doesn't terminate
	sleep 10;
	};