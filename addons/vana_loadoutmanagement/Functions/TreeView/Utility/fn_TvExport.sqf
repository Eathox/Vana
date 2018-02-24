disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

params
[
  ["_ArsenalDisplay", displaynull, [displaynull]],
  "_VanaData",
  "_LoadoutData"
];

if ismultiplayer exitwith {["showMessage",[_ArsenalDisplay, "Data export disabled when in multiplayer"]] spawn BIS_fnc_arsenal};

_VanaData = profilenamespace getvariable ["VANA_fnc_TreeViewSave_Data",[]];
_LoadoutData = profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]];

copytoclipboard ([_VanaData, _LoadoutData] joinstring (toString [13,10,13,10,13,10]));

["showMessage",[_ArsenalDisplay, localize "STR_a3_RscDisplayArsenal_message_clipboard"]] spawn BIS_fnc_arsenal;

True
