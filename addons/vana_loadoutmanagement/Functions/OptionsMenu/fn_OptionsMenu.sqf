disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

#define IDCS_Lists\
  [\
    IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_BackGroundList\
  ]

#define ListFade(LIST,FADE)\
  LIST ctrlsetfade FADE;\
  LIST ctrlcommit 0;

#define ListBlink(LIST,FADE)\
  LIST ctrlsetfade FADE;\
  LIST ctrlcommit 1.2;\
  if(CtrlFade LIST == 1) exitwith {ListFade(LIST,1)};\
  UiSleep 1.2;

#define ShowTemplateUI(BOOL)\
  params ["_CtrlTemplate","_ctrlMouseBlock"];\
  _CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;\
  if(BOOL)then{ctrlsetfocus _CtrlTemplate};\
  _CtrlTemplate ctrlsetfade ([1, 0] select BOOL);\
  _CtrlTemplate ctrlcommit 0;\
  _CtrlTemplate ctrlenable BOOL;\
  _ctrlMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;\
  _ctrlMouseBlock ctrlenable BOOL;\
  _ctrlMouseBlock ctrlshow BOOL;

params
[
  ["_ArsenalDisplay", displaynull, [displaynull]],
  ["_Mode", "", [""]],
  ["_Arguments", [], [[]]]
];

