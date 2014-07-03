-- Tables

--Based on the Moses library by Roland Yonaba https://github.com/Yonaba/Moses

-- Count
local function f_max(a,b) return a>b end
local function f_min(a,b) return a<b end
local function clamp(var,a,b) return (var<a) and a or (var>b and b or var) end
local function isTrue(_,value) return value and true end
local function iNot(value) return not value end
local function count(t)
	local i
    for k,v in pairs(t) do i = (i or 0) + 1 end
	return i
end
local function extract(list,comp,transform,...)
  local _ans
  local transform = transform or _.identity
  for index,value in pairs(list) do
    if not _ans then _ans = transform(value,...)
    else
      local value = transform(value,...)
      _ans = comp(_ans,value) and _ans or value
    end
  end
  return _ans
end
-- Is Nil
function isNil(obj)
	return obj==nil
end
-- Size
function size(...)
  local args = {...}
  local arg1 = args[1]
  if isNil(arg1) then
    return 0
  elseif isTable(arg1) then
    return count(args[1])
  else
    return count(args)
  end
end
-- Each
function each(list, f, ...)
  if not isTable(list) then return end
  for index,value in pairs(list) do
    f(index,value,...)
  end
end
-- Table
function isTable(t)
  return type(t) == 'table'
end
-- Reverse
function rreverse(array)
  local _array = {}
  for i = #array,1,-1 do
    _array[#_array+1] = array[i]
  end
  return _array
end
-- Index
function indexOf(array, value)
  for k = 1,#array do
    if array[k] == value then return k end
  end
end
-- Last Index
function lastIndexOf(array,value)
  local key = indexOf(rreverse(array),value)
  if key then return #array-key+1 end
end
-- Add
function add(array,...)
  each({...},function(i,v) table.insert(array,1,v) end)
  return array
end
-- Push
function push(array,...)
  each({...}, function(i,v) array[#array+1] = v end)
  return array
end

-- Shuffle
function shuffle(list,seed)
  seed = os.clock()
  if seed then math.randomseed(seed) end
  local shuffled = {}
  each(list,function(index,value)
           local randPos = math.floor(math.random()*index)+1
          shuffled[index] = shuffled[randPos]
          shuffled[randPos] = value
        end)
  return shuffled
end
-- To Array
function toArray(...)
  return {...}
end
-- Clone
function clone(obj,shallow)
	if not isTable(obj) then return obj end
  local _obj = {}
  each(obj,function(i,v)
    if isTable(v) then
      if not shallow then
		_obj[i] = clone(v,shallow)
	  else _obj[i] = v
	  end
	else
		_obj[i] = v
	end
  end)
  return _obj
end
-- Is Equal
function isEqual(objA,objB,useMt)
	local typeObjA = type(objA)
	local typeObjB = type(objB)
  if typeObjA~=typeObjB then return false end
  if typeObjA~='table' then return (objA==objB) end

  local mtA = getmetatable(objA)
  local mtB = getmetatable(objB)

  if useMt then
	if mtA or mtB and mtA.__eq or mtB.__eq then
		return (objA==objB)
	end
  end

  if size(objA)~=size(objB) then return false end

  for i,v1 in pairs(objA) do
    local v2 = objB[i]
    if isNil(v2) or not isEqual(v1,v2,useMt) then return false end
  end

  for i,v1 in pairs(objB) do
    local v2 = objA[i]
    if isNil(v2) then return false end
  end

  return true
end
-- Include
function include(list,item)
  local iter = isFunction(item) and item or isEqual
  for _,value in pairs(list) do
    if iter(value,item) then return true end
  end
  return false
end
--Is Function
function isFunction(obj)
   return type(obj) == 'function'
end
--Map
function map(list, f, ...)
  local list = {}
  for index,value in pairs(list) do
    list[index] = f(index,value,...)
  end
  return list
end
-- Uniq
function uniq(array,isSorted,iter,...)
  local init = iter and map(array,iter,...) or array
  local result = {}
  if not isSorted then
    for __,v in ipairs(init) do
      if not include(result,v) then
		result[#result+1] = v
		end
    end
  return result
  end

  result[#result+1] = init[1]
  for i = 2,#init do
    if init[i] ~= result[#result] then
		result[#result+1] = init[i]
	end
  end
  return result
end
-- Flatten
function flatten(array, shallow)
  local shallow = shallow or false
  local newflattened
  local flat = {}
  for key,value in pairs(array) do
    if isTable(value) and not shallow then
      newflattened = flatten (value)
      each(newflattened, function(_,item) flat[#flat+1] = item end)
    else flat[#flat+1] = value
    end
  end
  return flat
end
-- Union
function union(...)
  return uniq(flatten({...}))
end
-- All
function all(list,f,...)
  return ((#select(map(list,f,...), isTrue)) == (#list))
end

-- Range
function range(...)
  local arg = {...}
  local start,stop,step
  if #arg==0 then return {}
  elseif #arg==1 then stop,start,step = arg[1],0,1
  elseif #arg==2 then start,stop,step = arg[1],arg[2],1
  elseif #arg == 3 then start,stop,step = arg[1],arg[2],arg[3]
  end
  if (step and step==0) then return {} end
  local ranged = {}
  local steps = math.max(math.floor((stop-start)/step),0)
  for i=1,steps do ranged[#ranged+1] = start+step*i end
  if #ranged>0 then table.insert(ranged,1,start) end
  return ranged
end
-- Replace
function replace(w,x,y,z)
  
  return string.gsub(w,x,y,z)
  
end
