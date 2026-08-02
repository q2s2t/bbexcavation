local api = require("api")
local source = "settings"

data:extend({{
  type = "mod-data",
  name = "bbexcavation-config-"..source,
  data_type = api.config_data_type,
  data = {

    source = source,

    surface_tile = api.parse_semicolon_key_string(
      settings.startup["bbexcavation-surface-tile"].value),

  }
}})
