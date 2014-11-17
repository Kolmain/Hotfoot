class CfgDebriefing
{  
	class success
	{
		title = "Mission Completed";
		subtitle = "";
		description = "You successfully drove the opposing forces out of the area of operations.";
		pictureBackground = "";
		picture = "b_inf";
		pictureColor[] = {0.0,0.3,0.6,1};
	};
	class failed_escaped
	{
		title = "Mission Failed";
		subtitle = "You made it out alive.";
		description = "You failed to drive the opposing forces out of the area of operations, but made the extraction successfully.";
		pictureBackground = "";
		picture = "b_inf";
		pictureColor[] = {0.0,0.3,0.6,1};
	};
	class failed
	{
		title = "Mission Failed";
		subtitle = "You failed to make it out alive.";
		description = "You failed to drive the opposing forces out of the area of operations, and did not make the extraction.";
		pictureBackground = "";
		picture = "b_inf";
		pictureColor[] = {0.0,0.3,0.6,1};
	};
};
