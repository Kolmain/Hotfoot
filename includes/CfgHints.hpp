class CfgHints
{
	class Gamemode
	{
		// Topic title (displayed only in topic listbox in Field Manual)
		displayName = "Hotfoot Gamemode";
		class respawn
		{
			displayName = "Forward Operating Base";
			displayNameShort = "FOB";
			description = "Welcome to the battlefield, %11. This is your Forward Operating Base, or FOB. This is where reinforcements arrive before being transported to the Area of Operations, as well as the location of any support units used during the battle. You also have a field armory available here to restructure your loadout.";
            tip = "You are not forced to respawn at the FOB. You may choose to respawn at another friendly fireteam position instead.";
			arguments[] = {
				"name player"
			};
			//image = "\a3\ui_f\data\gui\cfg\hints\Commanding_ca.paa";
			image = "\a3\ui_f\data\gui\cfg\hints\Miss_icon_ca.paa";
			noImage = false;
		};
	};
	class Support
	{
		displayName = "Support Requests";
		class artyRequest
		{
			displayName = "Artillery Support Request";
			displayNameShort = "Requesting Artillery";
			description = "Artillery is a precise strike effective against well defended targets.%1<t></t>1. Point at the target.%1<t></t>2. Press %3[0]%4 to enter the command menu.%1<t></t>3. Select %3Communications%4 - %3[8]%4.%1<t></t>4. Select %3Artillery Strike%4.%1<t></t> Artillery support will then confirm the request and report the splash. <t></t> If the coordinates that you sent are unable to be used, the supporting unit will grant you another request.";
			tip = "Make sure there are no friendly forces in the vicinity of your target. You will be held accountable for friendly fire incidents.";
			arguments[] = {};
			image = "\a3\ui_f\data\gui\cfg\hints\ArtilleryCall_ca.paa";
			noImage = false;
		};
		class casRequest
		{
			displayName = "CAS Request";
			displayNameShort = "Requesting CAS";
			description = "CAS is a precise strike effective against well defended targets.%1<t></t>1. Point at the target.%1<t></t>2. Press %3[0]%4 to enter the command menu.%1<t></t>3. Select %3Communications%4 - %3[8]%4.%1<t></t>4. Select %CAS Strike%4.%1<t></t> The pilot will then confirm the request and execute the order. <t></t> If the coordinates that you sent are unable to be used, the supporting unit will grant you another request.";
			tip = "Make sure there are no friendly forces in the vicinity of your target. You will be held accountable for friendly fire incidents.";
			arguments[] = {};
			image = "\a3\ui_f\data\gui\cfg\hints\ArtilleryCall_ca.paa";
			noImage = false;
		};
		class qrfRequest
		{
			displayName = "QRF Request";
			displayNameShort = "Requesting a QRF";
			description = "A quick reaction force is an easily mobilized, mechanized fire team.%1<t></t>1. Point at the target.%1<t></t>2. Press %3[0]%4 to enter the command menu.%1<t></t>3. Select %3Communications%4 - %3[8]%4.%1<t></t>4. Select %QRF Request%4.%1<t></t> Command will then confirm the request and dispatch the friendly forces to the requested location. <t></t> If the coordinates that you sent are unable to be used, the supporting unit will grant you another request.";
			tip = "These forces will not be reinforced once they are no longer combat effective, and players may not get in QRF vehicles.";
			arguments[] = {};
			image = "\a3\ui_f\data\gui\cfg\hints\ArtilleryCall_ca.paa";
			noImage = false;
		};
	};
};
