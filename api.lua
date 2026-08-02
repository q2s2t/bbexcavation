-- TODO keep align wth major version changes (v1, v2, v3)
local NAME = "bbexcavation"
local VERSION = "v0"

local api = {
  name = NAME,
  version = VERSION,
  stage_settings = {},
  stage_proto = {},
  stage_runtime = {},
  warnings = {}, -- stores warnings for the current stage
  config = {} -- stores config for the current stage
}

-- -----------------------------------------------------------------------------
-- Settings stage
-- -----------------------------------------------------------------------------

api.stage_settings.init = function () end

-- -----------------------------------------------------------------------------
-- Prototype stage
-- -----------------------------------------------------------------------------

api.stage_proto.init = function ()
  data:extend({{
    type = "mod-data",
    name = api.name,
    data_type = api.name..".warnings."..api.version,
    data = { 
      warnings = {},
      config = {},
    } } })
    api.warnings = data.raw["mod-data"][api.name].data.warnings
    api.config = data.raw["mod-data"][api.name].data.config
    api.config_data_type = api.name..".config."..api.version
end

-- config load order is:
-- 1. this mod configuration, declared in `data.lua`
-- 2. other mod configuration, declared in their `data-updates.lua`.
-- 3. user settings, inserted at the end of the list through mod-data
api.stage_proto.apply_config = function (cb)
  for _, mod_data in pairs(data.raw["mod-data"]) do
    if mod_data.data_type == api.config_data_type then
      cb(mod_data.data)
    end
  end
  return api.config
end

-- -----------------------------------------------------------------------------
-- Runtime stage
-- -----------------------------------------------------------------------------

api.stage_runtime.init = function ()
  api.config = prototypes.mod_data[api.name].data.config
  script.on_configuration_changed(function ()
    for _, player in pairs(game.players) do
      api.stage_runtime.show_warnings(player)
    end
  end)
end

api.stage_runtime.show_warnings = function (player)
  local proto_warnings = prototypes.mod_data[api.name].data.warnings
  if #proto_warnings > 0 then
    player.print("[color=yellow]["..api.name.."] has warnings. Check factorio-current.log[/color]")
    for _, w in pairs(proto_warnings) do
      player.print("[color=yellow]["..api.name.."] "..w.."[/color]")
    end
  end
  local runtime_warnings = api.warnings
  if #runtime_warnings > 0 then
    player.print("[color=yellow]["..api.name.."] has runtime warnings:[/color]")
    for _, w in pairs(runtime_warnings) do
      player.print("[color=yellow]["..api.name.."] "..w.."[/color]")
    end
  end
end

-- -----------------------------------------------------------------------------
-- Auto-init (not in use)
-- -----------------------------------------------------------------------------

--- @return "stage_settings"|"stage_proto"|"stage_runtime"|false
api.stage = (function ()
  if settings and not data and not game then return "stage_settings"
  elseif data then return "stage_proto"
  else return "stage_runtime" end
end)()


-- -----------------------------------------------------------------------------
-- Utils
-- -----------------------------------------------------------------------------

---Validate and optionally runs recovery logic.
---@param msg string message to print and add to warnings list
---@param v boolean validation test
---@param recovery function? callback when validation fails.
api.validate = function (msg, v, recovery)
  if not v then
    log(msg)
    table.insert(api.warnings, msg)
    if recovery then recovery() end
    return false
  end
  return true
end

---Parse a semicolon-separated list of key-value pairs into a table.
---Whitespace is ignored.
---@param str string string in the form "key1=value1;key2=value2"
---@return table<k , v>
api.parse_semicolon_key_string = function (str)
  str = str:gsub("%s+", "")
  local r = {}
  for inner_semicolon in str:gmatch("[^;]+") do
    local k, v = inner_semicolon:match("^([%w_-]+)=([%w_-]+)$")
    if api.validate(
      "Invalid definition: \""..inner_semicolon.."\". It should be \"key1=value1;key2=value2\" instead.",
      k and v)
    then
      r[k] = v
    end
  end
  return r
end

return api
