local info = debug.getinfo(1, 'S');
local script_path = info.source:match [[^@?(.*[\/])[^\/]-$]];
-- GET SOCKETS DLL
local os = reaper.GetOS()
local sub_path = "socket/"
if os:match("Win") then
    sub_path = sub_path.."Win/"
    package.cpath = package.cpath .. ";" .. script_path .. sub_path .."core.dll;" -- Add current folder/socket module for looking at .so (need for loading basic luasocket)
elseif os:match("Other") then
    sub_path = sub_path .."Linux/"
    package.cpath = package.cpath .. ";" .. script_path .. sub_path.. "core.so;" -- Add current folder/socket module for looking at .so (need for loading basic luasocket)
else
    sub_path = sub_path .. "Mac/"
    package.cpath = package.cpath .. ";" .. script_path .. sub_path.. "core.so;" -- Add current folder/socket module for looking at .so (need for loading basic luasocket)
end
-- {
--     // Use IntelliSense to learn about possible attributes.
--     // Hover to view descriptions of existing attributes.
--     // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
--     "version": "0.2.0",
--     "configurations": [ 

--         {
--             "type": "lua",
--             "request": "attach",
--             "tag": "normal",
--             "name": "LuaPanda",
--             "cwd": "${workspaceFolder}",
--             "luaFileExtension": "",
--             "connectionPort": 8818,
--             "stopOnEntry": false,
--             "useCHook": true,
--             "autoPathMode": false
--         },
--     ]
-- }

--TERMINATE AND START SCRIPT IF DEBUGER STARTED (ALLOW SCRIPT STARTING AGAIN)
reaper.set_action_options(1|2)
-- PATH TO MODED LUAPANDA
local DEBUG = dofile(script_path .."LuaPanda.lua")
DEBUG.start("127.0.0.1", 8818)

return DEBUG
