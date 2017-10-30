//Same script as vanila arma only difference is a couple of extra lines of code to initialize/deinitialize VANA ArsenalTreeView
//this sqf is called from ArsenalTreeView.hpp wich is just a moddifyed version of the normal RscDisplayArsenal.hpp in "ui_f"
_mode = _this select 0;
_params = _this select 1; //Params that include Arsenal Display IDD
_class = _this select 2;

switch _mode do
{
	case "onLoad":
	{
		if (isnil {missionnamespace getvariable "bis_fnc_arsenal_data"}) then
		{
			startloadingscreen [""];
			['Init',_params] spawn (uinamespace getvariable "BIS_fnc_arsenal");
			//--- Old way
			//[missionNamespace, "arsenalOpened", {with uinamespace do {['Init',[(_this select 0)]] call (uinamespace getvariable "VANA_fnc_ArsenalTreeView");}}] call BIS_fnc_addScriptedEventHandler; //Initialization Of VANA ArsenalTreeView Script
		} else {
			['Init',_params] call (uinamespace getvariable "BIS_fnc_arsenal");
		};
		//--- New way (WIP)
		[_params] spawn
		{
			waitUntil {!(isnil {missionnamespace getvariable "bis_fnc_arsenal_data"})};
			['Init',(_this select 0)] call (uinamespace getvariable "VANA_fnc_ArsenalTreeView"); //Initialization Of VANA ArsenalTreeView Script
		};
	};
	case "onUnload":
	{
		['Exit',_params] call (uinamespace getvariable "BIS_fnc_arsenal");
		['Exit',_params] call (uinamespace getvariable "VANA_fnc_ArsenalTreeView"); //Deinitialization Of VANA ArsenalTreeView Script
	};
};
