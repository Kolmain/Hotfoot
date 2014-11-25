class CfgCommunicationMenu
{
    class mortarStrike
    {
        text = "Mortar Support"; // Text displayed in the menu and in a notification
        submenu = ""; // Submenu opened upon activation (expression is ignored when submenu is not empty.)
        expression = "_this spawn KOL_fnc_mortarStrike;"; // Code executed upon activation
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\artillery_ca.paa"; // Icon displayed permanently next to the command menu
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa"; // Custom cursor displayed when the item is selected
        enable = "1"; // Simple expression condition for enabling the item
        removeAfterExpressionCall = 1; // 1 to remove the item after calling
    };

    class artyStrike
    {
        text = "Artillery Support"; // Text displayed in the menu and in a notification
        submenu = ""; // Submenu opened upon activation (expression is ignored when submenu is not empty.)
        expression = "_this spawn KOL_fnc_artyStrike;"; // Code executed upon activation
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\artillery_ca.paa"; // Icon displayed permanently next to the command menu
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa"; // Custom cursor displayed when the item is selected
        enable = "1"; // Simple expression condition for enabling the item
        removeAfterExpressionCall = 1; // 1 to remove the item after calling
    };
    class fixedCasStrike
    {
        text = "Close Air Support (Fixed Wing)"; // Text displayed in the menu and in a notification
        submenu = ""; // Submenu opened upon activation (expression is ignored when submenu is not empty.)
        expression = "_this spawn KOL_fnc_fixedCasStrike;"; // Code executed upon activation
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\cas_ca.paa"; // Icon displayed permanently next to the command menu
        cursor = "\A3\ui_f\data\igui\cfg\cursors\iconCursorSupport_ca.paa"; // Custom cursor displayed when the item is selected
        enable = "1"; // Simple expression condition for enabling the item
        removeAfterExpressionCall = 1; // 1 to remove the item after calling
    };

    class RotorCasStrike
    {
        text = "Close Air Support (Rotor)"; // Text displayed in the menu and in a notification
        submenu = ""; // Submenu opened upon activation (expression is ignored when submenu is not empty.)
        expression = "player setVariable ['BIS_SUPP_request', ['Artillery', _pos]];"; // Code executed upon activation
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\cas_ca.paa"; // Icon displayed permanently next to the command menu
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa"; // Custom cursor displayed when the item is selected
        enable = "1"; // Simple expression condition for enabling the item
        removeAfterExpressionCall = 1; // 1 to remove the item after calling
    };

    class qrfRequest
    {
        text = "Quick Reaction Force"; // Text displayed in the menu and in a notification
        submenu = ""; // Submenu opened upon activation (expression is ignored when submenu is not empty.)
        expression = "_this spawn KOL_fnc_qrfRequest;"; // Code executed upon activation
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\artillery_ca.paa"; // Icon displayed permanently next to the command menu
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa"; // Custom cursor displayed when the item is selected
        enable = "1"; // Simple expression condition for enabling the item
        removeAfterExpressionCall = 1; // 1 to remove the item after calling
    };
	class ugvRequest
    {
        text = "UGV Deployment"; // Text displayed in the menu and in a notification
        submenu = ""; // Submenu opened upon activation (expression is ignored when submenu is not empty.)
        expression = "_this spawn KOL_fnc_ugvRequest"; // Code executed upon activation
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\artillery_ca.paa"; // Icon displayed permanently next to the command menu
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa"; // Custom cursor displayed when the item is selected
        enable = "1"; // Simple expression condition for enabling the item
        removeAfterExpressionCall = 1; // 1 to remove the item after calling
    };

    class squadReinforcement
    {
        text = "Infantry Reinforcement"; // Text displayed in the menu and in a notification
        submenu = ""; // Submenu opened upon activation (expression is ignored when submenu is not empty.)
        expression = "_this spawn KOL_fnc_createNonrespawnableAiGroup"; // Code executed upon activation
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\artillery_ca.paa"; // Icon displayed permanently next to the command menu
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa"; // Custom cursor displayed when the item is selected
        enable = "1"; // Simple expression condition for enabling the item
        removeAfterExpressionCall = 1; // 1 to remove the item after calling
    };
};
