class CfgPatches {
	class VANA {
		name = "Vana - Loadout Management";
		author = "Eathox";
		version = "0.90";
		requiredVersion = 1.3;
		units[] = {};
		requiredAddons[] = {
			"A3_UI_F",
			"A3_Functions_F"
		};
	};
};

class cfgScriptPaths {
	VANAInit="vana_loadoutmanagement\functions\";
};

class cfgFunctions {
	#include "functions\functions.hpp"
};

#include "UI\defineDialogs.inc"
#include "UI\HPP\RscVANA.hpp"
