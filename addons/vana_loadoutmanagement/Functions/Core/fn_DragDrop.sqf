disableserialization;

params
[
  ["_CtrlTreeView", controlnull, [controlnull]],
  ["_Mode", "False", [""]],
  ["_Arguments", [], [[]]]
];

switch (toLower _Mode) do
{
  ///////////////////////////////////////////////////////////////////////////////////////////
  case "mousedown":
  {
    params ["_InAction"];

    //Clear Values
    _CtrlTreeView Setvariable ["DragDrop_InAction", nil];
    _CtrlTreeView Setvariable ["DragDrop_GetTarget", nil];
    _CtrlTreeView Setvariable ["DragDrop_TargetTv", nil];
    _CtrlTreeView Setvariable ["DragDrop_ReleaseTv", nil];

    //Tell script to get Target
    _CtrlTreeView Setvariable ["VANA_fnc_DragDrop_GetTarget", True];

    //Double check user is initiating DragDrop action
    _CtrlTreeView Setvariable ["VANA_fnc_DragDrop_InAction", "Double Check"];
    sleep 0.1;

    _InAction = _CtrlTreeView Getvariable ["VANA_fnc_DragDrop_InAction", False];
    _CtrlTreeView Setvariable ["VANA_fnc_DragDrop_InAction", ([False, True] select (_InAction isequalto "Double Check"))];

    ["mousedown", (_CtrlTreeView Getvariable ["VANA_fnc_DragDrop_InAction", False])]
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "mousemove":
  {
    params ["_Return","_GetTarget","_InAction","_CursorTab"];

    _Return = ["mousemove", false];
    _GetTarget = _CtrlTreeView Getvariable ["VANA_fnc_DragDrop_GetTarget", False];
    _InAction = _CtrlTreeView Getvariable ["VANA_fnc_DragDrop_InAction", False];
    _CursorTab = _Arguments;

    //Get Target
    if _GetTarget then
    {
      _CtrlTreeView Setvariable ["DragDrop_TargetTv", _CursorTab];
      _CtrlTreeView Setvariable ["VANA_fnc_DragDrop_GetTarget", nil];

      _Return = ["mousemove", True];
    };

    //Get Release Subtv
    if (_InAction isequalto true) then
    {
      _CtrlTreeView Setvariable ["DragDrop_ReleaseTv", _CursorTab];

      _Return = ["mousemove", True];
    };

    _Return
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "mouseup":
  {
    params ["_FncReturn","_TargetTv","_ReleaseTv"];

    _TargetTv = _CtrlTreeView Getvariable ["DragDrop_TargetTv", [-1]];
    _ReleaseTv = _CtrlTreeView Getvariable ["DragDrop_ReleaseTv", [-1]];

    //Call DragDrop function
    if !(_TargetTv isequalto [-1]) exitwith
    {
      _FncReturn = [_CtrlTreeView, "DragDropFnc", [_TargetTv, _ReleaseTv]] call VANA_fnc_DragDrop;

      ["MouseUp", _FncReturn]
    };

    ["MouseUp", False]
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "dragdropfnc":
  {
    _Arguments params
    [
      ["_TargetTv", [-1], [[]]],
      ["_ReleaseTv", [-1], [[]]],
      "_TargetTvData",
      "_TargetTvText",
      "_TargetTvValue",
      "_ReleaseTvData",
      "_TargetTvParent",
      "_ReleaseTvParent",
      "_IsParent",
      "_IsChild",
      "_HasSameParent",
      "_MovedSubtv",
      "_NewSubTVPath",
      "_TargetTvChildren",
      "_MovedSubtvGrandParent",
      "_MovedSubtvParent"
    ];

    _TargetTvData = (_CtrlTreeView tvData _TargetTv);
    _TargetTvText = (_CtrlTreeView tvText _TargetTv);
    _TargetTvValue = (_CtrlTreeView tvValue _TargetTv);

    _ReleaseTv = +_ReleaseTv;
    _ReleaseTvData = (_CtrlTreeView tvData _ReleaseTv);

    if (_ReleaseTv isequalto [-1] || _TargetTv isequalto [] || !(_TargetTv isequalto _ReleaseTv)) exitwith {False};

    _TargetTvParent = +_TargetTv;
    _TargetTvParent resize ((Count _TargetTvParent)-1);

    _ReleaseTvParent = +_ReleaseTv;
    if !(_ReleaseTv isequalto []) then
    {
      _ReleaseTvParent resize ((Count _ReleaseTvParent)-1);
    };

    _IsParent = _TargetTvParent isequalto _ReleaseTv;
    _IsChild = _ReleaseTv select [0,(count _TargetTv)] isequalto _TargetTv;
    _HasSameParent = _TargetTvParent isequalto _ReleaseTvParent;

    if (!_IsParent && !_IsChild && (_ReleaseTvData isequalto "tvtab" || !_HasSameParent)) then
    {
      if (_ReleaseTvData isequalto "tvloadout") then
      {
        _ReleaseTv resize ((Count _ReleaseTv)-1);
      };

      _CtrlTreeView tvExpand _ReleaseTv;

      _MovedSubtv = +_ReleaseTv;
      _NewSubTvPath = _CtrlTreeView tvadd [_ReleaseTv, _TargetTvText];

      _MovedSubtv pushback _NewSubTVPath;

      _CtrlTreeView tvSetData [_MovedSubtv, _TargetTvData];
      _CtrlTreeView TvSetValue [_MovedSubtv, _TargetTvValue];

      if (_TargetTvValue isequalto -1) then
      {
        _CtrlTreeView tvSetColor [_MovedSubtv,[1,1,1,0.25]];
      };

      if (_TargetTvData isequalto "tvtab") then
      {
        _CtrlTreeView tvSetPicture [_MovedSubtv , "\VANA_LoadoutManagement\UI\Data_Icons\icon_ca.paa"];
        _TargetTvChildren = [_CtrlTreeView, _TargetTv] call VANA_fnc_TreeViewGetData;
        //Form wich data is saved in is [["Name",[Position],"DataType"],["Name",[Position],"DataType"],["Name",[Position],"DataType"]] ect.
        {
          params ["_TvName","_TvPosition","_TvData","_TvNewParent"];

          _TvName = (_x select 0); //Selects "Name"
          _TvPosition = ((_x select 1) select [(count _TargetTv), (count (_x select 1) - (count _TargetTv))]); //Selects [Position] and removes _TargetTv array from the front of it
          _TvData = tolower (_x select 2); //Selects "DataType"

          _TvNewParent = +_MovedSubtv ; //Duplicates _MovedSubtv so it doesnt get redefined
          _TvNewParent append _TvPosition;
          _TvNewParent resize ((Count _TvNewParent)-1);

          if (_TvData isEqualto "tvtab") then //Checks if selected SubArray is supposed to be a Tab
          {
            [_CtrlTreeView, _TvNewParent, _TvName] call VANA_fnc_TvCreateTab; //Calls CreateTab function to create a Tab with given data
          };

          if (_TvData isEqualto "tvloadout") then //Checks if selected SubArray is supposed to be a Loadout
          {
            [_CtrlTreeView, _TvNewParent, _TvName] call VANA_fnc_TvCreateLoadout; //Calls TvCreateLoadout function to create a Loadout with given data
          };
        } foreach _TargetTvChildren; //Loops Code bassed size of Saved Data, so the code under it gets executed for every data Array
      };

      _CtrlTreeView tvDelete _TargetTv;

      if !(_TargetTvData isequalto "tvtab") then //Calculates _MovedSubtv True posistion as tvDelete might have shifted it upwards
      {
        _MovedSubtvGrandParent = +_MovedSubtv ; //Duplicates _MovedSubtv so it doesnt get redefined
        _MovedSubtvGrandParent resize (count _TargetTvParent); //resizes _MovedSubtvGrandParent to the same lenght as _TargetTvParent (So _MovedSubtvGrandParent is now the parent if the tab thats on the same layer as _TargetTvParent)

        if (_TargetTvParent isequalto _MovedSubtvGrandParent) then
        {
          private _Number = _MovedSubtv select (count _TargetTvParent);
          _MovedSubtv set [(count _TargetTvParent), (_Number - 1)]; //Shitfs the number up one
        };
      };

      _MovedSubtvParent = +_MovedSubtv; //Duplicates _MovedSubtv so it doesnt get redefined
      _MovedSubtvParent resize ((Count _MovedSubtvParent)-1); //Removes last number from aray (So this is now the parent)
      _CtrlTreeView tvSetCurSel ([_CtrlTreeView,[_TargetTvText,_MovedSubtvParent],_TargetTvData] call VANA_fnc_TvGetPosition);

      _MovedSubtv
    } else {
      False
    };
  };
};
