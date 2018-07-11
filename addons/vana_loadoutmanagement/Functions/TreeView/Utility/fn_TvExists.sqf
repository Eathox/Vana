disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

params [
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_TargetTv", (tvCurSel (_this select 0 displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME)), [[]]],
	"_CtrlTreeView",
	"_HasName",
	"_HasData"
];

_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

//Check if Text and Data are defined
_HasName = !(_CtrlTreeView tvText _TargetTv isequalto "");
_HasData = !(_CtrlTreeView tvdata _TargetTv isequalto "");

[False, True] select (_HasName && _HasData)
