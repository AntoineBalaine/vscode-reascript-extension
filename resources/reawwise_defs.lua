---@diagnostic disable: keyword
---@meta

---@class AK_Array
---@class AK_Map
---@class AK_Variant

---Ak: Create an array object
---@return AK_Array array
function reaper.AK_AkJson_Array() end

---Ak: Add element to an array object
---@param array AK_Array
---@param element AK_Map|AK_Array|AK_Variant
---@return boolean success
function reaper.AK_AkJson_Array_Add(array, element) end

---Ak: Get element at index of array object
---@param array AK_Array
---@param index integer
---@return AK_Map|AK_Array|AK_Variant element
function reaper.AK_AkJson_Array_Get(array, index) end

---Ak: Get count of elements in array object
---@param array AK_Array
---@return integer count
function reaper.AK_AkJson_Array_Size(array) end

---Ak: Clear object referenced by pointer
---@param pointer AK_Map|AK_Array|AK_Variant
---@return boolean success
function reaper.AK_AkJson_Clear(pointer) end

---Ak: Clear all objects referenced by pointers
---@return boolean success
function reaper.AK_AkJson_ClearAll() end

---Ak: Get the status of a result from a call to waapi
---@param pointer AK_Map|AK_Array|AK_Variant
---@return boolean status
function reaper.AK_AkJson_GetStatus(pointer) end

---Ak: Create a map object
---@return AK_Map map
function reaper.AK_AkJson_Map() end

---Ak: Get a map object
---@param map AK_Map
---@param key string
---@return AK_Map|AK_Array|AK_Variant value
function reaper.AK_AkJson_Map_Get(map, key) end

---Ak: Set a property on a map object
---@param map AK_Map
---@param key string
---@param value AK_Map|AK_Array|AK_Variant
---@return boolean success
function reaper.AK_AkJson_Map_Set(map, key, value) end

---Ak: Create a bool object
---@param bool boolean
---@return AK_Variant boolObject
function reaper.AK_AkVariant_Bool(bool) end

---Ak: Create a double object
---@param double number
---@return AK_Variant doubleObject
function reaper.AK_AkVariant_Double(double) end

---Ak: Extract raw boolean value from bool object
---@param boolObject AK_Variant
---@return boolean bool
function reaper.AK_AkVariant_GetBool(boolObject) end

---Ak: Extract raw double value from double object
---@param doubleObject AK_Variant
---@return number double
function reaper.AK_AkVariant_GetDouble(doubleObject) end

---Ak: Extract raw int value from int object
---@param intObject AK_Variant
---@return integer int
function reaper.AK_AkVariant_GetInt(intObject) end

---Ak: Extract raw string value from string object
---@param stringObject AK_Variant
---@return string str
function reaper.AK_AkVariant_GetString(stringObject) end

---Ak: Create an int object
---@param int integer
---@return AK_Variant intObject
function reaper.AK_AkVariant_Int(int) end

---Ak: Create a string object
---@param str string
---@return AK_Variant stringObject
function reaper.AK_AkVariant_String(str) end

---Ak: Make a call to Waapi
---@param uri string
---@param options AK_Map
---@param parameters AK_Map
---@return AK_Map result
function reaper.AK_Waapi_Call(uri, options, parameters) end

---Ak: Connect to waapi (Returns connection status as bool)
---@param ipAddress string
---@param port integer
---@return boolean success
function reaper.AK_Waapi_Connect(ipAddress, port) end

---Ak: Disconnect from waapi
function reaper.AK_Waapi_Disconnect() end