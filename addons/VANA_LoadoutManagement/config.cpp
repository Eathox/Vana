#include "BIS_AddonInfo.hpp"
class CfgPatches
{
  class VANA
  {
    name = "Vana - Loadout Management";
    author = "Eathox";
    version = "0.85";
    requiredVersion = 1.3;
    units[] = {};
    requiredAddons[] =
    {
    "A3_UI_F",
    "A3_Functions_F"
    };
  };
};

class CfgScriptPaths
{
	VANACoreFnc="\VANA_LoadoutManagement\Functions\CoreFunctions\";
  VANASideFnc="\VANA_LoadoutManagement\Functions\SideFunctions\";
};

class cfgFunctions
{
  #include "Functions\functions.hpp"
};

#include "UI\defineDialogs.inc"
#include "UI\HPP\RscArsenalTreeView.hpp"
