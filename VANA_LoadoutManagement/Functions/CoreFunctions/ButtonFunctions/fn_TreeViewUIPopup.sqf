disableserialization;

#include "\VANA_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\VANA_LoadoutManagement\UI\defineResinclDesign.inc"

params
[
  ["_ArsenalDisplay", displaynull, [displaynull]],
  ["_Mode", "False", [""]],
  ["_Script", {}, [{}]],
  ["_TargetTab", [], [[]]],
  ["_Result", False, [False]]
];

//--- Declare UI controls
_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
_CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
_CtrlUIPopup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_UIPopupControlGroup;
_CtrlVanaMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_Mouseblock;
_CtrlTitle = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_Title;
_CtrlBackGround = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_BackGround;
_CtrlTextMessage = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_Text;
_CtrlBackGroundButtonMiddle = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_BackgroundButtonMiddle;
_CtrlButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonOK;
_CtrlButtonCancel = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_ButtonCancel;
_CtrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_TogglePopup;
_CtrlPopupCheckBoxText = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_CheckboxText;
_CtrlHintText = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_HintText;
_CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENALPOPUP_VANA_RenameEdit;
_AllControls = [_CtrlTreeView,_CtrlTemplate,_CtrlUIPopup,_CtrlVanaMouseBlock,_CtrlTitle,_CtrlBackGround,_CtrlTextMessage,_CtrlBackGroundButtonMiddle,_CtrlButtonOk,_CtrlButtonCancel,_CtrlPopupCheckBox,_CtrlPopupCheckBoxText,_CtrlHintText,_CtrlRenameEdit];

switch (toLower _Mode) do
{
  ///////////////////////////////////////////////////////////////////////////////////////////
  case "clicked":
  {
    params ["_Script","_TargetTab"];

    _Script = _CtrlUIPopup getvariable ["VANA_fnc_TreeViewUIPopup_Script",{}];
    _TargetTab = _CtrlUIPopup getvariable ["VANA_fnc_TreeViewUIPopup_TargetTab",[]];

    _CtrlUIPopup setvariable ["VANA_fnc_TreeViewUIPopup_Script",nil];
    _CtrlUIPopup setvariable ["VANA_fnc_TreeViewUIPopup_TargetTab",nil];
    //_CtrlUIPopup setvariable ['VANA_fnc_TreeViewUIPopup_DefaultPositions',nil];

    if (_Result) then
    {
      call _Script;
    };

    _CtrlUIPopup ctrlshow False; //Hide UI
    _CtrlVanaMouseBlock ctrlshow false; //Hide MouseBlock

    if (ctrlFade _CtrlTemplate == 0) then
    {
      ctrlsetfocus _CtrlTemplate;
    };

    True;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "delete":
  {
    params ["_TargetTab","_TvText","_TvData"];

    _CtrlUIPopup ctrlshow True; //Show UI
    _CtrlVanaMouseBlock ctrlshow True; //Show MouseBlock
    _CtrlRenameEdit ctrlshow False; //Hide Rename UI parts

    //--- Show Delete UI parts
    {
      _x ctrlshow True;
    } foreach [_CtrlPopupCheckBox,_CtrlPopupCheckBoxText,_CtrlHintText];
    ctrlSetFocus _CtrlPopupCheckBox;

    //--- Apply header and Message text
    _TargetTab = tvCurSel _CtrlTreeView;
    _TvText = _CtrlTreeView tvtext _TargetTab;
    _TvData = tolower (_CtrlTreeView tvData _TargetTab);
    switch _TvData do
    {
      case "tvtab":
      {
        _TvData = "Tab";
      };
      case "tvloadout":
      {
        _TvData = "Loadout";
      };
    };

    _CtrlTitle ctrlsettext "Delete Confirmation";
    _CtrlTextMessage ctrlsetstructuredtext parsetext format ["Delete: %1 (Type: %2)?",_TvText,_TvData];

    //--- Save Script and TargetTab
    _CtrlUIPopup setvariable ["VANA_fnc_TreeViewUIPopup_Script",_Script];
    _CtrlUIPopup setvariable ["VANA_fnc_TreeViewUIPopup_TargetTab",_TargetTab];

    //--- Set checkbox state
    if !(Profilenamespace getvariable ['TEMP_Popup_Value', False]) then
    {
      _CtrlPopupCheckBox cbSetChecked False;
    };

    True;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  Case "rename":
  {
    params ["_TargetTab","_TvText","_TvData"];

    _CtrlUIPopup ctrlshow True; //Show UI
    _CtrlVanaMouseBlock ctrlshow True; //Show MouseBlock
    _CtrlRenameEdit ctrlshow True; //Show Rename UI Parts
    ctrlSetFocus _CtrlRenameEdit;

    //--- Hide Delete UI parts
    {
      _x ctrlshow False;
    } foreach [_CtrlPopupCheckBox,_CtrlPopupCheckBoxText,_CtrlHintText];

    //--- Apply header, Message text and clear Rename field
    _TargetTab = tvCurSel _CtrlTreeView;
    _TvText = _CtrlTreeView tvtext _TargetTab;
    _TvData = tolower (_CtrlTreeView tvData _TargetTab);
    switch _TvData do
    {
      case "tvtab":
      {
        _TvData = "Tab";
      };
      case "tvloadout":
      {
        _TvData = "Loadout";
      };
    };

    _CtrlRenameEdit ctrlsettext "";
    _CtrlRenameEdit ctrlsettext (_CtrlTreeView tvtext _TargetTab);
    _CtrlTitle ctrlsettext "Rename Confirmation";
    _CtrlTextMessage ctrlsetstructuredtext parsetext format ["Rename '%1' (Type: %2) to:",_TvText,_TvData];


    //--- Save Script and TargetTab
    _CtrlUIPopup setvariable ["VANA_fnc_TreeViewUIPopup_Script",_Script];
    _CtrlUIPopup setvariable ["VANA_fnc_TreeViewUIPopup_TargetTab",_TargetTab];

    True;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "mouseblockfocus":
  {
    if (ctrlshown _CtrlUIPopup) then
    {
      switch (tolower (ctrltext _CtrlTitle)) do
      {
        case "delete confirmation":
        {
          ctrlSetFocus _CtrlPopupCheckBox;
        };
        case "rename confirmation":
        {
          ctrlSetFocus _CtrlRenameEdit;
        };
      };
      True;
    };
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  Default {False;};
};
