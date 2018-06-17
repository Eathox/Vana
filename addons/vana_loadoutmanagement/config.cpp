class CfgPatches
{
	class VANA
	{
		name = "Vana - Loadout Management";
		author = "Eathox";
		version = "0.90";
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
	VANAInit="\vana_LoadoutManagement\Functions\";
};

class cfgFunctions
{
	#include "Functions\functions.hpp"
};

#include "UI\defineDialogs.inc"
#include "UI\HPP\RscVANA.hpp"
