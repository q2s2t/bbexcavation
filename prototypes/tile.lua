local api = require("api")

for _, tile_name in pairs(api.config.surface_tile) do
  local tile = data.raw.tile[tile_name]
  tile.can_be_part_of_blueprint = true
  tile.placeable_by = { item = "bbexcavation-explosives", count = 1 }
end