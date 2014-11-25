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
			image = "\a3\ui_f\data\gui\cfg\hints\Miss_icon_ca.paa";
			noImage = false;
		};
		class revive
		{
			displayName = "Incapacitation";
			displayNameShort = "Reviving Allies";
			description = "If an infantry unit receives too much damage, they may become incapacitated before bleeding out. Once incapacitated, a friendly unit can approach the individual and select %3First Aid%4 from their action menu to begin brining the unit back to a combat effective state. Going into an incapacitated state does not count as a death. Friendly units can also %3Drag%4 and %3Carry%4 an incapacitated unit from the action menu. ";
            tip = "While incapacitated, enemies may ignore you if you lay still. However, if you attempt to move or fire your weapon, you will become an active target again.";
			arguments[] = {};
			image = "\a3\ui_f\data\gui\cfg\hints\Miss_icon_ca.paa";
			noImage = false;
		};
		class armory
		{
			displayName = "Field Armory";
			displayNameShort = "Rearming";
			description = "While at the Forward Operating Base, players have the option to modify their loadout by approaching the %3Armory Officer%4 and using their action menu to select %3Change Loadout%4. Additional equipment will become available as you accrue points during the operation.";
            tip = "As you gain points on the battlefield, special equipment will become available for your use such as UAVs and long barreled rifles.";
			arguments[] = {};
			image = "\a3\ui_f\data\gui\cfg\hints\Miss_icon_ca.paa";
			noImage = false;
		};
		class kill
		{
			displayName = "Opposing Forces";
			displayNameShort = "OPFOR";
			description = "During this mission you will have a bountiful amount of enemies. These enemies range from infantry to transport vehicles, and each will provide you with a different amount of points for a secured kill. A kill notification will be displayed if you visually witness your kill being secured. Targeting the OPFOR transportation vehicles will slow their rate of reinforcement, and skew the battle in your favor.";
            tip = "If you don't receive the kill notification, it doesn't mean you didn't necessarily secure the kill, only you did not see it!";
			arguments[] = {};
			image = "\a3\ui_f\data\gui\cfg\hints\Miss_icon_ca.paa";
			noImage = false;
		};
		class epilogue
		{
			displayName = "End of Mission";
			displayNameShort = "The Epilogue";
			description = "Once the fate of the objective has been secured, the mission will enter the epilogue. Units of the lossing faction(s) will need to make their way to the %3extraction point%4 for immediate exfiltration, while units of the winning faction(s) will attempt to %3eliminate the retreating forces%4. Successfully exfilitrating from the area of operation will result in bonus points being applied to your rank.";
            tip = "There isn't a point deduction for not making it to the extraction point, so you may choose to enact guerilla tactics to secure your own bonus points and protect your retreating comrades.";
			arguments[] = {};
			image = "\a3\ui_f\data\gui\cfg\hints\Miss_icon_ca.paa";
			noImage = false;
		};
	};
	class Support
	{
		displayName = "Support Requests";
		class artyStrike
		{
			displayName = "Artillery Support Request";
			displayNameShort = "Requesting Artillery";
			description = "Artillery is a precise strike effective against well defended targets.%1<t></t>1. Point at the target.%1<t></t>2. Press %3[0]%4 to enter the command menu.%1<t></t>3. Select %3Communications%4 - %3[8]%4.%1<t></t>4. Select %3Artillery Strike%4.%1<t></t> Artillery support will then confirm the request and report the splash. <t></t> If the coordinates that you sent are unable to be used, the supporting unit will grant you another request.";
			tip = "Make sure there are no friendly forces in the vicinity of your target. You will be held accountable for friendly fire incidents.";
			arguments[] = {};
			image = "\a3\ui_f\data\gui\cfg\hints\ArtilleryCall_ca.paa";
			noImage = false;
		};
		class mortarStrike
		{
			displayName = "Artillery Support Request";
			displayNameShort = "Requesting Artillery";
			description = "Artillery is a precise strike effective against well defended targets.%1<t></t>1. Point at the target.%1<t></t>2. Press %3[0]%4 to enter the command menu.%1<t></t>3. Select %3Communications%4 - %3[8]%4.%1<t></t>4. Select %3Artillery Strike%4.%1<t></t> Artillery support will then confirm the request and report the splash. <t></t> If the coordinates that you sent are unable to be used, the supporting unit will grant you another request.";
			tip = "Make sure there are no friendly forces in the vicinity of your target. You will be held accountable for friendly fire incidents.";
			arguments[] = {};
			image = "\a3\ui_f\data\gui\cfg\hints\ArtilleryCall_ca.paa";
			noImage = false;
		};
		class fixedCasStrike
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
		class ugvRequest
		{
			displayName = "UGV Request";
			displayNameShort = "Requesting a UGV";
			description = "An unmanned ground vehicle reduces the risk to friendly forces, while providing reinforcement and firepower to existing allied forces.%1<t></t>1. Point at the target.%1<t></t>2. Press %3[0]%4 to enter the command menu.%1<t></t>3. Select %3Communications%4 - %3[8]%4.%1<t></t>4. Select %UGV Request%4.%1<t></t> Command will then confirm the request and dispatch the UGV to the requested location. <t></t> If the coordinates that you sent are unable to be used, the supporting unit will grant you another request.";
			tip = "UGVs can sustain substantial small-arms damage, but are vulnerable to explosive attacks. Be sure to support friendly UGVs with infantry assistance.";
			arguments[] = {};
			image = "\a3\ui_f\data\gui\cfg\hints\ArtilleryCall_ca.paa";
			noImage = false;
		};
	};
};
