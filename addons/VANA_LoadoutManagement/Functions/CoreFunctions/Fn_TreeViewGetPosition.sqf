disableserialization;

params
[
  ["_CtrlTreeView", controlnull, [controlnull]], //Gets Treeview control
  ["_Name", [], [""]], //Gets Names of Tv the position has to be found of
  ["_TvParent", [], [[]]], //When defined will only search under that Tab
  ["_TypeData", "All", [""]], //When defined will only search this type
  //Makes more private varibales but does not define em
  "_Return",
  "_AllSubTvs"
];

if (isnull _CtrlTreeView) exitwith //Checks if Required value is empty
{
	diag_log text "[VANA_fnc_TreeViewGetPosition]: No TreeView Control Was Given, Aborting Function.";
	False; //Returns false meaning the function dint execute
};

_Return = [];
_AllSubTvs = [];
_TypeData = toLower _TypeData;

if (_TvParent isequalto []) then
{
  _AllSubTvs = [_CtrlTreeView] call VANA_fnc_TreeViewGetData;
} else {
  _AllSubTvs = [_CtrlTreeView, _TvParent, [], "All", False] call VANA_fnc_TreeViewGetData;
};
//Form wich data is saved in is [["Name",[Position],"DataType"],["Name",[Position],"DataType"],["Name",[Position],"DataType"]] ect.

{
  params ["_TvName","_TvPosition","_TvData"];

  _TvName = (_x select 0); //Selects "Name"
  _TvPosition = (_x select 1); //Selects [Position]
  _TvData = tolower (_x select 2); //Selects "DataType"

  if ((_TvData isequalto _TypeData) || (_TypeData isequalto "all")) then
  {
    if (_Name isequalto _TvName) exitwith
    {
      _Return = _TvPosition;
    };
  };
} foreach _AllSubTvs;

_Return
