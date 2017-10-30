disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]], //Gets Treeview control
	["_LoadoutName", "", [""]],
	["_CreateNew", True, [True]], //See if code should create an new SubTv for the saved loadout
	//Makes more private varibales but does not define em
  "_Center",
  "_NillControl",
  "_Loadouts",
	"_TargetTab",
	"_TvData",
  "_DuplicateLoadout",
	"_ReturnValue"
];

///////////////////////////////////////////////////////////////////////////////////////////
//Normal Save function (Has to be run in order to acctuly save the loadout)

_Center = (missionnamespace getvariable ["BIS_fnc_arsenal_Center",player]);

[
  _center,
  [profilenamespace,_LoadoutName],
  [
    _center getvariable ["BIS_fnc_arsenal_face",face _center],
    speaker _center,
    _center call bis_fnc_getUnitInsignia
  ]
] call bis_fnc_saveInventory;

///////////////////////////////////////////////////////////////////////////////////////////
//VANA Save Function. This only fowards save name and slectedtab to loadVirtualLoadouts (So the loadout will show up under the selected tab, this does NOT save anything)

if (isnull _CtrlTreeView) exitwith //Checks if Required value is empty
{
  diag_log text "[VANA_fnc_SaveLoadout]: No TreeView Control Was Given, Aborting Function.";
  False; //Returns false meaning the function dint execute
};

if (_LoadoutName isequalto "") exitwith {False;};

_Loadouts = [_CtrlTreeView, [], [], "tvloadout", True] call VANA_fnc_TreeViewGetData; //Gets all exsisting Loadouts data
//Form wich data is saved in is [["Name",[Position],"DataType"],["Name",[Position],"DataType"],["Name",[Position],"DataType"]] ect.
_TargetTab = tvCurSel _CtrlTreeView; //Gets Selected tab
_TvData = tolower (_CtrlTreeView tvData _TargetTab); //Gets Data assigned to sellected SubTv

_DuplicateLoadout = False;
{
  if ((_x find _LoadoutName) >= 0) exitwith //Checks if the name of the loadout exsist in SubData array if true loop is ended
  {
    _DuplicateLoadout = True;
  };
} foreach _Loadouts; //Loops code for all loadouts that exsist in the treeview

if _DuplicateLoadout exitwith //See if _DuplicateLoadout is true
{
  diag_log text format ["[VANA_fnc_SaveLoadout]: Overwriting already existing loadout: %1.", _LoadoutName];
  _LoadoutName; //Returns the loadout name
};

if (_TvData isEqualto "tvloadout") then //Checks if selected SubTv is a Loadout
{
  _TargetTab resize ((Count _TargetTab) - 1); //Removes last number from aray (So this is now the parent)
};

if (_CreateNew) then
{
	_ReturnValue = [_CtrlTreeView, _TargetTab, _LoadoutName] call VANA_fnc_ShowVirtualLoadouts; //Creates new SubTv in treeview under selectedtab
	_TargetTab =  (_ReturnValue Select 0);
};

[_TargetTab,_LoadoutName]; //Returns Path and Name of loaded loadout
