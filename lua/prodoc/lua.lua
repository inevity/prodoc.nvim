local get_params = function(_,line,_split)
  local params = {}
  local content = _split(line,'%((.*)%)')
  params = _split(content[1],'[^,%s]+')
  return params
end

return {
  prefix = '--',
  get_params = get_params
}
