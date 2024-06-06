-- This module provides bindings for the Audiokinetic ReaWwise Extension (https://github.com/Audiokinetic/Reaper-Tools/raw/main/index.xml) intended for use with the Wwise Authoring API (WAAPI).
-- These functions allow you to manipulate JSON objects and interact with Wwise's authoring environment.
-- For more information, go to the ReaWwise documentation: https://www.audiokinetic.com/en/library/reawwise/

---@diagnostic disable: keyword
---@meta

---@class AK_Array
---@class AK_Map
---@class AK_Variant

---ReaWwise
---Ak: Create an array object
---@return AK_Array array
function reaper.AK_AkJson_Array() end

---ReaWwise
---Ak: Add element to an array object
---@param array AK_Array
---@param element AK_Map|AK_Array|AK_Variant
---@return boolean success
function reaper.AK_AkJson_Array_Add(array, element) end

---ReaWwise
---Ak: Get element at index of array object
---@param array AK_Array
---@param index integer
---@return AK_Map|AK_Array|AK_Variant element
function reaper.AK_AkJson_Array_Get(array, index) end

---ReaWwise
---Ak: Get count of elements in array object
---@param array AK_Array
---@return integer count
function reaper.AK_AkJson_Array_Size(array) end

---ReaWwise
---Ak: Clear object referenced by pointer
---@param pointer AK_Map|AK_Array|AK_Variant
---@return boolean success
function reaper.AK_AkJson_Clear(pointer) end

---ReaWwise
---Ak: Clear all objects referenced by pointers
---@return boolean success
function reaper.AK_AkJson_ClearAll() end

---ReaWwise
---Ak: Get the status of a result from a call to waapi
---@param pointer AK_Map|AK_Array|AK_Variant
---@return boolean status
function reaper.AK_AkJson_GetStatus(pointer) end

---ReaWwise
---Ak: Create a map object
---@return AK_Map map
function reaper.AK_AkJson_Map() end

---ReaWwise
---Ak: Get a map object
---@param map AK_Map
---@param key string
---@return AK_Map|AK_Array|AK_Variant value
function reaper.AK_AkJson_Map_Get(map, key) end

---ReaWwise
---Ak: Set a property on a map object
---@param map AK_Map
---@param key string
---@param value AK_Map|AK_Array|AK_Variant
---@return boolean success
function reaper.AK_AkJson_Map_Set(map, key, value) end

---ReaWwise
---Ak: Create a bool object
---@param bool boolean
---@return AK_Variant boolObject
function reaper.AK_AkVariant_Bool(bool) end

---ReaWwise
---Ak: Create a double object
---@param double number
---@return AK_Variant doubleObject
function reaper.AK_AkVariant_Double(double) end

---ReaWwise
---Ak: Extract raw boolean value from bool object
---@param boolObject AK_Variant
---@return boolean bool
function reaper.AK_AkVariant_GetBool(boolObject) end

---ReaWwise
---Ak: Extract raw double value from double object
---@param doubleObject AK_Variant
---@return number double
function reaper.AK_AkVariant_GetDouble(doubleObject) end

---ReaWwise
---Ak: Extract raw int value from int object
---@param intObject AK_Variant
---@return integer int
function reaper.AK_AkVariant_GetInt(intObject) end

---ReaWwise
---Ak: Extract raw string value from string object
---@param stringObject AK_Variant
---@return string str
function reaper.AK_AkVariant_GetString(stringObject) end

---ReaWwise
---Ak: Create an int object
---@param int integer
---@return AK_Variant intObject
function reaper.AK_AkVariant_Int(int) end

---ReaWwise
---Ak: Create a string object
---@param str string
---@return AK_Variant stringObject
function reaper.AK_AkVariant_String(str) end

---ReaWwise
---Ak: Make a call to Waapi
---@param uri string
---@param options AK_Map
---@param parameters AK_Map
---@return AK_Map result
function reaper.AK_Waapi_Call(uri, options, parameters) end

---ReaWwise
---Ak: Connect to waapi (Returns connection status as bool)
---@param ipAddress string
---@param port integer
---@return boolean success
function reaper.AK_Waapi_Connect(ipAddress, port) end

---ReaWwise
---Ak: Disconnect from Waapi
function reaper.AK_Waapi_Disconnect() end