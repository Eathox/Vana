class VANA
{
  tag="VANA";

  class Arsenal {};
  class Vana_Init {};

  //TreeView
  class TreeView
  {
    file = "\VANA_LoadoutManagement\Functions\TreeView";

    class ArsenalTreeView {};

    class Button
    {
      file = "\VANA_LoadoutManagement\Functions\TreeView\Button";

      class TvCreateTab {};
      class TvDelete {};
      class TvRename {};
    };

    class Core
    {
      file = "\VANA_LoadoutManagement\Functions\TreeView\Core";

      class TvCreateLoadout {};
      class TvDragDrop {};s
      class TvLoadData {};
      class TvSaveData {};
      class TvSaveLoadout {};
    };

    class Utility
    {
      file = "\VANA_LoadoutManagement\Functions\TreeView\Utility";

      class TvCount {};
      class TvExists {};
      class TvGetData {};
      class TvGetPosition {};
      class TvSorting {};
    };
  };

  //UIPopup
  class UIPopup
  {
    file = "\VANA_LoadoutManagement\Functions\UIPopup";

    class UIPopup {};
  };
};
