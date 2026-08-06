local api = require("api")
local parse = require("lualib.parse")
local source = "settings"
local s = settings.startup

data:extend({{
  type = "mod-data",
  name = "bbexcavation-config-"..source,
  data_type = api.config.data_type,
  data = {

    source = source,

    surface_tile = parse.sc_key_string(s["bbexcavation-surface-tile"].value),

  }
}})
