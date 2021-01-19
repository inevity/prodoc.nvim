local utils = {}

function utils._split(s,reg)
  local split_table = {}
  for word in s:gmatch(reg) do table.insert(split_table, word) end
  return split_table
end

return utils