switch (tolower _mode) do
{
  ///////////////////////////////////////////////////////////////////////////////////////////
  case "init":
  {
    params ["_CtrlOptionsMenu","_CtrlButtonApply","_CtrlButtonCancel","_CtrlMiscOptions_ExportButton","_CtrlMiscOptions_ImportButton"];

    _CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;
    _CtrlOptionsMenu ctrladdeventhandler ["MouseButtonDown","Private _CtrlList = (_this select 0) getvariable 'BlinkingList'; ctrlsetfocus ((ctrlparent _CtrlList) displayctrl (_CtrlList lbvalue lbcursel _CtrlList));"];

    _CtrlButtonApply = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_ButtonApply;
    _CtrlButtonApply ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'Apply'] call VANA_fnc_OptionsMenu;"];

    _CtrlButtonCancel = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_ButtonCancel;
    _CtrlButtonCancel ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'Cancel'] call VANA_fnc_OptionsMenu;"];

    _CtrlMiscOptions_ExportButton = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_ExportButton;
    _CtrlMiscOptions_ExportButton ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'ExportButton'] call VANA_fnc_OptionsMenu;"];

    _CtrlMiscOptions_ImportButton = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_ImportButton;
    _CtrlMiscOptions_ImportButton ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'ImportButton'] spawn VANA_fnc_OptionsMenu;"];

    [_ArsenalDisplay, "ToUpper"] Spawn VANA_fnc_OptionsMenu;
    [_ArsenalDisplay, "PopulateLists"] call VANA_fnc_OptionsMenu;

    {
      private _CtrlList = _ArsenalDisplay displayctrl _x;
      _CtrlList ctrladdeventhandler ["LBSelChanged","[ctrlparent (_this select 0), 'ListCurSelChanged', [(_this select 0)]] call VANA_fnc_OptionsMenu;"];
      _CtrlList ctrladdeventhandler ["MouseButtonDown","Private _CtrlList = _this select 0; ctrlsetfocus ((ctrlparent _CtrlList) displayctrl (_CtrlList lbvalue lbcursel _CtrlList));"];

      if (_x isequalto (IDCS_Lists select 0)) then
      {
        _CtrlList lbsetcursel 0;
        [_ArsenalDisplay, "ListBlink", [_CtrlList]] spawn VANA_fnc_OptionsMenu;
      };
    } foreach IDCS_Lists;

    //Porting over old Varibale to new system
    if !(isnil {Profilenamespace getvariable "TEMP_Popup_Value"}) then
    {
      ["DeleteConfirmation", (Profilenamespace getvariable "TEMP_Popup_Value")] call VANA_fnc_SetOptionValue;
      Profilenamespace setvariable ["TEMP_Popup_Value", nil];
    };

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "toupper":
  {
    {
      Private _ctrl = _x select 0;
      _Ctrl ctrlSetText (toUpper CtrlText _Ctrl);
    } foreach (UiNameSpace getvariable "VANA_OptionsMenu_ToUpper"); //Elements are added to this array from RscVANAOptionCategoryTitle, RscVANAOptionText and RscVANAOptionButton 'Onload'

    UiNameSpace setvariable ["VANA_OptionsMenu_ToUpper", nil];
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "populatelists":
  {
    {
      _x params
      [
        ["_CtrlList", controlnull, [controlnull]],
        ["_CurrentConfig", confignull, [confignull]],
        "_ConfigParent",
        "_AllOptionTexts",
        "_AllOptionButtons"
      ];

      _ConfigParent = (configHierarchy _CurrentConfig) select 7;
      _AllOptionTexts = "!isnil {(_x >> 'optiondescription') call BIS_fnc_getCfgData}" configClasses (_ConfigParent >> "controls");
      _AllOptionButtons = "!isnil {(_x >> 'index') call BIS_fnc_getCfgData}" configClasses (_ConfigParent >> "controls");

      {
        params ["_OptionDescription", "_OptioButtonIdc", "_Index"];

        _OptionDescription = gettext (_x >> "optiondescription");
        _OptioButtonIdc = getnumber (_x >> "optionbuttonidc");
        _Index = _CtrlList lbadd "";

        _CtrlList lbsetdata [_index, _OptionDescription];
        _CtrlList lbsetvalue [_index, _OptioButtonIdc];
      } foreach _AllOptionTexts;

      (ctrlposition _CtrlList) params ["_x","_y","_w","_h"];
      _CtrlList ctrlsetposition [_x,_y,_w,(_h * lbSize _CtrlList)];
      _CtrlList ctrlcommit 0;

      {
        params ["_Ctrl","_Script"];

        _Ctrl = _ArsenalDisplay displayctrl ((_x >> "idc") call BIS_fnc_getCfgData);
        _Ctrl setvariable ["_Arguments", [_CtrlList, ((_x >> "index") call BIS_fnc_getCfgData)]];

        _Script =
        {
          params ["_Arguments","_CtrlList","_Index","_CtrlOptionsMenu","_CtrlBlinkingList"];

          _Arguments = (_this select 0) getvariable "_Arguments";
          _CtrlList = _Arguments select 0;
          _Index = _Arguments Select 1;

          _CtrlOptionsMenu = (Ctrlparent _CtrlList) displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;
          _CtrlBlinkingList = _CtrlOptionsMenu getvariable "BlinkingList";

          If (_CtrlBlinkingList isequalto _CtrlList && lbcursel _CtrlBlinkingList isequalto _Index) exitwith {};
          _CtrlList lbsetcursel _Index;
        };

        _Ctrl ctrladdeventhandler ["ButtonDown", _Script];
      } foreach _AllOptionButtons;
    } foreach (UiNameSpace getvariable "VANA_OptionsMenu_PopulateLists"); //Elements are added to this array from RscVANABackGroundList 'Onload'
    UiNameSpace setvariable ["VANA_OptionsMenu_PopulateLists", nil];
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "apply":
  {


    [_ArsenalDisplay, "Close"] call VANA_fnc_OptionsMenu;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "cancel":
  {


    [_ArsenalDisplay, "Close"] call VANA_fnc_OptionsMenu;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "open":
  {
    params ["_CtrlOptionsMenu","_ctrlMouseBlock","_CtrlTemplate"];

    _CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;
    _CtrlOptionsMenu ctrlenable True;
    _CtrlOptionsMenu ctrlshow True;

    _CtrlMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
    _CtrlMouseBlock ctrlenable True;

    _CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
    _InTemplate = ctrlFade _CtrlTemplate == 0;

    _CtrlOptionsMenu setvariable ["TemplateWasOpen", ([False, True] select _InTemplate)];
    if _InTemplate then {ShowTemplateUI(False)};

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "close":
  {
    params ["_CtrlOptionsMenu","_CtrlBUTTONOK","_GoToTemplate"];

    _CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;
    _CtrlOptionsMenu ctrlenable False;
    _CtrlOptionsMenu ctrlshow False;

    _GoToTemplate = _CtrlOptionsMenu getvariable ["TemplateWasOpen", False];
    if (_ArsenalDisplay getvariable ["ControlIsBeingHeld", False]) then {_GoToTemplate = !_GoToTemplate};

    if _GoToTemplate then
    {
      ShowTemplateUI(True)
    } else {
      _CtrlBUTTONOK = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONOK;
      ctrlsetfocus _CtrlBUTTONOK;
    };

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "exportbutton":
  {
    params ["_VanaData","_LoadoutData","_Spacer"];

    if ismultiplayer exitwith {["showMessage",[_ArsenalDisplay, "Data export disabled when in multiplayer"]] spawn BIS_fnc_arsenal};

    _VanaData = profilenamespace getvariable ["VANA_fnc_TreeViewSave_Data",[]];
    _LoadoutData = profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]];

    _Spacer = (toString [13,10]) + "||" + (toString [13,10]);
    copytoclipboard ([_VanaData, _LoadoutData] joinstring _Spacer);

    ["showMessage",[_ArsenalDisplay, localize "STR_a3_RscDisplayArsenal_message_clipboard"]] spawn BIS_fnc_arsenal;
    true
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "importbutton": {[_ArsenalDisplay] call VANA_fnc_TvImport};

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "listcurselchanged":
  {
    _Arguments params
    [
      ["_CtrlList", controlnull, [controlnull]],
      "_CtrlOptionButton",
      "_CtrlDescription",
      "_CtrlOptionsMenu"
    ];

    _CtrlOptionButton = _ArsenalDisplay displayctrl (_CtrlList lbvalue lbcursel _CtrlList);
    ctrlsetfocus _CtrlOptionButton;

    _CtrlDescription = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_Description;
    _CtrlDescription ctrlSetStructuredText parseText (_CtrlList lbdata lbcursel _CtrlList);

    _CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;
    if !((_CtrlOptionsMenu getvariable "BlinkingList") isequalto _CtrlList) then
    {
      ListFade(_CtrlList, 0)
      [_ArsenalDisplay, "ListBlink", [_CtrlList]] spawn VANA_fnc_OptionsMenu;

      {
        private _Ctrl = _ArsenalDisplay displayctrl _x;
        if !(_Ctrl isequalto _CtrlList) then {ListFade(_Ctrl, 1)};
      } foreach IDCS_Lists;
    };

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "listblink":
  {
    _Arguments params
    [
      ["_CtrlList", controlnull, [controlnull]],
      "_CtrlOptionsMenu"
    ];

    _CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;

    if ((_CtrlOptionsMenu getvariable "BlinkingList") isequalto _CtrlList) exitwith {};
    _CtrlOptionsMenu setvariable ["BlinkingList", _CtrlList];

    while {CtrlFade _CtrlList < 1} do
    {
      ListBlink(_CtrlList, 0.55)
      ListBlink(_CtrlList, 0.20)
    };
  };
};
