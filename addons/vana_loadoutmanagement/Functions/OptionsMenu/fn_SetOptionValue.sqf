disableserialization;

#define AllOptions\
  [\
    "deleteconfirmation"\
  ]

params
[
  ["_OptionName", "", [""]],
  ["_Value", nil],
  "_Location",
  "_VANAOptionsData",
  "_OptionArray"
];

_Location = -1;
_OptionName = tolower _OptionName;
_VANAOptionsData = profilenamespace getvariable ["VANA_fnc_OptionsMenu_Data", []];

if !(_OptionName in AllOptions) exitwith {False};

(_VANAOptionsData select {(_x select 0) isequalto _OptionName}) params [["_OptionArray", [_OptionName]]];
if (Count _OptionArray isequalto 2) then {_Location = _VANAOptionsData find _OptionArray};

_OptionArray set [1, _Value];

call ([{_VANAOptionsData set [_Location, _OptionArray]}, {_VANAOptionsData pushback _OptionArray}] select (_Location isequalto -1));

profilenamespace setvariable ["VANA_fnc_OptionsMenu_Data", _VANAOptionsData];
saveprofilenamespace;

True
