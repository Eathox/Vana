disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]], //Gets Treeview control
	["_TargetTab", [-1], [[]]], //Gets given targettab (Defualt is selected tab)
	//Makes more private varibales but does not define em
	"_TvData",
	"_TargetChildren",
	"_TargetTabParent",
	"_Name",
	"_Center"
];

if (isnull _CtrlTreeView) exitwith //Checks if Required value is empty
{
	diag_log text "[VANA_fnc_TvDeleteTab]: No TreeView Control Was Given, Aborting Function.";
	False; //Returns false meaning the function dint execute
};

if (_TargetTab isEqualto [-1]) then //Checks if defualt should be used
{
	_TargetTab = tvCurSel _CtrlTreeView; //Gets Selected tab
};

_TvData = tolower (_CtrlTreeView tvData _TargetTab); //Gets Data assigned to sellected SubTv
switch _TvData do
{
	case "tvtab":
	{
		_TargetChildren = [_CtrlTreeView, _TargetTab] call VANA_fnc_TreeViewGetData; //Form wich data is saved in is [["Name",[Position],"DataType"],["Name",[Position],"DataType"],["Name",[Position],"DataType"]] ect.
		_TargetTabParent =+ _TargetTab; //Duplicates _TargetTab so it doesnt get redefined
		_TargetTabParent resize ((Count _TargetTab) - 1); //Removes last number from aray (So this is now the parent)
		{
			params ["_TvName","_TvPosition","_TvData"];

			_TvName = (_x select 0); //Selects "Name"
			_TvPosition = (_x select 1); //Selects [Position]
			_TvData = tolower (_x select 2); //Selects "DataType"

			if (_TvData isEqualto "tvloadout") then //Checks if selected SubArray is supposed to be a Loadout
			{
				[_CtrlTreeView, _TargetTabParent, _TvName] call VANA_fnc_ShowVirtualLoadouts; //Calls ShowVirtualLoadouts function to create a Loadout with given data
			};
		} foreach _TargetChildren; //Loops Code bassed size of Saved Data, so the code under it gets executed for every data Array
		_CtrlTreeView tvDelete _TargetTab; //Deletes SelectedTab
	};
	case "tvloadout":
	{
		_Name = _CtrlTreeView TvText _TargetTab;

		_Center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		[_Center, [profilenamespace,_Name],nil,True] call BIS_fnc_saveInventory; //Runs BIS_fnc_saveInventory in delete mode

		_CtrlTreeView tvDelete _TargetTab;
	};
};
_TargetTab; //Returns Deleted Tab meaning function was successfully executed
