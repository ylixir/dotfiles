#!/usr/bin/env lua

local p = require('posix.unistd')

run = {}
setmetatable(run, {
  __index = function(self, program)
    return function(...)
      return run.execute(program, ...) == 0
    end
  end,
})

function run.escape(...)
  local command = type(...) == 'table' and ... or { ... }
  for i, s in ipairs(command) do
    s = (tostring(s) or ''):gsub('"', '\\"')
    if s:find '[^A-Za-z0-9_."/-]' then
      s = '"' .. s .. '"'
    elseif s == '' then
      s = '""'
    end
    command[i] = s
  end
  return table.concat(command, ' ')
end

function run.execute(...)
  return os.execute(run.escape(...))
end


run.echo('hello')
