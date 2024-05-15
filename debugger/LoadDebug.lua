local info = debug.getinfo(1, 'S');
local caller_info = debug.getinfo(3, 'S');
local caller_path = caller_info.source:match [[^@?(.*[\/])[^\/]-$]];
local script_path = info.source:match [[^@?(.*[\/])[^\/]-$]];
local platform = reaper.GetOS()

-- CHECK IF PROFILER IS INSTALLED
local profiler_path = reaper.GetResourcePath() .. '/Scripts/ReaTeam Scripts/Development/cfillion_Lua profiler.lua'

if not reaper.file_exists(profiler_path) then
    reaper.ShowMessageBox("Need Additional Packages.\nPlease Install it in next window", "MISSING DEPENDENCIES", 0)
    reaper.ReaPack_BrowsePackages('"Lua profiler"')
    return true
end

-- GET SOCKETS DLL
local sub_path = ""
if platform:match("Win") then
    sub_path = sub_path .. "Modules/Win/"
    package.cpath = package.cpath ..
        ";" ..
        script_path ..
        sub_path .. "?.dll"                   -- Add current folder/socket module for looking at .dll
elseif platform:match("Other") then
    sub_path = sub_path .. "Modules/Linux/"
    package.cpath = package.cpath ..
        ";" ..
        script_path ..
        sub_path .. "?.so"                   -- Add current folder/socket module for looking at .so
else
    sub_path = sub_path .. "Modules/Mac/"
    package.cpath = package.cpath ..
        ";" ..
        script_path ..
        sub_path .. "?.so"                   -- Add current folder/socket module for looking at .so
end

-- Reaper V7 check (this option is only available in certain version of V7)
if reaper.set_action_options then
    --TERMINATE AND START SCRIPT IF DEBUGER STARTED (ALLOW SCRIPT STARTING AGAIN)
    reaper.set_action_options(1|2)
end
-- LOAD PROFILER
local profiler = dofile(profiler_path)
reaper.defer = profiler.defer
-- PATH TO MODED LUAPANDA
local DEBUG = dofile(script_path .. "LuaPanda.lua")

function profiler.dump(result_for_d3)
    local function SaveToFile(data, fn)
        local file
        file = io.open(fn, "w")
        if file then
            file:write(data)
            file:close()
        end
    end
    local json_string = DEBUG.jsonEncode(result_for_d3);
    local script_name = caller_info.source:match("[^\\]*.lua$"):gsub(".lua","")
    local fn = script_name .. "_" ..os.date("%H%M_%d%m%Y") .. ".ReaProfile"
    -- REMOVE [ ] WRAPPER IN JSON STRING
    SaveToFile(json_string:sub(2, #json_string - 1), caller_path .. fn)
end

-- function profiler.dump2(profile, eachDeep)
--     local function SaveToFile(data, fn)
--         local file
--         file = io.open(fn, "w")
--         if file then
--             file:write(data)
--             file:close()
--         end
--     end

--     local function AddDepthData(data)
--         return {
--             name             = data.name,
--             value            = (data.time * 1e+9) // 1, -- CONVERT JUST SO WE HAVE PROPER BAR LENGHTS IN D3 JS
--             time             = data.time,               -- WILL USE FOR CORRECT TOOLTIP DISPLAY
--             count            = data.count,
--             frames           = data.frames,
--             time_frac        = data.time / profile.time,
--             time_frac_parent = data.time / (data.parent and data.parent.time ~= 0 and data.parent.time or profile.time),
--             tpfmin           = data.time_per_frame.min,
--             tpfmax           = data.time_per_frame.max,
--             tpfavg           = data.time / data.frames,
--             tpcmin           = data.time_per_call.min,
--             tpcmax           = data.time_per_call.max,
--             tpcavg           = data.time / data.count,
--             cpfmin           = data.calls_per_frame.min,
--             cpfmax           = data.calls_per_frame.max,
--             cpfavg           = data.count // data.frames,
--             --source           = data.src,
--             children         = {}
--         }
--     end

--     -- local function TblLvl(depth, line, tbl)
--     --     local base_lvl = 1
--     --     local stack_tbl = tbl
--     --     while base_lvl <= depth do
--     --         -- TABLE DEPTH DOES NOT EXIST, CREATE IT
--     --         if not stack_tbl[1] then
--     --             stack_tbl[#stack_tbl + 1] = AddDepthData(line)
--     --             break
--     --         else
--     --             -- ADD TO CURRENT TBL DEPTH
--     --             if base_lvl == depth then
--     --                 stack_tbl[#stack_tbl + 1] = AddDepthData(line)
--     --                 break
--     --             end
--     --             -- GO TO LAST CHILD IN CURRENT DEPTH
--     --             stack_tbl = stack_tbl[#stack_tbl].children
--     --             base_lvl = base_lvl + 1
--     --         end
--     --     end
--     --     return stack_tbl
--     -- end

--     local result_for_d3 = {}
--     for _, line, depth in eachDeep(profile) do
--         local stack_tbl = result_for_d3
--         for i = 1, depth do
--             if not stack_tbl[1] or i == depth  then
--                 stack_tbl[#stack_tbl + 1] = AddDepthData(line)
--                 break
--             end
--             stack_tbl = stack_tbl[#stack_tbl].children
--         end
--         --TblLvl(depth, line, result_for_d3)
--     end
--     local json_string = DEBUG.jsonEncode(result_for_d3);
--     local script_name = caller_info.source:match("[^\\]*.lua$"):gsub(".lua","")
--     local fn = script_name .. "_" ..os.date("%H%M_%d%m%Y") .. ".ReaProfile"
--     -- REMOVE [ ] WRAPPER IN JSON STRING
--     SaveToFile(json_string:sub(2, #json_string - 1), caller_path .. fn)
-- end

-- WHEN PROFILE BUTTON IS PRESSED THIS FUNCTION IS CALLED
-- CLEAR CURRENT PROFILE (A,B,C...)
-- RUN PROFILER FOR 60 FRAMES
-- OPEN GUI
function DEBUG.start_profiler()
    -- DO NOT RUN AGAIN IF DUMP IS IN PROGRESS
   --profiler.clear()
   --profiler.auto_start = 60
    profiler.CollectProfile()
end

--ON CRASH DETACH DEBUGGER TO SHOW ALL LOCAL AND GLOBAL VARIABLES
function DEBUG.detach()
    profiler.detachFromWorld(DEBUG)
end

DEBUG.start("127.0.0.1", 8818)

return nil, profiler
