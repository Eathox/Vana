disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

params
[
  ["_ArsenalDisplay", displaynull, [displaynull]],
  "_Import",
  "_WarningMessage",
  "_VanaDataString",
  "_VanaData",
  "_VanaDataSubArray",
  "_Phase",
  "_IsNumberString",
  "_LoadoutDataString",
  "_CtrlTreeView"
];

if ismultiplayer exitwith {["showMessage",[_ArsenalDisplay, "Data import disabled when in multiplayer"]] spawn BIS_fnc_arsenal};

_Import = copyFromClipboard splitString (toString [13,10]) + "|";
_WarningMessage =
{
  ["showMessage",[_ArsenalDisplay, "Import abborted (corrupted/invalid Data)"]] spawn BIS_fnc_arsenal;
  false
};

_VanaDataString = (_Import select 0) splitString ",""[]";
_VanaData = [];
_VanaDataSubArray = ["",[]];
_Phase = 0;

_IsNumberString =
{
  params ["_SingleChars","_CountNumbers"];
  _SingleChars = _this splitstring "";

  _CountNumbers = {if (_x in ["0","1","2","3","4","5","6","7","8","9"]) then {true}} count _SingleChars;
  ([False, True] select (count _SingleChars isequalto _CountNumbers))
};

//Reconstruction of VanaData so its not in string form
{
  params ["_Number","_PosistionArray"];

  switch _Phase do
  {
    case 0: {_VanaDataSubArray set [0, _x]; _Phase = 1};
    case 1:
    {
      if (_x call _IsNumberString) then {_Number = parseNumber _x} else {_Number = False};

      _PosistionArray = _VanaDataSubArray select 1;
      _PosistionArray pushback _Number;


      if !((_VanaDataString select (_Foreachindex + 1)) call _IsNumberString) then {_Phase = 2};
    };
    case 2: {_VanaDataSubArray pushback (tolower _x); _Phase = 3};
    case 3:
    {
      if (_x call _IsNumberString) then {_Number = parseNumber _x} else {_Number = False};

      _VanaDataSubArray pushback _Number;
      _VanaData pushback _VanaDataSubArray;

      _VanaDataSubArray = ["",[]];
      _Phase = 0;
    };
  };
} foreach _VanaDataString;

//Validate VanaData
if (_VanaData isequalto [] || !(_VanaData isequaltypeall [])) exitwith {call _WarningMessage};
if ({!(_x isequaltypearray ["",[],"",0] && (if (count _x > 2) then {((_x select 2) in ["tvloadout","tvtab"])} else {false}))} count _VanaData > 0) exitwith {call _WarningMessage};

if (count _Import isequalto 1) then
{
  _LoadoutDataString = _Import select 1;
  _LoadoutDataString splitString ",""";

  {
    params [""];

    switch _x do
    {
      case "": {};
    };
  } foreach _LoadoutDataString;
};

if ([_ArsenalDisplay, "Import"] call VANA_fnc_UIPopup) then
{
  _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
  Tvclear _CtrlTreeView;

  [_CtrlTreeView, _VanaData] call VANA_fnc_TvLoadData;
  [_CtrlTreeView] call VANA_fnc_TvSorting;
  //[_CtrlTreeView] Spawn VANA_fnc_TvSaveData; //WIP

  TvCollapseAll _CtrlTreeView;
  _CtrlTreeView TvExpand [];
  _CtrlTreeView tvsetcursel [0];

  ["showMessage",[_ArsenalDisplay, "Data Imported"]] spawn BIS_fnc_arsenal;
  systemchat "Completed import";
};
