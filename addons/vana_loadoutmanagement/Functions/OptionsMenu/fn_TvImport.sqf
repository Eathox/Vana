disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

params
[
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_ImportData", [], [[]]],
	["_ImportTypes", "", [""]],
	"_CtrlTreeView",
	"_CtrlCopyBackup",
	"_LayoutData",
	"_LoadoutData",
	"_Message",
	"_Layout",
	"_Loadout",
	"_Both"
];

_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
_CtrlCopyBackup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_CopyBackup;
_LayoutData = _ImportData select 0;
_LoadoutData = _ImportData select 1;

if ([_ArsenalDisplay, "Import/Wipedata", ["import", _ImportTypes]] call VANA_fnc_UIPopup) then
{
	_Message = "";
	_Layout = False;
	_Loadout = False;
	_Both = False;

	switch _ImportTypes do
	{
		case "layout": {_Message = "Layout Data Imported"; _Layout = True}; //LOCALIZE
		case "loadout": {_Message = "Loadout Data Imported"; _Loadout = True}; //LOCALIZE
		case "both": {_Message = "Both Layout and Loadout Data Imported"; _Both = True}; //LOCALIZE
	};

	["VANA_fnc_TvImport"] call bis_fnc_startloadingscreen;

	UInamespace Setvariable ["VANA_fnc_TreeViewSave_Backup", ([_ArsenalDisplay, False, cbChecked _CtrlCopyBackup] Call VANA_fnc_TvExport)];

	Tvclear _CtrlTreeView;

	if !(_Layout || _Both) then {_LayoutData = profilenamespace getvariable ["VANA_fnc_TreeViewSave_Data",[]]};
	if (_Loadout || _Both) then {profilenamespace setvariable ["bis_fnc_saveInventory_Data", _LoadoutData]};

	[_ArsenalDisplay, _LayoutData] call VANA_fnc_TvLoadData;
	["VANA_fnc_TvImport"] call bis_fnc_endloadingscreen;

	[_ArsenalDisplay] Spawn VANA_fnc_TvSaveData;

	["showMessage",[_ArsenalDisplay, _Message]] spawn BIS_fnc_arsenal;

	True
} else {
	False
};
