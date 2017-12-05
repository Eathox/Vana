disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]], //Gets Treeview control
	["_SavedVANAData", [], [[]]], //Data to be loaded, Defualt is profilenamespace getvariable ["VANA_fnc_TreeViewSave_Data",[]]
	["_ClearTreeView", False, [False]],
	["_CheckallLoadouts", True, [True]],
	//Makes more private varibales but does not define em
	"_LoadoutNames",
	"_LoadoutData",
	"_VANAData"
];

if (isnull _CtrlTreeView) exitwith //Checks if Required value is empty
{
	diag_log text "[VANA_fnc_TreeViewLoadData]: No TreeView Control Was Given, Aborting Function.";
	False; //Returns false meaning the function dint execute
};

_LoadoutNames = [];
_LoadoutData = profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]];
if (_SavedVANAData isequalto []) then	{_SavedVANAData = (profilenamespace getvariable ["VANA_fnc_TreeViewSave_Data",[]]);};
_VANAData = +_SavedVANAData; //Duplicates _SavedVANAData so it doesnt get redefined (For later math)
//Form wich data is saved in is [["Name",[Position],"DataType"],["Name",[Position],"DataType"],["Name",[Position],"DataType"]] ect.

if (_VANAData isequalto []) exitwith //Checks if Saved Data is empty
{
	diag_log text "[VANA_fnc_TreeViewLoadData]: No Saved Data to be Loaded, Aborting Function.";
	[_CtrlTreeView] call VANA_fnc_ShowVirtualLoadouts; //Calls normal Showfunction to show all player loadouts
	False; //Returns false meaning the function dint execute
};

if _ClearTreeView then
{
	TvClear _CtrlTreeView; //Clears Treeview
};

diag_log text "[VANA_fnc_TreeViewLoadData]: Loading Data...";

{
	params ["_TvName","_TvPosition","_TvData"];
	//Form wich data is saved in is [["Name",[Position],"DataType"],["Name",[Position],"DataType"],["Name",[Position],"DataType"]] ect.

	_TvName = (_x select 0); //Selects "Name"
	_TvPosition = (_x select 1); //Selects [Position]
	_TvData = tolower (_x select 2); //Selects "DataType"

	if (_TvData isEqualto "tvtab") then //Checks if selected SubArray is supposed to be a Tab
	{
		if ((Count _TvPosition) >= 1) then //Checks if postion array is bigger then 0 so [] would be false but [0] would be true
		{
			_TvPosition resize ((Count _TvPosition) - 1); //Removes last number from aray (So this is now the parent)
		};
		[_CtrlTreeView, _TvPosition, _TvName] call VANA_fnc_TvCreateTab; //Calls CreateTab function to create a Tab with given data
	};

	if (_TvData isEqualto "tvloadout") then //Checks if selected SubArray is supposed to be a Loadout
	{
		if ((Count _TvPosition) >= 1) then //Checks if postion array is bigger then 0 so [] would be false but [0] would be true
		{
			_TvPosition resize ((Count _TvPosition) - 1); //Removes last number from aray (So this is now the parent)
		};
		_LoadoutNames set [(Count _LoadoutNames), _TvName];
		[_CtrlTreeView, _TvPosition, _TvName] call VANA_fnc_ShowVirtualLoadouts; //Calls ShowVirtualLoadouts function to create a Loadout with given data
	};
} foreach _VANAData; //Loops Code bassed size of Saved Data, so the code under it gets executed for every data Array

if (_CheckallLoadouts) then
{
	{
		if ((_LoadoutNames find _x) < 0) then
		{
			[_CtrlTreeView, [], _x] call VANA_fnc_ShowVirtualLoadouts;
		};
	} foreach (_LoadoutData select {_x isequaltype ""});
};

diag_log text "[VANA_fnc_TreeViewLoadData]: Data loaded.";

//_CtrlTreeView tvSort [[],False]; //Dissables sorting for nicer visual
"DataLoad"; //Returns "DataLoad" meaning saved VANAData was loaded
