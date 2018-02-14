disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

#define AllBackGroundLists\
  [\
    IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_VissualOptions_BackGroundList,\
    981201\
  ]

#define FadeBackgroundList(LIST,FADE)\
  LIST ctrlsetfade FADE;\
  LIST ctrlcommit 0;

#define ShowTemplateUI(BOOL)\
  Private _CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;\
  _CtrlTemplate ctrlsetfade ([1, 0] select BOOL);\
  _CtrlTemplate ctrlcommit 0;\
  _CtrlTemplate ctrlenable BOOL;\

params
[
  ["_ArsenalDisplay", displaynull, [displaynull]],
  ["_Mode", "", [""]],
  ["_Arguments", [], [[]]]
];

switch tolower _mode do
{
  ///////////////////////////////////////////////////////////////////////////////////////////
  case "init":
  {
    params ["_CtrlButtonApply","_CtrlButtonCancel"];

    _CtrlButtonApply = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_ButtonApply;
    _CtrlButtonApply ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'Apply'] call VANA_fnc_OptionsMenu;"];

    _CtrlButtonCancel = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_ButtonCancel;
    _CtrlButtonCancel ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'Cancel'] call VANA_fnc_OptionsMenu;"];

    {
      private _Ctrl = _ArsenalDisplay displayctrl _x;
      _Ctrl ctrladdeventhandler ["LBSelChanged", "[ctrlparent (_this select 0), 'ListCurSelChanged', [(_this select 0)]] call VANA_fnc_OptionsMenu;"];
    } foreach AllBackGroundLists;

    True
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

    _ctrlMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;\
    _ctrlMouseBlock ctrlenable True;

    _CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
    if (CtrlFade _CtrlTemplate < 1) then
    {
      _CtrlOptionsMenu setvariable ["TemplateWasOpen", True];

      ShowTemplateUI(False)
    };

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "close":
  {
    params ["_CtrlOptionsMenu"];

    _CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;
    _CtrlOptionsMenu ctrlenable False;
    _CtrlOptionsMenu ctrlshow False;

    if (_CtrlOptionsMenu getvariable ["TemplateWasOpen", False]) then
    {
      ShowTemplateUI(True)
    };

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "populatelist":
  {
    //this is called from RscVANABackGroundList 'Onload'

    _Arguments params
    [
      ["_CtrlBackGroundList", controlnull, [controlnull]],
      ["_CurrentConfig", confignull, [confignull]],
      "_ConfigParent",
      "_AllOptionTexts"
    ];

    _ConfigParent = (configHierarchy _CurrentConfig) select 7;
    _AllOptionTexts = "!isnil {(_x >> 'optiondescription') call BIS_fnc_getCfgData}" configClasses (_ConfigParent >> "controls");

    {
      params ["_OptionDescription", "_Index"];

      _OptionDescription = gettext (_x >> "optiondescription");
      _Index = _CtrlBackGroundList lbadd "";

      _CtrlBackGroundList lbsetdata [_index, _OptionDescription];
    } foreach _AllOptionTexts;

    (ctrlposition _CtrlBackGroundList) params ["_x","_y","_w","_h"];
    _CtrlBackGroundList ctrlsetposition [_x,_y,_w,(_h * lbSize _CtrlBackGroundList)];
    _CtrlBackGroundList ctrlcommit 0;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "listcurselchanged":
  {
    _Arguments params
    [
      ["_CtrlBackGroundList", controlnull, [controlnull]],
      "_CtrlDescription"
    ];

    _CtrlDescription = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_Description;
    _CtrlDescription ctrlsettext (_CtrlBackGroundList lbdata lbcursel _CtrlBackGroundList);

    FadeBackgroundList(_CtrlBackGroundList, 0)

    {
      private _Ctrl = _ArsenalDisplay displayctrl _x;
      if !(_Ctrl isequalto _CtrlBackGroundList) then {FadeBackgroundList(_Ctrl, 1)};
    } foreach AllBackGroundLists;
  };
};
