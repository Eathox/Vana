disableserialization;

params
[
  ["_CtrlTreeView", controlnull, [controlnull]], //Gets Treeview control
  ["_ParentTv", [], [[]]],
  ["_CheckSubTv", True, [True]],
  //Makes more private varibales but does not define em
  "_TargetChildren"
];

if (isnull _CtrlTreeView) exitwith //Checks if Required value is empty
{
	diag_log text "[VANA_fnc_TreeViewSorting]: No TreeView Control Was Given, Aborting Function.";
	False; //Returns false meaning the function dint execute
};

if !(_ParentTv isequalto [-1]) then
{
  _TargetChildren = [_CtrlTreeView, _ParentTv, [], "tvloadout", False] call VANA_fnc_TreeViewGetData;

  {
    params ["_TvName","_TargetTv","_TvData"];

    _TvName = (_x select 0);
    _TargetTv = (_x select 1);
    _TvData = tolower (_x select 2);

    _CtrlTreeView tvsettext [_TargetTv, (Format ["!!!!!!!!!!%1",_TvName])];
  } foreach _TargetChildren;

  _CtrlTreeView tvsort [_ParentTv, True];
  _CtrlTreeView tvsort [_ParentTv, False];

  _TargetChildren = [_CtrlTreeView, _ParentTv, [], "All", False] call VANA_fnc_TreeViewGetData;

  {
    params ["_TvName","_TargetTv","_TvData"];

    _TvName = (_x select 0);
    _TargetTv = (_x select 1);
    _TvData = tolower (_x select 2);

    switch _TvData do
    {
      case "tvloadout":
      {
        _CtrlTreeView tvsettext [_TargetTv, (_TvName select [10, (Count _TvName - 10)])];
      };
      case "tvtab":
      {
        if _CheckSubTv then //Checks if SubTv's Should be checked
        {
          private _SubTvCount = _CtrlTreeView tvCount _TargetTv; //Counts the amount of subTv's under TargetTv
          if (_SubTvCount > 0) then //Checks if there are any SubTv's
          {
            [_CtrlTreeView, _TargetTv] call VANA_fnc_TreeViewSorting;
          };
        };
      };
    };
  } foreach _TargetChildren;

  True;
};
