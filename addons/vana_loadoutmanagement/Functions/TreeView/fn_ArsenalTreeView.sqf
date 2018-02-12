disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

#define ShowUI(BOOL)\
  Private _CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;\
  _CtrlTemplate ctrlsetfade ([1, 0] select BOOL);\
  _CtrlTemplate ctrlcommit 0;\
  _CtrlTemplate ctrlenable BOOL;\
  private _ctrlMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;\
  _ctrlMouseBlock ctrlenable BOOL;

#define ShowSaveUIParts(BOOL)\
  {\
    private _Ctrl = _ArsenalDisplay displayctrl _x;\
    _Ctrl ctrlshow BOOL;\
    _Ctrl ctrlenable BOOL;\
  } foreach [IDC_RSCDISPLAYARSENAL_TEMPLATE_TEXTNAME,IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME,IDC_RSCDISPLAYARSENAL_VANA_DecorativeBar];

#define Expanded 1
#define Collapsed 0

params
[
  ["_ArsenalDisplay", displaynull, [displaynull]],
  ["_Mode", "Open", [""]],
  ["_Arguments", [], [[]]]
];

switch tolower _Mode do
{
  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "init":
  {
    params ["_CtrlTreeView","_CtrlTemplateEdit","_CtrlButtonSave","_CtrlButtonLoad","_CtrlTemplateOKButton","_CtrlButtonTabCreate","_CtrlButtonRename","_CtrlDeleteButton","_CtrlTvUIPopup"];

    _ArsenalDisplay setvariable ["Vana_Initialised", True];

    //Add EventHandlers
    _ArsenalDisplay displayseteventhandler ["keyDown","[(_this select 0), 'KeyDown', _this] call VANA_fnc_ArsenalTreeView;"];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    _CtrlTreeView ctrladdeventhandler ["TreeSelChanged","[ctrlparent (_this select 0), 'TreeViewSelChanged'] call VANA_fnc_ArsenalTreeView;"];
    _CtrlTreeView ctrladdeventhandler ["TreeDblClick","[ctrlparent (_this select 0), 'TreeDblClick'] call VANA_fnc_ArsenalTreeView;"];
    _CtrlTreeView ctrladdeventhandler ["MouseMoving", "[ctrlparent (_this select 0), 'MouseMove', _this] call VANA_fnc_ArsenalTreeView;"];

    _CtrlTreeView ctrladdeventhandler ["TreeExpanded", "[ctrlparent (_this select 0), 'SubTvToggle', (_this + [True])] call VANA_fnc_ArsenalTreeView;"];
    _CtrlTreeView ctrladdeventhandler ["TreeCollapsed", "[ctrlparent (_this select 0), 'SubTvToggle', (_this + [False])] call VANA_fnc_ArsenalTreeView;"];

    _CtrlTreeView ctrladdeventhandler ["MouseButtonDown","[ctrlparent (_this select 0), 'TvDragDrop', ['MouseDown']] spawn VANA_fnc_ArsenalTreeView;"];
    _CtrlTreeView ctrladdeventhandler ["TreeMouseMove","[ctrlparent (_this select 0), 'TvDragDrop', ['MouseMove', _This]] spawn VANA_fnc_ArsenalTreeView;"];
    _CtrlTreeView ctrladdeventhandler ["MouseButtonUp","[ctrlparent (_this select 0), 'TvDragDrop', ['MouseUp']] spawn VANA_fnc_ArsenalTreeView;"];

    _CtrlTemplateEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
    _CtrlTemplateEdit ctrladdeventhandler ["KeyDown","[ctrlparent (_this select 0), 'CheckOverWrite'] spawn VANA_fnc_ArsenalTreeView;"];
    _CtrlTemplateEdit ctrladdeventhandler ["char","[ctrlparent (_this select 0), 'CheckOverWrite'] spawn VANA_fnc_ArsenalTreeView;"];

    _CtrlTButtonOptions = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_ButtonOptions; //WIP

    _CtrlButtonSave = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONSAVE;
    _CtrlButtonSave ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'ButtonSave'] call VANA_fnc_ArsenalTreeView;"];

    _CtrlButtonLoad = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONLOAD;
    _CtrlButtonLoad ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'ButtonLoad'] call VANA_fnc_ArsenalTreeView;"];

    _CtrlTemplateOKButton = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
    _CtrlTemplateOKButton ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'ButtonTemplateOK'] call VANA_fnc_ArsenalTreeView;"];

    _CtrlButtonTabCreate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_ButtonTabCreate;
    _CtrlButtonTabCreate ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'Create'] call VANA_fnc_ArsenalTreeView;"];

    _CtrlButtonRename = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_ButtonRename;
    _CtrlButtonRename ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'Rename'] spawn VANA_fnc_ArsenalTreeView;"];

    _CtrlDeleteButton = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
    _CtrlDeleteButton ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'Delete'] spawn VANA_fnc_ArsenalTreeView;"];

    //Load and Sort treeview
    [_CtrlTreeView] call VANA_fnc_TvLoadData;
    [_CtrlTreeView] call VANA_fnc_TvSorting;

    TvCollapseAll _CtrlTreeView;
    _CtrlTreeView TvExpand [];
    _CtrlTreeView tvsetcursel [0];

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "exit":
  {
    params ["_CtrlTreeView"];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

    _CtrlTreeView setvariable ["TvDragDrop_InAction", nil];
    _CtrlTreeView setvariable ["TvDragDrop_GetTarget", nil];
    _CtrlTreeView setvariable ["TvDragDrop_TargetTv", nil];
    _CtrlTreeView setvariable ["TvDragDrop_ReleaseSubTv", nil];

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "savedata":
  {
    params ["_CtrlTreeView"];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    [_CtrlTreeView] call VANA_fnc_TvSaveData;

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "treeviewselchanged":
  {
    params ["_CtrlTreeView","_SelectedTab","_IsEnabledLoadout","_CtrlDeleteButton","_CtrlButtonRename","_CtrlTemplateEdit","_CtrlTemplateOKButton"];

    [_ArsenalDisplay, "CheckOverWrite"] spawn VANA_fnc_ArsenalTreeView;

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

    _SelectedTab = tvCurSel _CtrlTreeView;
    _IsEnabledLoadout = tolower (_CtrlTreeView tvData _SelectedTab) isEqualto "tvloadout" && (_CtrlTreeView tvValue _SelectedTab) >= 0;

    //Make sure something is selected
    _CtrlDeleteButton = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
    _CtrlDeleteButton ctrlenable !(_SelectedTab isequalto []);

    _CtrlButtonRename = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_ButtonRename;
    _CtrlButtonRename ctrlenable !(_SelectedTab isequalto []);

    //SetText to selected Subtv Text
    _CtrlTemplateEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
    _CtrlTemplateEdit ctrlsettext (_CtrlTreeView tvtext _SelectedTab);

    //Disable button if loadout is missing items
    _CtrlTemplateOKButton = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
    _CtrlTemplateOKButton ctrlenable ([_IsEnabledLoadout, True] select ctrlenabled _CtrlTemplateEdit);

    //Temp code WIP
    private _CtrlTempCheckbox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_DelConfirmToggle;
    if (Profilenamespace getvariable ['TEMP_Popup_Value', False]) then
    {
      _CtrlTempCheckbox cbSetChecked true;
    } else {
      _CtrlTempCheckbox cbSetChecked False;
    };

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "checkoverwrite":
  {
    params ["_CtrlTemplateBUTTONOK","_CtrlTemplateEdit","_LoadoutData","_Name","_Duplicate"];

    _CtrlTemplateBUTTONOK = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
    _CtrlTemplateEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
    _LoadoutData = (profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]]) select {_x isequaltype ""};

    //Check if name duplicate and change text accordingly
    _Name = ctrltext _CtrlTemplateEdit;

    if (ctrlenabled _CtrlTemplateEdit) then
    {
      _Duplicate = _Name in _LoadoutData;
      _CtrlTemplateBUTTONOK Ctrlsettext (["Save", "Replace"] select _Duplicate);
      _CtrlTemplateBUTTONOK Ctrlenable ([True, False] select (_Name isequalto ""));

      _Duplicate
    };
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "subtvtoggle":
  {
    _Arguments params
    [
      ["_CtrlTreeView", controlnull, [controlnull]],
      ["_TargetTv", [-1], [[]]],
      ["_Expanded", False, [False]]
    ];

    _CtrlTreeView TvSetValue [_TargetTv, ([Collapsed, Expanded] Select _Expanded)];
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "treedblclick":
  {
    params ["_SelectedTab","_TvData","_CtrlTreeView","_TvCollapsed"];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    _SelectedTab = tvCurSel _CtrlTreeView;
    _TvData = tolower (_CtrlTreeView tvData _SelectedTab);

    if !(_CtrlTreeView getvariable ["MouseInTreeView", True]) exitwith {False};

    switch _TvData do
    {
      case "tvloadout":
      {
        [_ArsenalDisplay, "ButtonTemplateOK"] call VANA_fnc_ArsenalTreeView;
        True
      };
      case "tvtab":
      {
        //Expand or Collapse Tab
        _TvCollapsed = (_CtrlTreeView TvValue _SelectedTab) isequalto Collapsed;
        call ([{_CtrlTreeView TvCollapse _SelectedTab}, {_CtrlTreeView TvExpand _SelectedTab}] select _TvCollapsed);

        [_ArsenalDisplay, "SubTvToggle", [_CtrlTreeView, _SelectedTab, ([False, True] select _TvCollapsed)]] call VANA_fnc_ArsenalTreeView;
        True
      };
    };
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "keydown":
  {
    _Arguments params
    [
      ["_ArsenalDisplay", Displaynull, [Displaynull]],
      ["_Key", -1, [-1]],
      ["_Shift", False, [False]],
      ["_Ctrl", False, [False]],
      ["_Alt", False, [False]],
      "_CtrlTemplate",
      "_CtrlTvUIPopup",
      "_CtrlTemplateEdit",
      "_CtrlRenameEdit",
      "_inTemplate",
      "_InPopupUI"
    ];

    _CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
    _CtrlTvUIPopup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;
    _CtrlTemplateEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
    _CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;

    _InTemplate = ctrlFade _CtrlTemplate == 0;
    _InPopupUI = ctrlShown _CtrlTvUIPopup;

    switch True do
    {
      //CreateTab
      case (_key == DIK_N && _Ctrl):
      {
        if (_InTemplate && !_InPopupUI) then
        {
          [_ArsenalDisplay,"Create"] call VANA_fnc_ArsenalTreeView;
        };
        True
      };

      //Delete
      case ((_key == DIK_DELETE)||(_key == DIK_D && _Ctrl)):
      {
        if (_InTemplate && !_InPopupUI) then
        {
          [_ArsenalDisplay,"Delete"] spawn VANA_fnc_ArsenalTreeView;
        };
        True
      };

      //Rename
      case (_key == DIK_E && _Ctrl):
      {
        if (_InTemplate && !_InPopupUI) then
        {
          [_ArsenalDisplay,"Rename"] spawn VANA_fnc_ArsenalTreeView;
        };
        True
      };

      //Save
      Case (_key == DIK_S && _Ctrl):
      {
        if !_InPopupUI then
        {
          [_ArsenalDisplay,"ButtonSave"] call VANA_fnc_ArsenalTreeView;
        };
        True
      };

      //Open
      Case (_key == DIK_O && _Ctrl):
      {
        if !_InPopupUI then
        {
          [_ArsenalDisplay,"ButtonLoad"] call VANA_fnc_ArsenalTreeView;
        };
        True
      };

      //Close
      case (_key == DIK_ESCAPE):
      {
        if _inTemplate then
        {
          if _InPopupUI then
          {
            _CtrlTvUIPopup setvariable ["TvUIPopup_Status",False];
          } else {
            ShowUI(False)
          };
        } else {
          Private _FullVersion = missionnamespace getvariable ["BIS_fnc_arsenal_fullArsenal", False];
          if _fullVersion then {["buttonClose",[_ArsenalDisplay]] spawn BIS_fnc_arsenal;} else {_ArsenalDisplay closedisplay 2;};
        };
        True
      };

      //Enter
      case (_key in [DIK_RETURN,DIK_NUMPADENTER]):
      {
        if _InTemplate then
        {
          if _InPopupUI then
          {
            private _CtrlPopupButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK;
            if (ctrlenabled _CtrlPopupButtonOk) then {_CtrlTvUIPopup setvariable ["TvUIPopup_Status",True];};
          } else {
            private _CtrlTemplateBUTTONOK = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
            if (ctrlenabled _CtrlTemplateBUTTONOK) then {[_ArsenalDisplay,"ButtonTemplateOK"] call VANA_fnc_ArsenalTreeView;};
          };
        };
        True
      };

      //Calls BIS Code:
      Default
      {
        //Allow Ctrl + C in edit bars
        if ((_key == DIK_C && _Ctrl) && (_InTemplate || _InPopupUI)) exitwith {};

        if ((_InTemplate || _InPopupUI) && _key == DIK_TAB) then
        {
          True
        } else {
          ['KeyDown',_Arguments] call VANA_fnc_arsenal;
        };
      };
    };
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "mousemove":
  {
    _Arguments params
    [
      ["_CtrlTreeView", controlnull, [controlnull]],
      ["_XCoord", 0, [0]],
      ["_YCoord", 0, [0]]
    ];

    _CtrlTreeView setvariable ["MouseInTreeView", ([True, False] select (_XCoord >= 0.566 || _XCoord <= 0.046))];
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "tvdragdrop":
  {
    _Arguments params
    [
      ["_DragDropMode", "", [""]],
      ["_Arguments", [], [[]]],
      "_CtrlTreeView",
      "_CursorTab",
      "_FncReturn",
      "_FncMode",
      "_FncArguments",
      "_TvParent"
    ];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    _CursorTab = _Arguments param [1, [-1], [[]]];

    _FncReturn = [_CtrlTreeView, _DragDropMode, _CursorTab] call VANA_fnc_TvDragDrop;

    _FncMode = tolower (_FncReturn select 0);
    _FncArguments = _FncReturn select 1;

    if (!(_FncMode isequalto "dragdropfnc") || !(_FncArguments isequaltype [])) exitwith {False};

    _TvParent = _FncArguments call VANA_fnc_TvGetParent;

    [_CtrlTreeView, _TvParent, False] call VANA_fnc_TvSorting;
    [_CtrlTreeView] call VANA_fnc_TvSaveData;

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "create":
  {
    params ["_CtrlTreeView","_FncReturn","_TvParent"];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    _FncReturn = [_CtrlTreeView] call VANA_fnc_TvCreateTab;

    if (_FncReturn isequalto [-1]) exitwith {False};

    _TvParent = _FncReturn call VANA_fnc_TvGetParent;

    [_ArsenalDisplay, "TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;
    [_CtrlTreeView, _TvParent, False] call VANA_fnc_TvSorting;
    [_CtrlTreeView] call VANA_fnc_TvSaveData;

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "delete":
  {
    params ["_CtrlTreeView","_TargetTv","_DeleteFnc"];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

    _TargetTv = tvCurSel _CtrlTreeView;
    _DeleteFnc =
    {
      params ["_FncReturn","_TvParent"];

      _FncReturn = [_CtrlTreeView, _TargetTv] call VANA_fnc_TvDelete;

      if !(_FncReturn isequaltype []) exitwith {False};

      _TvParent = _FncReturn call VANA_fnc_TvGetParent;

      [_ArsenalDisplay, "TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;
      [_CtrlTreeView, _TvParent, False] call VANA_fnc_TvSorting;
      [_CtrlTreeView] call VANA_fnc_TvSaveData;

      True
    };

    if (_TargetTv isequalto []) exitwith {False};

    if !(Profilenamespace getvariable ["TEMP_Popup_Value", False]) then
    {
      if ([_ArsenalDisplay,"Delete"] call VANA_fnc_UIPopup) then
      {
        call _DeleteFnc;
      };
    } else {
      call _DeleteFnc;
    };
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "rename":
  {
    params ["_CtrlTreeView","_CtrlRenameEdit","_Return","_TargetTv","_FncReturn","_Name","_TvParent"];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    _CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;

    _Return = [_ArsenalDisplay, "Rename"] call VANA_fnc_UIPopup;

    if !_Return exitwith {False};

    _TargetTv = tvCurSel _CtrlTreeView;
    _Name = ctrltext _CtrlRenameEdit;

    [_CtrlTreeView, [_TargetTv, _Name]] call VANA_fnc_TvRename;

    _TvParent = _TargetTv call VANA_fnc_TvGetParent;

    [_ArsenalDisplay, "TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;
    [_CtrlTreeView, _TvParent, False] call VANA_fnc_TvSorting;
    [_CtrlTreeView] call VANA_fnc_TvSaveData;

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "buttonload":
  {
    params ["_CtrlTreeView"];

    ShowUI(True)
    ShowSaveUIParts(False)
    ctrlsetfocus _CtrlMouseBlock;

    //Show "Load"
    {
      (_ArsenalDisplay displayctrl _x) ctrlsettext localize "str_disp_int_load";
    } foreach [IDC_RSCDISPLAYARSENAL_TEMPLATE_TITLE,IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK];

    //Check if message allready displayed once
    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    if !(_CtrlTreeView getvariable ["VANA_LoadMessageDisplayed", False]) then
    {
      _CtrlTreeView setvariable ["VANA_LoadMessageDisplayed", True];
      ["showMessage",[_ArsenalDisplay,"Note: Loadouts still require unique names, Tabs do not"]] spawn BIS_fnc_arsenal;
    };

    [_ArsenalDisplay,"TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "buttonsave":
  {
    params ["_CtrlTemplateTitle","_CtrlTemplateEdit","_CtrlTreeView"];

    ShowUI(True)
    ShowSaveUIParts(True)

    //Show "Save"
    _CtrlTemplateTitle = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TITLE;
    _CtrlTemplateTitle ctrlsettext localize "str_disp_int_save";

    _CtrlTemplateEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
    ctrlsetfocus _CtrlTemplateEdit;

    //Check if message allready displayed once
    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    if !(_CtrlTreeView getvariable ["VANA_SaveMessageDisplayed", False]) then
    {
      _CtrlTreeView setvariable ["VANA_SaveMessageDisplayed", True];
      ["showMessage",[_ArsenalDisplay,localize "STR_A3_RscDisplayArsenal_message_save"]] spawn BIS_fnc_arsenal;
    };

    [_ArsenalDisplay,"TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
	case "buttontemplateok":
  {
    params ["_CtrlTreeView","_CtrlTemplateEdit","_SelectedTab","_HideTemplate","_LoadoutName","_FncReturn","_TvParent","_Center","_Inventory","_LoadoutData","_Name","_NameID","_InventoryCustom"];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    _CtrlTemplateEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;

    _SelectedTab = TvCursel _CtrlTreeView;
    _HideTemplate = True;

    if (ctrlenabled _CtrlTemplateEdit) then
    {
      //Save
      _LoadoutName = ctrltext _CtrlTemplateEdit;
      _FncReturn = [_CtrlTreeView, _LoadoutName] call VANA_fnc_TvSaveLoadout;

      if (_FncReturn select 0 isequalto [-1]) exitwith {};

      _TvParent = (_FncReturn select 0) call VANA_fnc_TvGetParent;

      [_CtrlTreeView, _TvParent, False] call VANA_fnc_TvSorting;
      [_CtrlTreeView] call VANA_fnc_TvSaveData;

    } else {
      //Load (Taken Directly from BIS_fnc_Arsenal and modified to work with treeview)
      _Center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
      if ((_CtrlTreeView TvValue _SelectedTab) >= 0 && (_CtrlTreeView TvData _SelectedTab) isequalto "tvloadout") then
      {
        _Inventory = _CtrlTreeView TvText _SelectedTab;

        [_Center,[profilenamespace,_Inventory]] call bis_fnc_loadinventory;
        _Center switchmove "";

        //Load custom data
        _LoadoutData = profilenamespace getvariable ["bis_fnc_saveInventory_data",[]];
        _Name = _CtrlTreeView TvText _SelectedTab;
        _NameID = _LoadoutData find _Name;

        if (_NameID >= 0) then
        {
          _Inventory = _LoadoutData select (_NameID + 1);
          _InventoryCustom = _Inventory select 10;

          _Center setface (_InventoryCustom select 0);
          _Center setvariable ["BIS_fnc_arsenal_face",(_InventoryCustom select 0)];
          _Center setspeaker (_InventoryCustom select 1);

          [_Center,_InventoryCustom select 2] call bis_fnc_setUnitInsignia;
        };

        ["ListSelectCurrent",[_ArsenalDisplay]] spawn BIS_fnc_arsenal;
        ["showMessage",[_ArsenalDisplay, (format ["Loadout: ""%1"" Loaded", _Name])]] spawn BIS_fnc_arsenal;
      } else {
        _HideTemplate = False;
      };
    };

    if _HideTemplate then
    {
      ShowUI(False)
    };

    True
	};
};
