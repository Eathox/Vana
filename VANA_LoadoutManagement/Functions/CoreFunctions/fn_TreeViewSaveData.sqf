disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]], //Gets Treeview control
	["_ClearData", True, [True]], //Gets Optional Value if profilenamespace data should be cleared
	//Makes more private varibales but does not define em
	"_SavedData",
	"_VANAData"
];

if (isnull _CtrlTreeView) exitwith //Checks if Required value is empty
{
	diag_log text "[VANA_fnc_TreeViewSaveData]: No TreeView Control Was Given, Aborting Function.";
	False; //Returns false meaning the function dint execute
};

if _ClearData then //Checks if the variable should be cleared
{
	profilenamespace setvariable ["VANA_fnc_TreeViewSave_Data", nil]; //Clears data
	diag_log text "[VANA_fnc_TreeViewSaveData]: Profile data was cleared.";
};

diag_log text "[VANA_fnc_TreeViewSaveData]: Saving Data...";

_SavedData = (profilenamespace getvariable ["VANA_fnc_TreeViewSave_Data",[]]);
_VANAData = [_CtrlTreeView, []] call VANA_fnc_TreeViewGetData; //Gets all SubTv Data

if !(_SavedData isequalto _VANAData) then
{
	profilenamespace setvariable ["VANA_fnc_TreeViewSave_Data", _VANAData]; //Places Data in profilenamespace (File wich is sued to save values when game is closed)
	saveProfileNamespace;

	diag_log text "[VANA_fnc_TreeViewSaveData]: Data Saved.";
	True; //Returns True meaning function was successfully executed
} else {
	diag_log text "[VANA_fnc_TreeViewSaveData]: Duplicate Data, Aborting Function.";
	False; //Returns True meaning function was successfully executed
};
