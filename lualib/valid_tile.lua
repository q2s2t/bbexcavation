local get_tile = function ()
  tile = {}
  for k, _ in pairs(data.raw["tile"]) do repeat
    tile[k] = true
  until true end
  return tile
end

return get_tile()