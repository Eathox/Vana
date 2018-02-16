disableserialization;

params
[
  ["_OptionName", "", [""]],
  ["_DefualtValue", nil],
  "_Return",
  "_VANAOptionsData"
];

_Return = _DefualtValue;
_OptionName = tolower _OptionName;
_VANAOptionsData = profilenamespace getvariable ["VANA_fnc_OptionsMenu_Data", []];
(_VANAOptionsData select {(_x select 0) isequalto _OptionName}) params [["_OptionArray", [_OptionName]]];

if (Count _OptionArray isequalto 2) then {_Return = (_OptionArray select 1)};

_Return
