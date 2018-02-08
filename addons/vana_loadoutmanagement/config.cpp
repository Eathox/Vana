class CfgPatches
{
  class VANA
  {
    name = "Vana - Loadout Management";
    author = "Eathox";
    version = "0.87";
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
  VANAButtonFnc="\VANA_LoadoutManagement\Functions\Button\";
	VANACoreFnc="\VANA_LoadoutManagement\Functions\Core\";
  VANAUtilityFnc="\VANA_LoadoutManagement\Functions\Utility\";
};

class cfgFunctions
{
  #include "Functions\functions.hpp"
};

#include "UI\defineDialogs.inc"
#include "UI\HPP\RscArsenalTreeView.hpp"
