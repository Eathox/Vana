disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

#define ShowUI(BOOL)\
  Private _CtrlTvUIPopup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_UIPopup;\
  Private _CtrlVanaMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_Mouseblock;\
  {_x ctrlshow BOOL; _x ctrlenable BOOL;} foreach [_CtrlTvUIPopup,_CtrlVanaMouseBlock];

#define ShowDeleteUI(BOOL)\
  Private _CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;\
  Private _CtrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_TogglePopup;\
  Private _CtrlPopupCheckBoxText = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_CheckboxText;\
  Private _CtrlHintText = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_HintText;\
  _CtrlRenameEdit ctrlshow !BOOL;\
  {_x ctrlshow BOOL;} foreach [_CtrlPopupCheckBox,_CtrlPopupCheckBoxText,_CtrlHintText];

#define TvInfo\
  _TargetTv = tvCurSel _CtrlTreeView;\
  _TvName = _CtrlTreeView tvtext _TargetTv;\
  _TvData = tolower (_CtrlTreeView tvData _TargetTv);\
  _TvDataString = ["Tab", "Loadout"] select (_TvData isequalto "tvloadout");

params
[
  ["_ArsenalDisplay", displaynull, [displaynull]],
  ["_Mode", "", [""]]
];

switch (toLower _Mode) do
{
  ///////////////////////////////////////////////////////////////////////////////////////////
  case "init":
  {
    params ["_CtrlRenameEdit","_CtrlButtonCancel","_CtrlButtonOk","_CtrlPopupCheckBox"];

    //Hide Vana dint init popup
    ShowUI(False)

    //Apply Event handlers
    _CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;
    _CtrlRenameEdit ctrladdeventhandler ["killFocus","[ctrlparent (_this select 0),'KeepFocus'] spawn VANA_fnc_UIPopup;"];
    _CtrlRenameEdit ctrladdeventhandler ["KeyDown","[ctrlparent (_this select 0),'CheckNameTaken'] spawn VANA_fnc_UIPopup;"];
    _CtrlRenameEdit ctrladdeventhandler ["char","[ctrlparent (_this select 0),'CheckNameTaken'] spawn VANA_fnc_UIPopup;"];

    _CtrlButtonCancel = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_ButtonCancel;
    _CtrlButtonCancel ctrladdeventhandler ["buttonclick","(ctrlParent (_this select 0) displayctrl 979000) setvariable ['TvUIPopup_Status', false]"];

    _CtrlButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_ButtonOK;
    _CtrlButtonOk ctrladdeventhandler ["buttonclick","(ctrlParent (_this select 0) displayctrl 979000) setvariable ['TvUIPopup_Status', true]"];

    _CtrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_TogglePopup;
    _CtrlPopupCheckBox ctrladdeventhandler ["killFocus","[ctrlparent (_this select 0), 'KeepFocus'] spawn VANA_fnc_UIPopup;"];
    _CtrlPopupCheckBox ctrladdeventhandler ["CheckedChanged","['DeleteConfirmation', !(['DeleteConfirmation', True] call VANA_fnc_GetOptionValue)] call VANA_fnc_SetOptionValue; [ctrlparent (_this select 0),'UpDateCheckBox'] call VANA_fnc_ArsenalTreeView;"];
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "waituntilstatus":
  {
    params ["_CtrlTemplate","_CtrlTvUIPopup","_CtrlRenameEdit","_Status"];

    _CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
    _CtrlTvUIPopup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_UIPopup;
    _CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;

    //Waituntil Confirm or cancel button was pressed
    waituntil {!isnil {_CtrlTvUIPopup getvariable "TvUIPopup_Status"}};
    _Status = (_CtrlTvUIPopup getvariable "TvUIPopup_Status");

    ShowUI(False)

    _CtrlTvUIPopup setvariable ["TvUIPopup_Status",nil];
    ctrlsetfocus _CtrlTemplate;

    _Status
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "keepfocus":
  {
    params ["_CtrlTvUIPopup","_CtrlPopupCheckBox","_CtrlRenameEdit"];

    _CtrlTvUIPopup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_UIPopup;
    _CtrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_TogglePopup;
    _CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;

    //Keep focus on Popup UI
    if (ctrlshown _CtrlTvUIPopup) exitwith
    {
      ctrlSetFocus ([_CtrlRenameEdit, _CtrlPopupCheckBox] select (ctrlshown _CtrlPopupCheckBox));

      True
    };
    False
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "delete":
  {
    params ["_CtrlTreeView","_CtrlTitle","_CtrlTextMessage","_CtrlButtonOk","_CtrlPopupCheckBox","_TargetTv","_TvName","_TvData","_TvDataString"];

    ShowUI(True)

    //Show Delete UI
    ShowDeleteUI(True)

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    TvInfo

    //Apply header and Message text
    _CtrlTitle = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_Title;
    _CtrlTitle ctrlsettext "Delete Confirmation";

    _CtrlTextMessage = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_Text;
    _CtrlTextMessage ctrlsetstructuredtext parsetext format ["Delete %1: '%2'",_TvDataString, _TvName];

    _CtrlButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_ButtonOK;
    _CtrlButtonOk ctrlenable True;

    //Set checkbox state
    _CtrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_TogglePopup;
    _CtrlPopupCheckBox cbSetChecked !(["DeleteConfirmation", True] call VANA_fnc_GetOptionValue);
    ctrlSetFocus _CtrlPopupCheckBox;

    [_ArsenalDisplay,"WaituntilStatus"] call VANA_fnc_UIPopup;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "rename":
  {
    params ["_CtrlTreeView","_CtrlTitle","_CtrlRenameEdit","_TargetTv","_TvName","_TvData","_TvDataString"];

    ShowUI(True)

    //Show Rename UI
    ShowDeleteUI(False)
    ctrlSetFocus _CtrlRenameEdit;

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    TvInfo

    //Apply header, Message text and clear Rename field
    _CtrlTitle = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_Title;
    _CtrlTitle ctrlsettext "Rename Confirmation";

    _CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;
    _CtrlRenameEdit ctrlsettext "";
    _CtrlRenameEdit ctrlsettext _TvName;

    _CtrlTextMessage = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_Text;
    _CtrlTextMessage ctrlsetstructuredtext parsetext format ["Rename %1: '%2'",_TvDataString, _TvName];

    [_ArsenalDisplay,"CheckNameTaken"] call VANA_fnc_UIPopup;
    [_ArsenalDisplay,"WaituntilStatus"] call VANA_fnc_UIPopup;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "import":
  {
    params ["_CtrlTreeView","_CtrlTitle","_CtrlTextMessage","_CtrlButtonOk"];

    ShowUI(True)

    //Show Delete UI
    ShowDeleteUI(True)
    ctrlSetFocus _CtrlPopupCheckBox;

    //Apply header and Message text
    _CtrlTitle = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_Title;
    _CtrlTitle ctrlsettext "Import Confirmation";

    _CtrlTextMessage = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_Text;
    _CtrlTextMessage ctrlsetstructuredtext parsetext "This will overwride all current data";

    _CtrlButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_ButtonOK;
    _CtrlButtonOk ctrlenable True;
    
    [_ArsenalDisplay, "WaituntilStatus"] call VANA_fnc_UIPopup;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "checknametaken":
  {
    params ["_CtrlTreeView","_CtrlRenameEdit","_CtrlButtonOk","_SavedLoadouts","_Name","_TargetTv","_TvName","_TvData","_TvDataString","_Duplicate"];

    _CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
    _CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;
    _CtrlButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_ButtonOK;
    _SavedLoadouts = (profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]]) select {_x isequaltype ""};

    _Name = ctrltext _CtrlRenameEdit;
    TvInfo

    //Check if name duplicate and color edit field accordingly
    _Duplicate = [False, _Name in _SavedLoadouts] select (_TvData isequalto "tvloadout");
    _CtrlButtonOk ctrlenable ([True, False] select (_Duplicate || _Name isequalto "" || _Name isequalto _TvName));

    _Duplicate
  };
};
