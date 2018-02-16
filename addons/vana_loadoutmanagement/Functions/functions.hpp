class VANA
{
  tag="VANA";

  class Altered_BIS_Fnc
  {
    file="vana_LoadoutManagement\Functions";

    class Arsenal {};
    class Vana_Init {};
  };

  class OptionsMenu
  {
    file="vana_LoadoutManagement\Functions\OptionsMenu";

    class OptionsMenu {};
    class GetOptionValue {};
    class SetOptionValue {};
  };

  class TreeView
  {
    file="vana_LoadoutManagement\Functions\TreeView";

    class ArsenalTreeView {};

    //Buttons
    class TvCreateTab         {file="vana_LoadoutManagement\Functions\TreeView\Button\fn_TvCreateTab.sqf";};
    class TvDelete            {file="vana_LoadoutManagement\Functions\TreeView\Button\fn_TvDelete.sqf";};
    class TvRename            {file="vana_LoadoutManagement\Functions\TreeView\Button\fn_TvRename.sqf";};

    //Core
    class TvCreateLoadout     {file="vana_LoadoutManagement\Functions\TreeView\Core\fn_TvCreateLoadout.sqf";};
    class TvDragDrop          {file="vana_LoadoutManagement\Functions\TreeView\Core\fn_TvDragDrop.sqf";};
    class TvLoadData          {file="vana_LoadoutManagement\Functions\TreeView\Core\fn_TvLoadData.sqf";};
    class TvSaveData          {file="vana_LoadoutManagement\Functions\TreeView\Core\fn_TvSaveData.sqf";};
    class TvSaveLoadout       {file="vana_LoadoutManagement\Functions\TreeView\Core\fn_TvSaveLoadout.sqf";};
    class TvValidateLoadouts  {file="vana_LoadoutManagement\Functions\TreeView\Core\fn_TvValidateLoadouts.sqf";};

    //Utility
    class TvCount             {file="vana_LoadoutManagement\Functions\TreeView\Utility\fn_TvCount.sqf";};
    class TvExists            {file="vana_LoadoutManagement\Functions\TreeView\Utility\fn_TvExists.sqf";};
    class TvGetData           {file="vana_LoadoutManagement\Functions\TreeView\Utility\fn_TvGetData.sqf";};
    class TvGetParent         {file="vana_LoadoutManagement\Functions\TreeView\Utility\fn_TvGetParent.sqf";};
    class TvGetPosition       {file="vana_LoadoutManagement\Functions\TreeView\Utility\fn_TvGetPosition.sqf";};
    class TvSorting           {file="vana_LoadoutManagement\Functions\TreeView\Utility\fn_TvSorting.sqf";};
    class TvValidateLoadout   {file="vana_LoadoutManagement\Functions\TreeView\Utility\fn_TvValidateLoadout.sqf";};
  };

  class UIPopup
  {
    file="vana_LoadoutManagement\Functions\UIPopup";

    class UIPopup {};
  };
};
