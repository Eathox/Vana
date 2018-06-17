class RscDisplayArsenal //Path to add code to allready exsisting Rsc class
{
	scriptName="fn_Vana_Init";
	scriptPath="VANAInit";
	onLoad="['onLoad',_this,'fn_Vana_Init','VANAInit'] call (uinamespace getvariable 'BIS_fnc_initDisplay')"; // calls VANA Script instead of A3
	onUnload="['onUnload',_this,'fn_Vana_Init','VANAInit'] call (uinamespace getvariable 'BIS_fnc_initDisplay')"; // calls VANA Script instead of A3
	class controls //Path to add code to allready exsisting Rsc class
	{
		#include "RscTreeView.hpp"
		#include "RscUIPopup.hpp"
		#include "RscOptionsMenu.hpp"

		class VANA_Mouseblock: RscBackgroundGUI
		{
			show=0;
			idc=978090;
			style=16;
			x="safezoneX";
			y="safezoneY";
			w="safezoneW";
			h="safezoneH";
			colorBackground[]={0,0,0,0.35};
		};
	};
};
