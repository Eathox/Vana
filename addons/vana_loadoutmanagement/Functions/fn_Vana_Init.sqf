//this sqf is called from ArsenalTreeView.hpp wich is just a moddifyed version of the normal RscDisplayArsenal in "ui_f"

params
[
	["_mode", "", [""]],
	["_params", [], [[]]],
	"_ArsenalDisplay"
];

_ArsenalDisplay = _params select 0;

switch _mode do
{
	case "onLoad":
	{
		if (isnil {missionnamespace getvariable "bis_fnc_arsenal_data"}) then
		{
			startloadingscreen [""];
			['Init',_params] spawn (uinamespace getvariable "VANA_fnc_arsenal");
		} else {
			['Init',_params] call (uinamespace getvariable "VANA_fnc_arsenal");
		};

		[_ArsenalDisplay, "Init"] call VANA_fnc_ArsenalTreeView;

		if !(_ArsenalDisplay getvariable ["Vana_Initialised", False]) exitwith {};

		[_ArsenalDisplay, "Init"] call VANA_fnc_UIPopup;
		[_ArsenalDisplay, "Init"] call VANA_fnc_OptionsMenu;
	};
	case "onUnload":
	{
		['Exit',_params] call (uinamespace getvariable "VANA_fnc_arsenal");
	};
};
