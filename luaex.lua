local gen_c = function(program)
  local data = [=[#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

int main(int argc, char** argv) {
  lua_State *L;
  L = luaL_newstate();
  luaL_openlibs(L);

  char data[]=]

.. #program .. "];\n"

  local i = 0
  for c in program:gmatch(".") do
    data = data .. "data[" .. i .. "] = " .. string.byte(c) .. ";\n  "
    i = i + 1
  end

  data = data .. [=[

  luaL_dostring(L, data);

  lua_close(L);
  return 0;
}]=]

return data
end

local compile_c = function(c_data, outfile)
  local cfile_name = os.tmpname() .. ".c"
  local cfile = io.open(cfile_name, "w")
  cfile:write(c_data)
  cfile:close()
  os.execute("cc -o " .. tostring(outfile) .. " " .. tostring(cfile_name) .. " -Wall -I/usr/include/lua/5.3 -llua")
  os.remove(cfile_name)
end

local outfile = arg[1]
if outfile == nil then
  io.stderr:write("No file to process, quitting.")
  os.exit(-1)
else
  outfile=outfile:gsub("%.lua","")
end

local f = io.open(arg[1], "r")
local data = f:read("*all")
f:close()

if arg[2] == "c" then
  print(gen_c(data))
else
  compile_c(gen_c(data), outfile)
end
