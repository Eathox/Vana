disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]], //Gets Treeview control
	["_TargetTabOriginal", [-1], [[]]], //Gets given targettab (Defualt is selected tab)
	["_TabName", []], //Gets optional Name Value
	//Makes more private varibales but does not define em
	"_TargetTab",
	"_TvData",
	"_TabCount",
	"_NewSubTvPath",
	"_AddSubTv"
];

if (isnull _CtrlTreeView) exitwith //Checks if Required value is empty
{
	diag_log text "[VANA_fnc_TvCreateTab]: No TreeView Control Was Given, Aborting Function.";
	False; //Returns false meaning the function dint execute
};

_TargetTab = +_TargetTabOriginal; //Duplicates _TargetTabOriginal so it doesnt get redefined
if (_TargetTab isEqualto [-1]) then //Checks if defualt should be used
{
	_TargetTab = tvCurSel _CtrlTreeView; //Gets Selected tab
};

_TvData = tolower (_CtrlTreeView tvData _TargetTab); //Gets Data assigned to sellected SubTv
if (!(_TargetTab isEqualto [])&&!(_TvData isEqualto "tvtab")) then //Checks if Target SubTv is not a tab and its not the Grandparent Tv
{
  _TargetTab resize ((Count _TargetTab) - 1); //Removes last number from aray (So this is now the parent)
};

_NewSubTvPath = +_TargetTab; //Duplicates _TargetTab so it doesnt get redefined

if (_TabName isEqualType "") then //Checks if _TabName has a value
{
	_AddSubTv = _CtrlTreeView tvAdd [_TargetTab, _TabName]; //Creates new SubTv and names it given name (_TabName)
	_NewSubTvPath pushback _AddSubTv; //Adds newly created Subtv array to parent array
} else {
	_TabCount = count ([_CtrlTreeView, _TargetTab, [], "tvtab", False] call VANA_fnc_TreeViewGetData); //Counts All tvtabs of Sellected SubTv
	//Form wich data is saved in is [["Name",[Position],"DataType"],["Name",[Position],"DataType"],["Name",[Position],"DataType"]] ect.
	_AddSubTv = _CtrlTreeView tvAdd [_TargetTab, (format ["New Tab%1",(_TabCount+1)])]; //Creates new SubTv and names it generic name
	_NewSubTvPath pushback _AddSubTv; //Adds newly created Subtv array to parent array
	_TabName = (_CtrlTreeView tvText _NewSubTvPath);
};

_CtrlTreeView tvSetData [_NewSubTVPath, "tvtab"]; //Set Data of new SubTv
_CtrlTreeView tvSetValue [_NewSubTVPath, -2]; //Set Data of new SubTv

//_CtrlTreeView tvSetPicture [_NewSubTVPath, getText (configfile >> "CfgDiary" >> "Icons" >> "taskFailed")];
_CtrlTreeView tvSetPicture [_NewSubTVPath, "\VANA_LoadoutManagement\UI\Data_Icons\icon_ca.paa"];

//_CtrlTreeView tvSetCurSel ([_CtrlTreeView,_TabName,_TargetTab] call VANA_fnc_TreeViewGetPosition);
_CtrlTreeView tvExpand _TargetTab; //Expands parent for nicer visuals

_NewSubTvPath; //Returns Path of created tab
