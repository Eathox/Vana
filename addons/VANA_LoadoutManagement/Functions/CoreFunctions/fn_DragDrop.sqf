disableserialization;

params
[
  ["_CtrlTreeView", controlnull, [controlnull]], //Gets Treeview Control
  ["_CtrlTemplate", controlnull, [controlnull]], //Gets Template Control
  ["_Mode", "False", [""]], //Gets wich mode the script is supposed to run in
  ["_CursorTab", [], [[]]], //Gets Hover OverTab
  //Makes more private varibales but does not define em
  "_Return",
  "_DragDropInAction",
  "_InTemplate",
  "_ReleaseSubTvOriginal",
  "_ReleaseSubTv",
  "_TargetSubTv",
  "_TargetSubTvParent",
  "_ReleaseSubTvParent",
  "_ReleaseSubTvData",
  "_TargetSubTvData",
  "_TargetSubTvText",
  "_TargetSubTvValue",
  "_IsParent",
  "_IsSameParent",
  "_IsChild",
  "_NewSubTVPath",
  "_TargetChildren",
  "_ReleaseSubTvGrandParent"
];

_Return = ["MouseMove", False];

if ((isnull _CtrlTreeView)||(isnull _CtrlTemplate)) exitwith //Checks if Required value is empty
{
  _NillControl = "TreeView and Template";
  if ((isnull _CtrlTreeView)&&!(isnull _CtrlTemplate)) then {_NillControl = "TreeView";}; //Checks if only _CtrlTreeView is not defined
  if (!(isnull _CtrlTreeView)&&(isnull _CtrlTemplate)) then {_NillControl = "Template";}; //Checks if only _CtrlTemplateName is not defined
  diag_log text format ["[VANA_fnc_DragDrop]: No %1 Control Was Given, Aborting Function.", _NillControl];
  _Return = [_Mode, False]; //Returns mode and false
};

