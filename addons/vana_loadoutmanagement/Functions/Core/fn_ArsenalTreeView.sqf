disableserialization;

params
[
  ["_ArsenalDisplay", displaynull, [displaynull]],
  ["_Mode", "Open", [""]],
  ["_Arguments", [], [[]]],
  "_FullVersion"
];

_FullVersion = missionnamespace getvariable ["BIS_fnc_arsenal_fullArsenal",False];

#include "\VANA_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\VANA_LoadoutManagement\UI\defineResinclDesign.inc"

switch (tolower _Mode) do  //Checks wich mode the code exes in
{
  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "init":
  {
    params ["_CtrlTreeView","_CtrlTemplateEdit","_CtrlButtonSave","_CtrlButtonLoad","_CtrlVANA_OKButton","_CtrlVANA_ButtonTabCreate","_CtrlVANA_ButtonRename","_CtrlVANA_OKButton","_CtrlVANA_DeleteButton","_CtrlTvUIPopup"];

    _ArsenalDisplay setvariable ["Vana_Initialised", True];
    [_ArsenalDisplay,"Init"] call VANA_fnc_UIPopup;

    //Add EventHandlers
    _ArsenalDisplay displayseteventhandler ["keyDown","[(_this select 0),'KeyDown',_this] call VANA_fnc_ArsenalTreeView;"];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    _CtrlTreeView ctrladdeventhandler ["TreeSelChanged","[ctrlparent (_this select 0),'TreeViewSelChanged'] call VANA_fnc_ArsenalTreeView;"];
    _CtrlTreeView ctrladdeventhandler ["TreeDblClick","[ctrlparent (_this select 0),'TreeDblClick'] call VANA_fnc_ArsenalTreeView;"];

    _CtrlTreeView ctrladdeventhandler ["MouseButtonDown","[ctrlparent (_this select 0),'DragDrop', ['MouseDown']] spawn VANA_fnc_ArsenalTreeView;"];
    _CtrlTreeView ctrladdeventhandler ["TreeMouseMove","[ctrlparent (_this select 0),'DragDrop', ['MouseMove', _This]] spawn VANA_fnc_ArsenalTreeView;"];
    _CtrlTreeView ctrladdeventhandler ["MouseButtonUp","[ctrlparent (_this select 0),'DragDrop', ['MouseUp']] spawn VANA_fnc_ArsenalTreeView;"];

    _CtrlTemplateEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
    _CtrlTemplateEdit ctrladdeventhandler ["KeyDown","[ctrlparent (_this select 0),'CheckOverWrite'] spawn VANA_fnc_ArsenalTreeView;"];
    _CtrlTemplateEdit ctrladdeventhandler ["char","[ctrlparent (_this select 0),'CheckOverWrite'] spawn VANA_fnc_ArsenalTreeView;"];

    _CtrlButtonSave = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONSAVE;
    _CtrlButtonSave ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0),'ButtonSave'] call VANA_fnc_ArsenalTreeView;"];

    _CtrlButtonLoad = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONLOAD;
    _CtrlButtonLoad ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0),'ButtonLoad'] call VANA_fnc_ArsenalTreeView;"];

    _CtrlVANA_OKButton = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
    _CtrlVANA_OKButton ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0),'ButtonTemplateOK'] call VANA_fnc_ArsenalTreeView;"];

    _CtrlVANA_ButtonTabCreate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_ButtonTabCreate;
    _CtrlVANA_ButtonTabCreate ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0),'Create'] call VANA_fnc_ArsenalTreeView;"];

    _CtrlVANA_ButtonRename = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_ButtonRename;
    _CtrlVANA_ButtonRename ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0),'Rename'] spawn VANA_fnc_ArsenalTreeView;"];

    _CtrlVANA_DeleteButton = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
    _CtrlVANA_DeleteButton ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0),'Delete'] spawn VANA_fnc_ArsenalTreeView;"];

    //Hide Vana dint init popup
    _CtrlTvUIPopup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;
    _CtrlTvUIPopup ctrlshow False;
    {
      (_ArsenalDisplay displayctrl _x) ctrlshow true;
    } foreach [IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit,IDC_RSCDISPLAYARSENALPOPUP_VANA_HintText,IDC_RSCDISPLAYARSENALPOPUP_VANA_CheckboxText,IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup];

    //Load and Sort treeview
    private _Time = diag_tickTime;
    [_CtrlTreeView] call VANA_fnc_TreeViewLoadData;
    [_CtrlTreeView] call VANA_fnc_TreeViewSorting;
    _Time = (diag_ticktime - _Time);
    diag_log str _Time;
    systemchat str _Time;

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

    _CtrlTreeView setvariable ["DragDrop_InAction", nil];
    _CtrlTreeView setvariable ["DragDrop_GetTarget", nil];
    _CtrlTreeView setvariable ["DragDrop_TargetTv", nil];
    _CtrlTreeView setvariable ["DragDrop_ReleaseSubTv", nil];

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
	case "dragdrop":
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
      "_TvParrent"
    ];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

    _CursorTab = _Arguments param [1, [-1], [[]]];

    _FncReturn = [_CtrlTreeView, _DragDropMode, _CursorTab] call VANA_fnc_DragDrop;

    _FncMode = tolower (_FncReturn select 0);
    _FncArguments = _FncReturn select 1;

    if (_FncMode isequalto "mouseup" && _FncArguments isequaltype []) then
    {
      _TvParrent = +_FncArguments;
      _TvParrent resize ((Count _TvParrent)-1);

      [_CtrlTreeView, _TvParrent, False] call VANA_fnc_TreeViewSorting;
      //[_CtrlTreeView] call VANA_fnc_TreeViewSaveData;
    };

    True
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

    _inTemplate = ctrlFade _CtrlTemplate == 0;
    _InPopupUI = ctrlShown _CtrlTvUIPopup;

    switch True do
    {
      //VANA Code:

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
            _CtrlTvUIPopup setvariable ["VANA_fnc_TvUIPopup_Status",False];
          } else {
            _ctrlTemplate ctrlsetfade 1;
            _ctrlTemplate ctrlcommit 0;
            _ctrlTemplate ctrlenable False;

            private _ctrlMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
            _ctrlMouseBlock ctrlenable False;
          };
        } else {
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
            if (ctrlenabled _CtrlPopupButtonOk) then {_CtrlTvUIPopup setvariable ["VANA_fnc_TvUIPopup_Status",True];};
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
        if ((_key == DIK_C && _Ctrl) && (_InTemplate || _InPopupUI)) exitwith {}; //this allows the use of Ctrl + C in the edit bars

        if ((_InTemplate||_InPopupUI) && (_key == DIK_TAB)) then
        {
          True
        } else {
          ['KeyDown',_Arguments] call VANA_fnc_arsenal;
        };
      };
    };
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "savedata":
  {
    params ["_CtrlTreeView"];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

    [_CtrlTreeView] call VANA_fnc_TreeViewSaveData;

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "treedblclick":
  {
    params ["_SelectedTab","_TvData","_CtrlTreeView"];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    _SelectedTab = tvCurSel _CtrlTreeView; //Gets Selected tab
    _TvData = tolower (_CtrlTreeView tvData _SelectedTab); //Gets Data assigned to sellected SubTv

    if ((_TvData isequalto "tvloadout")) then
    {
      [_ArsenalDisplay,"ButtonTemplateOK"] call VANA_fnc_ArsenalTreeView;
      True
    };
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "checkoverwrite":
  {
    params ["_CtrlTemplateBUTTONOK","_CtrlTemplateEdit","_LoadoutData","_Name","_Duplicate"];

    _CtrlTemplateBUTTONOK = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
    _CtrlTemplateEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
    _LoadoutData = (profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]]) select {_x isequaltype ""};

    //Check if name duplicate and color edit field accordingly
    _Name = ctrltext _CtrlTemplateEdit;

    if (ctrlenabled _CtrlTemplateEdit) then
    {
      _Duplicate = _Name in _LoadoutData;
      _CtrlTemplateBUTTONOK Ctrlsettext (["Save","Replace"] select _Duplicate);
      _CtrlTemplateBUTTONOK Ctrlenable ([True, False] select (_Name isequalto ""));

      _Duplicate
    };
  };

	///////////////////////////////////////////////////////////////////////////////////////////
  case "treeviewselchanged":
	{
    params ["_CtrlTreeView","_CtrlVANA_DeleteButton","_CtrlVANA_ButtonRename","_CtrlTemplateEdit","_CtrlVANA_OKButton","_SelectedTab","_TvData"];

		_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

    [_ArsenalDisplay,"CheckOverWrite"] spawn VANA_fnc_ArsenalTreeView;

    _SelectedTab = tvCurSel _CtrlTreeView;
    _TvData = tolower (_CtrlTreeView tvData _SelectedTab);

    _CtrlTreeView setvariable ["DragDrop_InAction", nil];
    _CtrlTreeView setvariable ["DragDrop_GetTarget", nil];
    _CtrlTreeView setvariable ["DragDrop_TargetTv", nil];
    _CtrlTreeView setvariable ["DragDrop_ReleaseSubTv", nil];

    _CtrlVANA_DeleteButton = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
    _CtrlVANA_DeleteButton ctrlenable !(_SelectedTab isequalto []);

		_CtrlVANA_ButtonRename = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_ButtonRename;
		_CtrlVANA_ButtonRename ctrlenable !(_SelectedTab isequalto []);

    _CtrlTemplateEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
    _CtrlTemplateEdit ctrlsettext (_CtrlTreeView tvtext _SelectedTab);

    _CtrlVANA_OKButton = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
    if (ctrlenabled _CtrlTemplateEdit) then
    {
      _CtrlVANA_OKButton ctrlenable True; //Save
    } else {
      _CtrlVANA_OKButton ctrlenable ((_TvData isEqualto "tvloadout")&&((_CtrlTreeView tvValue _SelectedTab) >= 0)); //Load
    };

    //Temp code
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
  case "buttonload":
  {
    params ["_CtrlTreeView","_CtrlTemplate","_CtrlMouseBlock"];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

    _CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
    _CtrlTemplate ctrlsetfade 0;
    _CtrlTemplate ctrlcommit 0;
    _CtrlTemplate ctrlenable true;

    _CtrlMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
    _CtrlMouseBlock ctrlenable True;
    ctrlsetfocus _ctrlMouseBlock;

    {
      (_ArsenalDisplay displayctrl _x) ctrlsettext localize "str_disp_int_load";
    } foreach [IDC_RSCDISPLAYARSENAL_TEMPLATE_TITLE,IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK];
    {
			private _Ctrl = _ArsenalDisplay displayctrl _x;
			_Ctrl ctrlshow False;
			_Ctrl ctrlenable False;
		} foreach [IDC_RSCDISPLAYARSENAL_TEMPLATE_TEXTNAME,IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME,IDC_RSCDISPLAYARSENAL_VANA_DecorativeBar];

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
    params ["_CtrlTreeView","_CtrlTemplateTitle","_CtrlTemplate","_CtrlTemplateEdit","_CtrlMouseBlock"];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

    _CtrlTemplateTitle = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TITLE;
    _CtrlTemplateTitle ctrlsettext localize "str_disp_int_save";

    _CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
    _CtrlTemplate ctrlsetfade 0;
    _CtrlTemplate ctrlcommit 0;
    _CtrlTemplate ctrlenable True;

    _CtrlTemplateEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
    ctrlsetfocus _CtrlTemplateEdit;

    _CtrlMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
    _CtrlMouseBlock ctrlenable True;

    {
			private _Ctrl = _ArsenalDisplay displayctrl _x;
			_Ctrl ctrlshow True;
			_Ctrl ctrlenable True;
		} foreach [IDC_RSCDISPLAYARSENAL_TEMPLATE_TEXTNAME,IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME,IDC_RSCDISPLAYARSENAL_VANA_DecorativeBar];

    if !(_CtrlTreeView getvariable ["VANA_SaveMessageDisplayed", False]) then
    {
      _CtrlTreeView setvariable ["VANA_SaveMessageDisplayed", True];
      ["showMessage",[_ArsenalDisplay,localize "STR_A3_RscDisplayArsenal_message_save"]] spawn BIS_fnc_arsenal;
    };

    [_ArsenalDisplay,"TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
	case "buttontemplateok": //Code taken from BIS_fnc_arsenal and modified to be compatible with Tv
  {
params ["_CtrlTreeView","_CtrlTemplateEdit","_CtrlTemplate","_CtrlMouseBlock"];

    _CtrlTemplateEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

    Params ["_HideTemplate","_LoadoutName","_FncReturn","_TvParrent","_Center","_SelectedTab","_Inventory","_LoadoutData","_Name","_NameID","_Inventory","_InventoryCustom"];

    _SelectedTab = TvCursel _CtrlTreeView;
    _HideTemplate = True;

    if (ctrlenabled _CtrlTemplateEdit) then
    {
      //Save
      _LoadoutName = ctrltext _CtrlTemplateEdit;
      _FncReturn = [_CtrlTreeView, _LoadoutName] call VANA_fnc_SaveLoadout;
      if (_FncReturn select 0 isequalto [-1]) exitwith {};

      _TvParrent = +(_FncReturn select 0);

      _TvParrent resize ((Count _TvParrent)-1);

      [_CtrlTreeView, _TvParrent, False] call VANA_fnc_TreeViewSorting;
      [_CtrlTreeView] call VANA_fnc_TreeViewSaveData;
    } else {
      //Load
      _Center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
      if ((_CtrlTreeView TvValue _SelectedTab) >= 0 && (_CtrlTreeView TvData _SelectedTab) isequalto "tvloadout") then {
        _Inventory = _CtrlTreeView TvText _SelectedTab;
        [_Center,[profilenamespace,_Inventory]] call bis_fnc_loadinventory;
        _Center switchmove "";

        //Load custom data
        _LoadoutData = profilenamespace getvariable ["bis_fnc_saveInventory_data",[]];
        _Name = _CtrlTreeView TvText _SelectedTab;
        _NameID = _LoadoutData find _Name;
        if (_NameID >= 0) then {
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
      _CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
      _CtrlTemplate ctrlsetfade 1;
      _CtrlTemplate ctrlcommit 0;
      _CtrlTemplate ctrlenable False;

      _CtrlMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
      _CtrlMouseBlock ctrlenable False;

      [_ArsenalDisplay,"TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;
    };

    True
	};

  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "create":
  {
    params ["_CtrlTreeView","_FncReturn","_TvParrent"];

		_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

	 	_FncReturn = [_CtrlTreeView] call VANA_fnc_TvCreateTab;

    if !(_FncReturn isequalto [-1]) then
    {
      _TvParrent = +_FncReturn;

      _TvParrent resize ((Count _TvParrent)-1);

      [_ArsenalDisplay,"TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;
      [_CtrlTreeView, _TvParrent, False] call VANA_fnc_TreeViewSorting;
      [_CtrlTreeView] call VANA_fnc_TreeViewSaveData;

      True
    };
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "delete":
  {
    params ["_CtrlTreeView","_TargetTv","_DeleteFnc"];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

    _TargetTv = tvCurSel _CtrlTreeView;
    _DeleteFnc =
    {
      params ["_FncReturn","_TvParrent"];

      _FncReturn = [_CtrlTreeView, _TargetTv] call VANA_fnc_TvDelete;

      if (_FncReturn isequaltype []) then
      {
        _TvParrent = +_FncReturn;

        _TvParrent resize ((Count _TvParrent)-1);

        [_CtrlTreeView] call VANA_fnc_TreeViewSaveData;
        [_CtrlTreeView, _TvParrent, False] call VANA_fnc_TreeViewSorting;
        [_ArsenalDisplay,"TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;
      };
    };

    if !(_TargetTv isequalto []) then
    {
      if !(Profilenamespace getvariable ["TEMP_Popup_Value", False]) then
      {
        if ([_ArsenalDisplay,"Delete"] call VANA_fnc_UIPopup) then
        {
          call _DeleteFnc;

          True
        };
      } else {
        call _DeleteFnc;

        True
      };
    };
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "rename":
  {
    params ["_CtrlTreeView","_CtrlRenameEdit","_Return","_TargetTv","_FncReturn","_Name","_TvParrent"];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    _CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;

    _Return = [_ArsenalDisplay, "Rename"] call VANA_fnc_UIPopup;

    if _Return then
    {
      _TargetTv = tvCurSel _CtrlTreeView;
      _Name = ctrltext _CtrlRenameEdit;

      _FncReturn = [_CtrlTreeView, _Name, _TargetTv] call VANA_fnc_TvRename;

      if _FncReturn then
      {
        _TvParrent = +_TargetTv;

        _TvParrent resize ((Count _TvParrent)-1);

        [_ArsenalDisplay, "TreeViewSelChanged"] call VANA_fnc_ArsenalTreeView;
        [_CtrlTreeView, _TvParrent, False] call VANA_fnc_TreeViewSorting;
        [_CtrlTreeView] call VANA_fnc_TreeViewSaveData;
      };
    };
  };
};
