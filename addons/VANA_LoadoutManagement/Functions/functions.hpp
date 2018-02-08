class VANA
{
  tag="VANA";

  class ButtonFNC
  {
    file = "\VANA_LoadoutManagement\Functions\Button";

    class TvCreateTab {};
    class TvDelete {};
    class TvRename {};
  };

  class CoreFNC
  {
    file = "\VANA_LoadoutManagement\Functions\Core";

    class Arsenal {};
    class ArsenalTreeView {};
    class SaveLoadout {};
    class DragDrop {};
    class TreeViewLoadData {};
    class TreeViewSaveData {};
    class TvCreateLoadout {};
    class Vana_Init {};
  };

  class UtilityFNC
  {
    file = "\VANA_LoadoutManagement\Functions\Utility";

    class TreeViewGetData {};
    class TreeViewSorting {};
    class TvCount {};
    class TvExists {};
    class TvGetPosition {};
    class UIPopup {};
  };
};