switch (toLower _Mode) do
{
  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "mousedown":
  {
    VANA_fnc_DragDrop_InAction = "Double Check"; //Sets VANA_fnc_DragDrop_InAction variable to false (using this as a toggle)
    VANA_fnc_DragDrop_GetTargetTab = True; //Sets VANA_fnc_GetTargetTab variable to true (using this as a toggle)
    [] spawn {sleep 0.1; if (VANA_fnc_DragDrop_InAction isequalto "Double Check") then {VANA_fnc_DragDrop_InAction = True;};};
    _Return = ["MouseDown", True]; //Returns mode and true
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "mousemove":
  {
    if (VANA_fnc_DragDrop_GetTargetTab) then
    {
      _CtrlTreeView setvariable ["DragDrop_TargetTab", _CursorTab];
      VANA_fnc_DragDrop_GetTargetTab = False; //Sets VANA_fnc_GetTargetTab variable to false (using this as a toggle)
      _Return = ["MouseMove", True]; //Returns mode and true
    };

    if !(VANA_fnc_DragDrop_InAction isequaltype "") then
    {
      if (VANA_fnc_DragDrop_InAction) then
      {
        _CtrlTreeView setvariable ["DragDrop_ReleaseSubTv", _CursorTab]; //Sets DragDrop_ReleaseSubTv variable in control of treeview to cursor its hovering over (this varibale is used in VANA_fnc_DragDrop)
        _Return = ["MouseMove", True]; //Returns mode and true
      };
    };
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "mouseup":
  {
    VANA_fnc_DragDrop_InAction = False; //Sets VANA_fnc_DragDrop_InAction variable to false (using this as a toggle)
    _InTemplate = ctrlFade _CtrlTemplate == 0;
    if (_InTemplate) then
    {
      if ((_CtrlTreeView getvariable "DragDrop_TargetTab") isequalto []) then
      {
        _Return = ["MouseUp", False]; //Returns mode, False and an other false
      } else {
        _FncReturn = [_CtrlTreeView, _CtrlTemplate, "DragDropCode"] call VANA_fnc_DragDrop;
        _Return = ["MouseUp", True, _FncReturn]; //Returns mode, true and [Moved tab and new its new position]
      };
    } else {
      _Return = ["MouseUp", False]; //Returns mode, False and an other false
    };
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "dragdropcode":
  {
    _ReleaseSubTvOriginal = _CtrlTreeView Getvariable ["DragDrop_ReleaseSubTv", nil];
    _ReleaseSubTv = +_ReleaseSubTvOriginal; //Duplicates _ReleaseSubTvOriginal so it doesnt get redefined
    _TargetSubTv = _CtrlTreeView getvariable ["DragDrop_TargetTab", nil];

    if (isnil "_ReleaseSubTv") exitwith //Checks if _ReleaseSubTv is not defined
    {
      _Return = False; //Returns false meaning the function dint execute
    };

    _CtrlTreeView setvariable ["DragDrop_TargetTab", nil];
    _CtrlTreeView setvariable ["DragDrop_ReleaseSubTv", Nil];

    if (!(_TargetSubTv isequalto [])&&(_ReleaseSubTv isequaltype [])&&!(_TargetSubTv isequalto _ReleaseSubTv)) then
    {
      _TargetSubTvParent = +_TargetSubTv; //Duplicates _TargetSubTv so it doesnt get redefined
      _TargetSubTvParent resize ((Count _TargetSubTvParent)-1);

      _ReleaseSubTvParent = +_ReleaseSubTv; //Duplicates _ReleaseSubTv so it doesnt get redefined
      if !(_ReleaseSubTv isequalto []) then {_ReleaseSubTvParent resize ((Count _ReleaseSubTvParent)-1);};

      _ReleaseSubTvData = (_CtrlTreeView tvData _ReleaseSubTv);
      _TargetSubTvData = (_CtrlTreeView tvData _TargetSubTv);
      _TargetSubTvText = (_CtrlTreeView tvText _TargetSubTv);
      _TargetSubTvValue = (_CtrlTreeView tvValue _TargetSubTv);

      _IsParent = (_TargetSubTvParent isequalto _ReleaseSubTv);
      _IsSameParent = (_TargetSubTvParent isequalto _ReleaseSubTvParent);
      _IsChild = ((_ReleaseSubTv select [0,(count _TargetSubTv)]) isequalto _TargetSubTv);

      if (!_IsParent&&!_IsChild&&((_ReleaseSubTvData isequalto "tvtab")||!_IsSameParent)) then
      {
        if (_ReleaseSubTvData isequalto "tvloadout") then
        {
          _ReleaseSubTv resize ((Count _ReleaseSubTv)-1);
        };

        _NewSubTVPath = _CtrlTreeView tvadd [_ReleaseSubTv, _TargetSubTvText];
        _CtrlTreeView tvExpand _ReleaseSubTv;

        _ReleaseSubTv pushback _NewSubTVPath;

        _CtrlTreeView tvSetData [_ReleaseSubTv, _TargetSubTvData];
        _CtrlTreeView TvSetValue [_ReleaseSubTv, _TargetSubTvValue];

        if (_TargetSubTvValue isequalto -1) then
        {
          _CtrlTreeView tvSetColor [_ReleaseSubTv,[1,1,1,0.25]];
        };

        if (_TargetSubTvData isequalto "tvtab") then
        {
          _CtrlTreeView tvSetPicture [_ReleaseSubTv, "\VANA_LoadoutManagement\UI\Data_Icons\icon_ca.paa"];
          _TargetChildren = [_CtrlTreeView, _TargetSubTv] call VANA_fnc_TreeViewGetData;
          //Form wich data is saved in is [["Name",[Position],"DataType"],["Name",[Position],"DataType"],["Name",[Position],"DataType"]] ect.
          {
            params ["_TvName","_TvPosition","_TvData","_TvNewParent"];

            _TvName = (_x select 0); //Selects "Name"
            _TvPosition = ((_x select 1) select [(count _TargetSubTv), (count (_x select 1) - (count _TargetSubTv))]); //Selects [Position] and removes _TargetSubTv array from the front of it
            _TvData = tolower (_x select 2); //Selects "DataType"

            _TvNewParent = +_ReleaseSubTv; //Duplicates _ReleaseSubTv so it doesnt get redefined
            _TvNewParent append _TvPosition;
            _TvNewParent resize ((Count _TvNewParent)-1);

            if (_TvData isEqualto "tvtab") then //Checks if selected SubArray is supposed to be a Tab
            {
              [_CtrlTreeView, _TvNewParent, _TvName] call VANA_fnc_TvCreateTab; //Calls CreateTab function to create a Tab with given data
            };

            if (_TvData isEqualto "tvloadout") then //Checks if selected SubArray is supposed to be a Loadout
            {
              [_CtrlTreeView, _TvNewParent, _TvName] call VANA_fnc_ShowVirtualLoadouts; //Calls ShowVirtualLoadouts function to create a Loadout with given data
            };
          } foreach _TargetChildren; //Loops Code bassed size of Saved Data, so the code under it gets executed for every data Array
        };

        _CtrlTreeView tvDelete _TargetSubTv;

        if !(_TargetSubTvData isequalto "tvtab") then //Calculates _ReleaseSubTv True posistion as tvDelete might have shifted it upwards
        {
          _ReleaseSubTvGrandParent = +_ReleaseSubTv; //Duplicates _ReleaseSubTv so it doesnt get redefined
          _ReleaseSubTvGrandParent resize (count _TargetSubTvParent); //resizes _ReleaseSubTvGrandParent to the same lenght as _TargetSubTvParent (So _ReleaseSubTvGrandParent is now the parent if the tab thats on the same layer as _TargetSubTvParent)

          if (_TargetSubTvParent isequalto _ReleaseSubTvGrandParent) then
          {
            private _Number = _ReleaseSubTv select (count _TargetSubTvParent);
            _ReleaseSubTv set [(count _TargetSubTvParent), (_Number - 1)]; //Shitfs the number up one
          };
        };

        _ReleaseSubTvParent = +_ReleaseSubTv; //Duplicates _ReleaseSubTv so it doesnt get redefined
        _ReleaseSubTvParent resize ((Count _ReleaseSubTvParent)-1); //Removes last number from aray (So this is now the parent)
        _CtrlTreeView tvSetCurSel ([_CtrlTreeView,_TargetSubTvText,_ReleaseSubTvParent,_TargetSubTvData] call VANA_fnc_TreeViewGetPosition);

        _Return = _ReleaseSubTv; //Returns Moved tab and new its new position
      } else {
        _Return = False; //Returns false meaning the function dint execute
      };
    } else {
      _Return = False; //Returns false meaning the function dint execute
    };
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  Default {diag_log text "[VANA_fnc_DragDrop]: Prober Mode ('MouseDown', 'MouseMove' or 'MouseUp') wasent given, Aborting Function."; _Return = [_Mode, False];};
};

_Return;
