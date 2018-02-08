disableserialization;

params
[
  ["_CtrlTreeView", controlnull, [controlnull]],
  ["_ParentTv", [], [[]]],
  ["_CheckSubTv", True, [True]],
  "_TargetTvChildren",
  "_TargetTvLoadouts"
];

if (_ParentTv isequalto [-1]) exitwith {False};

//Add ! to all loadouts
_TargetTvLoadouts = [_CtrlTreeView, _ParentTv, [], "Tvloadout", False] call VANA_fnc_TvGetData;
{
  params ["_TvName","_TvPosistion","_TvData"];

  _TvName = _x select 0;
  _TvPosistion = _x select 1;
  _TvData = tolower (_x select 2);

  _CtrlTreeView tvsettext [_TvPosistion, (Format ["!!!!!!!!!!%1",_TvName])];
} foreach _TargetTvLoadouts;

//Sort treeview (All loadouts will be above)
_CtrlTreeView tvsort [_ParentTv, True];
_CtrlTreeView tvsort [_ParentTv, False];

_TargetTvChildren = [_CtrlTreeView, _ParentTv, [], "All", False] call VANA_fnc_TvGetData;
{
  params ["_TvName","_TvPosition","_TvData"];

  _TvName = _x select 0;
  _TvPosition = _x select 1;
  _TvData = tolower (_x select 2);

  switch _TvData do
  {
    case "tvloadout":
    {
      _CtrlTreeView tvsettext [_TvPosition, (_TvName select [10, (Count _TvName - 10)])];
    };
    case "tvtab":
    {
      if (_CheckSubTv && _CtrlTreeView tvCount _TvPosition > 0) then
      {
        [_CtrlTreeView, _TvPosition] call VANA_fnc_TvSorting;
      };
    };
  };
} foreach _TargetTvChildren;

True
