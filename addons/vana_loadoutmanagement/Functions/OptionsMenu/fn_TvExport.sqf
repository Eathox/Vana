params [
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_ShowMessage", True, [True]],
	["_CopyToClipboard", True, [True]],
	"_VanaData",
	"_LoadoutData",
	"_Export"
];

if (Ismultiplayer && _ShowMessage) exitwith {["showMessage",[_ArsenalDisplay, "Data export disabled when in multiplayer"]] spawn BIS_fnc_arsenal}; //LOCALIZE

_VanaData = profilenamespace getvariable ["VANA_fnc_TreeViewSave_Data",[]];
_LoadoutData = profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]];
_Export = [_VanaData, _LoadoutData] joinstring (toString [13,10,13,10,13,10]);

if (_CopyToClipboard) then {copytoclipboard _Export};
if (_ShowMessage) then {["showMessage",[_ArsenalDisplay, localize "STR_a3_RscDisplayArsenal_message_clipboard"]] spawn BIS_fnc_arsenal};

_Export
