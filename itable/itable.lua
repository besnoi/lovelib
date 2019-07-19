--[[
	iTable Library for Lua/Love2D
	By Neer (you CAN remove this header if you want)
	:-A very very simple library but can be very useful.
	By default Lua doesn't support many table operations even important ones such
	as indexOf and slice, etc. So this library is to fill that gap. 
	Just require it and then u can use table.indexOf/table.firstIndexOf,table.slice,etc...
	
	
	P.S. : Note that most of the functions here will work only with tables as arrays (those working with all types of table will have a *generic* written above) and i guess
	that's why they dont have these functions in the standard table library - cause they are not generic enough.
	(i.e. these functions wont work with hashtables or associative arrays -- name's same)
	But most luaites use tables as array, so this library should prove useful I believe
]]

--returns the index of the first occurence of element el in table tbl

--[[
	Asserts the type of a given variable.
	Arguments:
	- (any) var
	- (string) fncname - used for error messages.
	- (string) [_type] = "table" - Type to compare var to.
]]
local function assertType(var,fncname,_type)
	_type = _type or "table"
	assert(type(var)==_type,("Oops! %s expected in table.%s, got '%s'"):format(_type,fncname,type(var)))	
end

--[[
	Finds the first instance of an element in a given array.
	Arguments:
	- (table) tbl
	- (any) element
	Returns: int? index (nil if not found)
]]
function table.firstIndexOf(tbl,element)
	assertType(tbl,"firstIndexOf")
	for i,el in ipairs(tbl) do
		if el==element then return i end
	end
	return nil
end

--[[
	Finds the last index of an element in a given array.
	Arguments:
	- (table) tbl
	- (any) element
	Returns: int? index (nil if not found)
]]
function table.lastIndexOf(tbl,element)
	local index=nil
	assertType(tbl,"lastIndexOf")	
	for i,el in ipairs(tbl) do
		if el==element then index=i end
	end
	return index
end

--[[
	Finds the first instance of an element in a given array.
	Arguments:
	- (table) tbl
	- (any) el
	Returns: int? index (nil if not found)
]]
table.indexOf=function(tbl,el) return table.firstIndexOf(tbl,el) end

--[[
	Finds whether a given element exists in a table or not.
	Arguments:
	- (table) tbl
	- (any) el
]]
table.exists=function(tbl,el) return not (table.indexOf(tbl,el)==nil) end

--[[
	Returns a subset of a table.
	Arguments:
	- (table) tbl
	- (int) [first] = 1
	- (int) [last] = #tbl
	- (int) [step] = 1
	Returns: (table) subset
]]
function table.slice(tbl, first, last, step)
	assertType(tbl,"slice")	
    local sliced = {}
    for i = first or 1, last or #tbl, step or 1 do
      sliced[#sliced+1] = tbl[i]
    end
    return sliced
end

--[[
	Supposed minor optimization for large table subset creation...
	Arguments:
	- (table) tbl
	- (int) [first] = 1
	- (int) [last] = #tbl
	Returns: (table) subset
]]
table.subset=function(tbl,first,last) return table.slice(tbl,first,last,1) end

--[[
	Pushes a value to the end of an array.
	Arguments:
	- (table) tbl
	- (any) value
]]
table.push_back=function(tbl,value) assertType(tbl,"push_back") tbl[#tbl+1]=value end

--[[
	Pushes a value to the end of an array.
	Arguments:
	- (table) tbl
	- (any) value
]]
table.push=function(tbl,value) table.push_back(tbl,value) end

--[[
	Replaces the first element in an array.
	Arguments:
	- (table) tbl
	- (any) value
]]
table.push_front=function(tbl,value) assertType(tbl,"push_front") tbl[1]=value end

--[[
	Pushes every vararg to the end of an array.
	Arguments:
	- (table) tbl
	- (any) varargs...
]]
function table.append(tbl,...)
	assertType(tbl,"append")
	for _,i in ipairs{...} do
		tbl[#tbl+1]=i
	end
end

--[[
	Merges tables with the first table.
	Arguments:
	- (table) tbl
	- (table) varargs...
]]
function table.merge(tbl,...)
	assertType(tbl,"merge")
	for _,i in ipairs{...} do
		if type(i)=='table' then 
			for _,j in ipairs(i) do
				tbl[#tbl+1]=j
			end
		end
	end
end

--[[
	Sets key-value pairs in the first table using the other tables.
	Different from table.merge in the sense that it supports hashtables.
	Arguments:
	- (table) tbl
	- (table) varargs...
]]
function table.join(tbl,...)
	assertType(tbl,"join")
	for _,i in pairs{...} do
		if type(i)=='table' then 
			for k,j in pairs(i) do
				tbl[k]=j
			end
		end
	end
end

--[[
	Divides a table into an array of subsets. (Each subset containing less than or n number of elements) of the original table.concat
	E.g. if tbl={1,2,3,4,5} then subdivide(tbl,2) will return {{1,2},{['3']=3,['4']=4},{['5']=5}}
	and if tbl={['a']=5,['b']=6,c=8} then subdivide(tbl,1) will return {{['a']=5},{['b']=6},{['c']=8}}
	Arguments:
	- (table) tbl
	- (int) n
]]
function table.subdivide(tbl,n)
	assertType(tbl,"subdivide")
	local array,index,i={},1,1
	for key,value in pairs(tbl) do
		if i==n+1 then i=1 index=index+1 end
		if not array[index] then array[index]={} end
		array[index][key]=value
		i=i+1
	end
	return array,index
end

--[[
	Unlike table.subdivide, divide works only on arrays. It differs from subdivide only in one aspect here illustrated by eg
	e.g. if tbl={1,2,3,4,5} then subdivide(tbl,2) will return {{1,2},{['3']=3,['4']=4},{['5']=5}}
	but divide(tbl,2) will return {{1,2},{3,4},{5,6}}
	Arguments:
	- (table) tbl
	- (int) n
]]
function table.divide(tbl,n)
	assertType(tbl,"divide")	
	local array,index,i={},1,1
	for key,value in ipairs(tbl) do
		if i==n+1 then i=1 index=index+1 end
		if not array[index] then array[index]={} end
		array[index][i]=value
		i=i+1
	end
	return array,index
end

--[[
	table.sort except it returns a new table.
]]
function table.isort(tbl,funcn)
	assertType(tbl,'isort')
	assertType(funcn,'isort','function')
	local tmp=tbl
	table.sort(tmp,funcn)
	return tmp
end
