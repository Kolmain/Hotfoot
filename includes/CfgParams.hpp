class Params
{
	class b_teams
	{
		title = "BLUFOR AI Fireteams"; 
		values[] = {0,2,4,6};
		default = 2; 
	};
	class o_teams
	{
		title = "OPFOR AI Fireteams"; 
		values[] = {0,2,4,6};
		default = 4; 
	};
	class i_teams
	{
		title = "INDFOR AI Fireteams"; 
		values[] = {0,2,4,6};
		default = 4; 
	};
	class AISkill
	{
		title = "AI Skill"; // Param name visible in the list
		values[] = {0.2,0.6,1}; // Values; must be integers; has to have the same number of elements as 'texts'
		texts[] = {"Recruit","Regular","Veteran"}; // Description of each selectable item
		default = 0.6; // Default value; must be listed in 'values' array, otherwise 0 is used
	};
	class TimeHour
	{
		title = "Time of Day";
		texts[] = {"Morning","Day","Evening","Night"};
		values[] = {6,12,18,0};
		default = 12;
	};
	class weatherFog 
	{
		title = "Fog Density";
		texts[] = {"No Fog","Light Fog","Medium Fog","Heavy Fog", "Random Fog"};
		values[] = {0,1,2,3,4,5};
		// When 'texts' are missing, values will be displayed directly instead
		default = 1000;
	};
	class weatherClouds  
	{
		title = " Weather";
		texts[] = {"Clear","Partly Cloudy","Light Rain","Heavy Rain", "Random Weather"};
		values[] = {0,1,2,3,4,5};
		// When 'texts' are missing, values will be displayed directly instead
		default = 1000;
	};
	class pfatigue
	{
		title = "Player Fatigue"; 
		texts[] = {"Disabled","Enabled"};
		values[] = {0,1};
		default = 0; 
	};
	class scoreToWin
	{
		title = "Score To Win"; 
		values[] = {50, 75, 100, 150, 200, 250, 500};
		default = 0; 
	};
	class supportPointIncrement
	{
		title = "Amount of Points Between Support Grants"; 
		values[] = {3, 5, 7, 10, 15, 20};
		default = 10; 
	};
};
