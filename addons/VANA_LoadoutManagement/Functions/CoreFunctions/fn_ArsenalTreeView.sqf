disableserialization;

Private _Return = False;
Private _Mode = [_this,0,"Open",[displaynull,""]] call bis_fnc_param;
_ArsenalIDD = [_this,1,[]] call bis_fnc_param; //Gets Arsenal Display ID
_FullVersion = missionnamespace getvariable ["BIS_fnc_arsenal_fullArsenal",False];
//_CustomPlayerColor = ["GUI","BCG_RGB"] call BIS_fnc_ArsenalDisplayColorGet;
//_colorHighlightHTML = _colorHighlightRGB call BIS_fnc_colorRGBtoHTML; //Only needed for text

#include "\VANA_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\VANA_LoadoutManagement\UI\defineResinclDesign.inc"

switch (tolower _Mode) do  //Checks wich mode the code exes in
{
  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "init":
  {
    _ArsenalDisplay = _ArsenalIDD select 0;

    //--- Add EventHandlers
    _ArsenalDisplay displayRemoveAllEventHandlers "keyDown";
    _ArsenalDisplay displayseteventhandler ["keyDown","with uinamespace do {['KeyDown',_this] call VANA_fnc_ArsenalTreeView;};"];

    _CtrlButtonSave = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONSAVE;
    _CtrlButtonSave ctrladdeventhandler ["buttonclick","with uinamespace do {['SaveButton',[ctrlparent (_this select 0)]] spawn VANA_fnc_ArsenalTreeView;};"];

    _CtrlButtonLoad = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONLOAD;
    _CtrlButtonLoad ctrladdeventhandler ["buttonclick","with uinamespace do {['LoadButton',[ctrlparent (_this select 0)]] spawn VANA_fnc_ArsenalTreeView;};"];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    _CtrlTreeView ctrladdeventhandler ["TreeSelChanged","with uinamespace do {['TreeViewSelChanged',[ctrlparent (_this select 0)]] call VANA_fnc_ArsenalTreeView;};"];
    _CtrlTreeView ctrladdeventhandler ["TreeDblClick","with uinamespace do {['TreeDblClick',[ctrlparent (_this select 0)]] call VANA_fnc_ArsenalTreeView;};"];
    _CtrlTreeView ctrladdeventhandler ["MouseButtonDown","with uinamespace do {['DragDrop',[ctrlparent (_this select 0)], 'MouseDown'] call VANA_fnc_ArsenalTreeView;};"];
    _CtrlTreeView ctrladdeventhandler ["MouseButtonUp","with uinamespace do {['DragDrop',[ctrlparent (_this select 0)], 'MouseUp'] call VANA_fnc_ArsenalTreeView;};"];
    _CtrlTreeView ctrladdeventhandler ["TreeMouseMove","with uinamespace do {['DragDrop',[ctrlparent (_this select 0)], 'MouseMove', _This] call VANA_fnc_ArsenalTreeView;};"];

    _CtrlVANA_ButtonTabCreate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_ButtonTabCreate;
    _CtrlVANA_ButtonTabCreate ctrladdeventhandler ["buttonclick","with uinamespace do {['Create',[ctrlparent (_this select 0)]] call VANA_fnc_ArsenalTreeView;};"];

    _CtrlVANA_ButtonRename = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_ButtonRename;
    _CtrlVANA_ButtonRename ctrladdeventhandler ["buttonclick","with uinamespace do {['Rename',[ctrlparent (_this select 0)]] call VANA_fnc_ArsenalTreeView;};"];

    _CtrlVANA_OKButton = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OKButton;
    _CtrlVANA_OKButton ctrladdeventhandler ["buttonclick","with uinamespace do {['ButtonTemplateOK',[ctrlparent (_this select 0)]] call VANA_fnc_ArsenalTreeView;};"];

    _CtrlVANA_DeleteButton = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_DeleteButton;
    _CtrlVANA_DeleteButton ctrladdeventhandler ["buttonclick","with uinamespace do {['Delete',[ctrlparent (_this select 0)]] call VANA_fnc_ArsenalTreeView;};"];

    _CtrlTemplateButtonDelete = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
    _CtrlTemplateButtonOK = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;

    //--- VANA: TreeviewUIPopup
    _CtrlVanaMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_Mouseblock;
    _CtrlVanaMouseBlock ctrladdeventhandler ["SetFocus","[ctrlparent (_this select 0), 'MouseBlockFocus'] spawn VANA_fnc_TreeViewUIPopup;"];

    _CtrlButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK;
    _CtrlButtonOk ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'Clicked', {}, [], True] call VANA_fnc_TreeViewUIPopup;"];

    _CtrlButtonCancel = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonCancel;
    _CtrlButtonCancel ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'Clicked', {}, [], False] call VANA_fnc_TreeViewUIPopup;"];

    _CtrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;
    _CtrlPopupCheckBox ctrladdeventhandler ["CheckedChanged","if (Profilenamespace getvariable ['TEMP_Popup_Value', False]) then {Profilenamespace setvariable ['TEMP_Popup_Value', False];} else {Profilenamespace setvariable ['TEMP_Popup_Value', True];}; ['TreeViewSelChanged',[ctrlparent (_this select 0)]] call VANA_fnc_ArsenalTreeView;"];
    _CtrlPopupCheckBox ctrladdeventhandler ["killFocus","[ctrlparent (_this select 0), 'MouseBlockFocus'] spawn VANA_fnc_TreeViewUIPopup;"];

    _CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;
    _CtrlRenameEdit ctrladdeventhandler ["killFocus","[ctrlparent (_this select 0), 'MouseBlockFocus'] spawn VANA_fnc_TreeViewUIPopup;"];

    _CtrlTempCheckbox = _ArsenalDisplay displayctrl 978005; //Temp
    _CtrlTempCheckbox ctrladdeventhandler ["CheckedChanged","if (Profilenamespace getvariable ['TEMP_Popup_Value', False]) then {Profilenamespace setvariable ['TEMP_Popup_Value', False];} else {Profilenamespace setvariable ['TEMP_Popup_Value', True];};"];

    //--- Hide Vana dint init popup
    _CtrlUIPopup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;
    _CtrlUIPopup ctrlshow False;
    {
      (_ArsenalDisplay displayctrl _x) ctrlshow true;
    } foreach [IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit,IDC_RSCDISPLAYARSENALPOPUP_VANA_HintText,IDC_RSCDISPLAYARSENALPOPUP_VANA_CheckboxText,IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup];

    //--- Extras
    [_CtrlTreeView] call VANA_fnc_TreeViewLoadData;
    [_CtrlTreeView] call VANA_fnc_TreeViewSorting;

    TvCollapseAll _CtrlTreeView;
    _CtrlTreeView TvExpand [];
    _CtrlTreeView tvsetcursel [-1];

    _Return = True;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
	case "dragdrop":
  {
    _ArsenalDisplay = _ArsenalIDD select 0;
    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    _CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;

    params ["_DragDropMode","_CursorTab","_FncReturn","_FncMode","_FncCompleted","_FncSubTvPath","_TvParrent"];
    _DragDropMode = _This select 2; //Gets wich eventhandler called this function
    _CursorTab = ((_this select 3) select 1); //Gets Return value from TreeMouseMove eventhandler (TreeMouseMove returns Path of the Tv mouse hovering over)

    _FncReturn = [_CtrlTreeView, _CtrlTemplate, _DragDropMode, _CursorTab] call VANA_fnc_DragDrop;
    _FncMode = (_FncReturn select 0);
    _FncCompleted = (_FncReturn select 1);
    _FncSubTvPath = (_FncReturn select 2); //Only exsists if VANA_fnc_DragDrop was executed in "DragDropCode" mode (Function does it automaticly if "MouseUp" triggers it)
    if ((_FncMode isequalto "MouseUp")&&(_FncCompleted)&&(_FncSubTvPath isequaltype [])) then
    {
      _TvParrent = +_FncSubTvPath;
      _TvParrent resize ((Count _TvParrent)-1);

      [_CtrlTreeView, _TvParrent, False] call VANA_fnc_TreeViewSorting;
      [_CtrlTreeView] call VANA_fnc_TreeViewSaveData;
    };

    _Return = True;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "keydown":
  {
    _ArsenalDisplay = _ArsenalIDD select 0;
    _ctrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    _ctrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
    _CtrlUIPopup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;

    _CtrlTemplateName = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
    _CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;

    params ["_EventHandlerInfo","_Key","_Shift","_Ctrl","_Alt","_inTemplate","_InPopupUI"];
    _EventHandlerInfo = _This select 1;
		_key = _EventHandlerInfo select 1;
    _Shift = _EventHandlerInfo select 2;
		_Ctrl = _EventHandlerInfo select 3;
    _Alt = _EventHandlerInfo select 4;
    _inTemplate = ctrlFade _CtrlTemplate == 0;
    _InPopupUI = ctrlShown _CtrlUIPopup;
    _Return = False;

    switch True do
    {
      //--- VANA Code:

      //--- Rename
      case (_key == DIK_E && (_Ctrl || _Shift)):
      {
        if (_InTemplate && !_InPopupUI) then
        {
          ['Rename',[_ArsenalDisplay]] call VANA_fnc_ArsenalTreeView;
        };
        _Return = True;
      };

      //--- CreateTab
      case (_key == DIK_N && (_Ctrl || _Shift)):
      {
        if (_InTemplate && !_InPopupUI) then
        {
          ['Create',[_ArsenalDisplay]] call VANA_fnc_ArsenalTreeView;
        };
        _Return = True;
      };

      //--- Delete
      case ((_key == DIK_DELETE)||(_key == DIK_D && (_Ctrl || _Shift))):
      {
        if (_InTemplate && !_InPopupUI) then
        {
          ['Delete',[_ArsenalDisplay]] call VANA_fnc_ArsenalTreeView;
        };
        _Return = True;
      };

      //--- Save
      Case (_key == DIK_S && _Ctrl):
      {
        if !(_InPopupUI) then
        {
          ['buttonSave',[_ArsenalDisplay]] call bis_fnc_arsenal;
          ['SaveButton',[_ArsenalDisplay]] call VANA_fnc_ArsenalTreeView;
        };
        _Return = True;
      };

      //--- Open
      Case (_key == DIK_O && _Ctrl):
      {
        if !(_InPopupUI) then
        {
          ['buttonLoad',[_ArsenalDisplay]] call bis_fnc_arsenal;
          ['LoadButton',[_ArsenalDisplay]] call VANA_fnc_ArsenalTreeView;
        };
        _Return = True;
      };

      //--- Close
      case (_key == DIK_ESCAPE):
      {
        if (_inTemplate) then
        {
          if (_InPopupUI) then
          {
            [_ArsenalDisplay, 'Clicked', {}, [], False] call VANA_fnc_TreeViewUIPopup;
            ['TreeViewSelChanged',[_ArsenalDisplay]] call VANA_fnc_ArsenalTreeView;
          } else {
            _ctrlTemplate ctrlsetfade 1;
            _ctrlTemplate ctrlcommit 0;
            _ctrlTemplate ctrlenable False;

            _ctrlMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
            _ctrlMouseBlock ctrlenable False;
          };
        } else {
          if (_fullVersion) then {["buttonClose",[_ArsenalDisplay]] spawn bis_fnc_arsenal;} else {_ArsenalDisplay closedisplay 2;};
        };
        _Return = True;
      };

      //--- Enter
      case (_key in [DIK_RETURN,DIK_NUMPADENTER]):
      {
        if (_InTemplate) then
        {
          if (_InPopupUI) then
          {
            [_ArsenalDisplay,'Clicked', {}, [], True] call VANA_fnc_TreeViewUIPopup;
          } else {
            ['ButtonTemplateOK',[_ArsenalDisplay]] call VANA_fnc_ArsenalTreeView;
          };
        };
        _Return = True;
      };

      //--- Calls BIS Code:
      Default
      {
        if ((_key == DIK_C && _Ctrl) && (_InTemplate || _InPopupUI)) exitwith {}; //this allows the use of Ctrl + C in the edit bars

        if ((_InTemplate||_InPopupUI)&&(_key == DIK_TAB)) then
        {
          _Return = True;
        } else {
          ['KeyDown',_EventHandlerInfo] call bis_fnc_arsenal;
        };
      };
    };
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "exit":
  {
    _ArsenalDisplay = _ArsenalIDD select 0;
    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

    [] spawn
    {
      sleep 0.2;
      VANA_fnc_DragDrop_InAction = nil;
      VANA_fnc_DragDrop_GetTargetTab = nil;
    };

    _Return = True;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "savedata":
  {
    _ArsenalDisplay = _ArsenalIDD select 0;
    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

    [_CtrlTreeView] call VANA_fnc_TreeViewSaveData;

    _Return = True;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "treedblclick":
  {
    _ArsenalDisplay = _ArsenalIDD select 0;
    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    _CtrlTemplateName = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;

    params ["_SelectedTab", "_TvData"];

    _SelectedTab = tvCurSel _CtrlTreeView; //Gets Selected tab
    _TvData = tolower (_CtrlTreeView tvData _SelectedTab); //Gets Data assigned to sellected SubTv

    if ((_TvData isequalto "tvloadout")) then
    {
      ['ButtonTemplateOK',[_ArsenalDisplay]] call VANA_fnc_ArsenalTreeView;
      _Return = True;
    };
    _Return = False;
  };

	///////////////////////////////////////////////////////////////////////////////////////////
	case "treeviewselchanged":
	{
		_ArsenalDisplay = _ArsenalIDD select 0;

		_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

    params ["_SelectedTab","_TvData"];

    _SelectedTab = tvCurSel _CtrlTreeView; //Gets Selected tab
    _TvData = tolower (_CtrlTreeView tvData _SelectedTab); //Gets Data assigned to sellected SubTv

    _CtrlTreeView setvariable ["DragDrop_InAction", nil];
    _CtrlTreeView setvariable ["DragDrop_ReleaseSubTv", nil];

    _CtrlVANA_DeleteButton = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_DeleteButton;
    _CtrlVANA_DeleteButton ctrlenable !(_SelectedTab isequalto []);

		_CtrlVANA_ButtonRename = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_ButtonRename;
		_CtrlVANA_ButtonRename ctrlenable !(_SelectedTab isequalto []); //Checks if anything is selected if False button gets dissabled

    _CtrlTemplateName = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
    _CtrlTemplateName ctrlsettext (_CtrlTreeView tvtext _SelectedTab);

    _CtrlVANA_OKButton = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OKButton;
    if (ctrlenabled _CtrlTemplateName) then
    {
      //--- Save
      _CtrlVANA_OKButton ctrlenable True;
    } else {
      //--- Load
      _CtrlVANA_OKButton ctrlenable ((_TvData isEqualto "tvloadout")&&((_CtrlTreeView tvValue _SelectedTab) >= 0)); //Checks if selected SubTv is a loadout and if its value is higher then -1 (menaing that the arsenal contains all required items for the loadout)
    };

    //--- Temp code
    _CtrlTempCheckbox = _ArsenalDisplay displayctrl 978005;
    if (Profilenamespace getvariable ['TEMP_Popup_Value', False]) then
    {
      _CtrlTempCheckbox cbSetChecked true;
    } else {
      _CtrlTempCheckbox cbSetChecked False;
    };

    _Return = True;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "loadbutton":
  {
    _ArsenalDisplay = _ArsenalIDD select 0;
    _CtrlVANA_OKButton = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OKButton;
    _CtrlVANA_DecorativeBar = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_DecorativeBar;

    _CtrlMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
    _CtrlMouseBlock ctrlenable True;
    ctrlsetfocus _ctrlMouseBlock;

    _CtrlVANA_OKButton ctrlsettext "Load";
    _CtrlVANA_DecorativeBar ctrlshow false;

    ['showMessage',[_ArsenalDisplay,"Note: Loadouts still require unique names, Tabs do not"]] call bis_fnc_arsenal;
    ['TreeViewSelChanged',[_ArsenalDisplay]] call VANA_fnc_ArsenalTreeView;

    _Return = True;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "savebutton":
  {
    _ArsenalDisplay = _ArsenalIDD select 0;
    _CtrlVANA_OKButton = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OKButton;
    _CtrlVANA_DecorativeBar = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_DecorativeBar;

    _CtrlMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
    _CtrlMouseBlock ctrlenable True;

    _CtrlTemplateName = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
    ctrlsetfocus _CtrlTemplateName;

    _CtrlVANA_OKButton ctrlsettext "Save";
    _CtrlVANA_DecorativeBar ctrlshow true;

    ['showMessage',[_ArsenalDisplay,"Note: Loadouts still require unique names, Tabs do not"]] call bis_fnc_arsenal;
    ['TreeViewSelChanged',[_ArsenalDisplay]] call VANA_fnc_ArsenalTreeView;

    _Return = True;
  };


  ///////////////////////////////////////////////////////////////////////////////////////////
	case "buttontemplateok": //Code taken from BIS_fnc_arsenal and modified to be compatible with Tv
  {
		_ArsenalDisplay = _ArsenalIDD select 0;
    _CtrlTemplateName = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

    Params ["_HideTemplate","_LoadoutName","_FncReturn","_TvParrent","_Center","_SelectedTab","_Inventory","_LoadoutData","_Name","_NameID","_Inventory","_InventoryCustom"];

    _SelectedTab = TvCursel _CtrlTreeView;
    _HideTemplate = True;

    if (ctrlenabled _CtrlTemplateName) then
    {
      //--- Save
      _LoadoutName = ctrltext _ctrlTemplateName;
      _FncReturn = [_CtrlTreeView, _LoadoutName] call VANA_fnc_SaveLoadout;
      if (_FncReturn isequaltype []) then
      {
        _TvParrent = +(_FncReturn select 0);

        _TvParrent resize ((Count _TvParrent)-1);

        [_CtrlTreeView, _TvParrent, False] call VANA_fnc_TreeViewSorting;
        [_CtrlTreeView] call VANA_fnc_TreeViewSaveData;
      };
    } else {
      //--- Load
      _Center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
      if ((_CtrlTreeView TvValue _SelectedTab) >= 0 && (_CtrlTreeView TvData _SelectedTab) isequalto "tvloadout") then {
        _Inventory = _CtrlTreeView TvText _SelectedTab;
        [_Center,[profilenamespace,_Inventory]] call bis_fnc_loadinventory;
        _Center switchmove "";

        //--- Load custom data
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

        ["ListSelectCurrent",[_display]] call bis_fnc_arsenal;
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

      ['TreeViewSelChanged',[_ArsenalDisplay]] call VANA_fnc_ArsenalTreeView;
    };

    _Return = True;
	};

  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "create":
  {
    _ArsenalDisplay = _ArsenalIDD select 0;
		_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

    params ["_FncReturn","_TvParrent"];
	 	_FncReturn = [_CtrlTreeView] call VANA_fnc_TvCreateTab;
    if !(isnil "_FncReturn") then
    {
      _TvParrent = +_FncReturn;

      _TvParrent resize ((Count _TvParrent)-1);

      ["TreeViewSelChanged",[_ArsenalDisplay]] call VANA_fnc_ArsenalTreeView;
      [_CtrlTreeView, _TvParrent, False] call VANA_fnc_TreeViewSorting;
      [_CtrlTreeView] call VANA_fnc_TreeViewSaveData;

      _Return = True;
    };

    _Return = False;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "delete":
  {
    _ArsenalDisplay = _ArsenalIDD select 0;
    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

    _TargetTab = tvCurSel _CtrlTreeView; //Gets Selected tab

    if !(_TargetTab isequalto []) then
    {
      if !(Profilenamespace getvariable ["TEMP_Popup_Value", False]) then
      {
        [
          _ArsenalDisplay,"Delete",
          {
            if (ctrlFade _CtrlTemplate == 0) then
            {
              private _FncReturn = [_CtrlTreeView, _TargetTab] call VANA_fnc_TvDelete;
              if (_FncReturn isequaltype []) then
              {
                _TvParrent = +_FncReturn;

                _TvParrent resize ((Count _TvParrent)-1);

                [_CtrlTreeView] call VANA_fnc_TreeViewSaveData;
                [_CtrlTreeView, _TvParrent, False] call VANA_fnc_TreeViewSorting;
                ["TreeViewSelChanged",[_ArsenalDisplay]] call VANA_fnc_ArsenalTreeView;
              };
            };
          },
          _TargetTab
        ] call VANA_fnc_TreeViewUIPopup;
      } else {
        private _FncReturn = [_CtrlTreeView] call VANA_fnc_TvDelete;
        if (_FncReturn isequaltype []) then
        {
          _TvParrent = +_FncReturn;

          _TvParrent resize ((Count _TvParrent)-1);

          [_CtrlTreeView] call VANA_fnc_TreeViewSaveData;
          [_CtrlTreeView, _TvParrent, False] call VANA_fnc_TreeViewSorting;
          ["TreeViewSelChanged",[_ArsenalDisplay]] call VANA_fnc_ArsenalTreeView;
        };
      };
    };
    _Return = True;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "rename":
  {
    _ArsenalDisplay = _ArsenalIDD select 0;
    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

    _TargetTab = tvCurSel _CtrlTreeView; //Gets Selected tab

    [
      _ArsenalDisplay,"Rename",
      {
        if (ctrlFade _CtrlTemplate == 0) then
        {
          params ["_Name","_FncReturn","_TvParrent"];
          _Name = ctrltext _CtrlRenameEdit;
          _FncReturn = [_CtrlTreeView, _Name, _TargetTab] call VANA_fnc_TvRename;
          if (_FncReturn isequaltype []) then
          {
            _TvParrent = +_FncReturn;

            _TvParrent resize ((Count _TvParrent)-1);

            ["TreeViewSelChanged",[_ArsenalDisplay]] call VANA_fnc_ArsenalTreeView;
            [_CtrlTreeView, _TvParrent, False] call VANA_fnc_TreeViewSorting;
            [_CtrlTreeView] call VANA_fnc_TreeViewSaveData;
          };
        };
      },
      _TargetTab
    ] call VANA_fnc_TreeViewUIPopup;

    _Return = True;
  };
};

_Return;
