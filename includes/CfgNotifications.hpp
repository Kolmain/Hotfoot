class CfgNotifications
{
	class Default
	{
		title = ""; // Tile displayed as text on black background. Filled by arguments.
		iconPicture = ""; // Small icon displayed in left part. Colored by "color", filled by arguments.
		iconText = ""; // Short text displayed over the icon. Colored by "color", filled by arguments.
		description = ""; // Brief description displayed as structured text. Colored by "color", filled by arguments.
		color[] = {1,1,1,1}; // Icon and text color
		duration = 5; // How many seconds will the notification be displayed
		priority = 0; // Priority; higher number = more important; tasks in queue are selected by priority
		difficulty[] = {}; // Required difficulty settings. All listed difficulties has to be enabled
	};
 
	// Examples
	class TransportAvailable
	{
		title = "TRANSPORT AVAILABLE";
		iconPicture = "\A3\Ui_f\data\IGUI\Cfg\Actions\open_door_ca.paa";
		description = "Player transport now available at the FOB.";
		priority = 1;
	};
	class TransportUnavailable
	{
		title = "TRANSPORT UNAVAILABLE";
		iconPicture = "\A3\UI_F\data\IGUI\Cfg\Actions\settimer_ca.paa";
		description = "Player transport is no longer available at the FOB.";
		priority = 1;
	};
	class PointsAdded
	{
		title = "POINTS ADDED";
		iconText = "+%2";
		description = "%1";
		color[] = {0.5,1,1,1};
		priority = 0;
		difficulty[] = {};
	};
	class PointsRemoved
	{
		title = "POINTS DEDUCTED";
		iconText = "-%2";
		description = "%1";
		color[] = {0.5,1,1,1};
		priority = 0;
		difficulty[] = {};
	};
	class Objective
	{
		title = "ASSAULT OBJECTIVE";
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIcon_ca.paa";
		description = "Defeat all enemy forces and exhaust OPFOR reinforcements at target objective.";
		priority = 1;
	};
	class Lost
	{
		title = "OBJECTIVE FAILED - RETREAT";
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
		description = "Friendly reinforcements have been depleted, fall back to the extraction LZ.";
		priority = 1;
	};
	class Won
	{
		title = "OBJECTIVE CAPTURED - ATTACK";
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
		description = "OPFOR reinforcements have been depleted, destroy OPFOR remnants.";
		priority = 1;
	};
};
