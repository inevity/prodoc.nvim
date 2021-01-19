local space = ' '
local api = vim.api
local _split = require('prodoc.utils')._split

local get_params = function(lnum,line)
  local params = {}
  -- check the function and arguments in one line
  if line:sub(line.len(line),-1) ~= '(' then
    local content = _split(line,'%((.*)%)')
    params = _split(content[1],'[^,%s]+')
  else
    local end_lnum = lnum
    while true do
      end_lnum = end_lnum + 1
      -- find the last paren of wrap arguments then get line number
      if api.nvim_buf_get_lines(0,end_lnum-1,end_lnum,true)[1]:sub(1,1) == ')' then
        break
      end
    end

    local wrap_arguments = api.nvim_buf_get_lines(0,lnum,end_lnum-1,true)
    for _,arg in ipairs(wrap_arguments) do
      local wrap_params = _split(arg,'[^,%s]+')
      for idx,v in ipairs(wrap_params) do
        if idx ~= #wrap_params then
          table.insert(params,v .. space ..wrap_params[#wrap_params] )
        end
      end
    end
  end
  return params
end

return {
  prefix = '//',
  get_params = get_params
}
