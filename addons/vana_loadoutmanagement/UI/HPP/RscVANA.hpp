#define true 1
#define false 0

class RscDisplayArsenal //Path to add code to allready exsisting Rsc class
{
  scriptName="fn_Vana_Init";
  scriptPath="VANAInit";
  onLoad="['onLoad',_this,'fn_Vana_Init','VANAInit'] call (uinamespace getvariable 'BIS_fnc_initDisplay')"; // calls VANA Script instead of A3
  onUnload="['onUnload',_this,'fn_Vana_Init','VANAInit'] call (uinamespace getvariable 'BIS_fnc_initDisplay')"; // calls VANA Script instead of A3
  class controls //Path to add code to allready exsisting Rsc class
  {
    #include "UI\HPP\RscTreeView.hpp"
    #include "UI\HPP\RscUIPopup.hpp"

    class VANA_Mouseblock: RscBackgroundGUI
    {
      show=false;
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
