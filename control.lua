local api = require("api")
api.init_control()

local place_tiles = function(entity, target)
  local surface = entity.surface.name
  if not api.config.surface_tile[surface] then surface = "any" end
  local fill = api.config.surface_tile[surface]
  for _, tile in pairs(target) do
    entity.surface.create_entity({
      name = "big-explosion",
      force = entity.force,
      position = { tile.position.x + 0.5, tile.position.y + 0.5 }
    })
    if fill == "ignore" then tile.name = tile.old_tile.name
    else tile.name = fill end
  end
  if fill then entity.surface.set_tiles(target) end
end

script.on_event(defines.events.on_player_built_tile, function(event)
  if not event.item then return end
  if not event.item.valid then return end
  if event.item.name ~= "bbexcavation-explosives" then return end
  place_tiles(game.players[event.player_index], event.tiles)
end)

script.on_event(defines.events.on_robot_built_tile, function(event)
  if not event.item then return end
  if not event.item.valid then return end
  if event.item.name ~= "bbexcavation-explosives" then return end
  place_tiles(event.robot, event.tiles)
end)

--FIXME Offshore pumps. When a blueprint containing excavation tiles and offshore pumps is created Factorio can initialize the pumps before Blueberry Excavation replaces the tiles with the destination surface's fluid. Offshore pumps cache their source fluid when created and do not detect a later scripted tile replacement, leaving them unable to pump. The fix of deleting/replacing them works but it also degrades the undo/redo stack.
