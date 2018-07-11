//this sqf is called from ArsenalTreeView.hpp wich is just a moddifyed version of the normal RscDisplayArsenal in "ui_f"

params [
	["_mode", "", [""]],
	["_params", [], [[]]]
];

switch _mode do {
	case "onLoad": {
		if (isnil {missionnamespace getvariable "bis_fnc_arsenal_data"}) then {
			startloadingscreen [""];
			['Init',_params] spawn (uinamespace getvariable "VANA_fnc_arsenal");
		} else {
			['Init',_params] call (uinamespace getvariable "VANA_fnc_arsenal");
		};
	};
	case "onUnload": {
		['Exit',_params] call (uinamespace getvariable "VANA_fnc_arsenal");
	};
};
