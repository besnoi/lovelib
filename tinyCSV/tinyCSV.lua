--[[
    LICENSED UNDER GPLV3
        Author: Neer
        https://github.com/YoungNeer
        You can do ANYTHING YOU WANT with this PARTICULAR CODE. NO CREDIT NEEDED
        (However that is not to say that 'you mustn't give credit.') 
    More Lua/LOVE2D libraries at https://github.com/YoungNeer/love-lib/
]]
local inifile={}
function inifile:parse(infile,sep)
    if io.open(infile,'r') then
        sep=sep or "="    
        local db={}
        for i in io.lines(infile) do
            local s=i;
            for key,value in s:gmatch(string.format("%s%s%s","([%w_-]+)",sep,"(.[^,]+)")) do
                db[key]=value
                --print(key,value)
            end
        end
        function db:add(key,value)
            db[key]=value
        end
        function db:getValue(key)
            return db[key]
        end
        return db;
    else
        return nil;
    end
end

function inifile:write(inifile,tmp,sep)
    sep=sep or "="    
    fout=io.open(inifile,'w')
    for k,v in pairs(tmp) do
        if tostring(v):sub(1,8)~='function' then
            fout:write(string.format("%s%s%s,\n",k,sep,tmp[k]))
        end
    end
    fout:close()
end
return inifile
