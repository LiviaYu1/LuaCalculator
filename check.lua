check={}

--移除多余的空格
function check.RemoveSpace(s)
    local pos = string.find(s, ' ')
    while pos do
        s = string.gsub(s, ' ', '')
        pos = string.find(s, ' ')
    end
    return s
end
--移除奇奇怪怪的元素比如说(+    (-把他变成(0+ (0-方便运算 
--以及全半角的替换，让所有的中文符号变成英文
function check.RemoveSpecial(s)
    -- local modifiedString = s
    -- modifiedString = string.gsub(modifiedString, "（", '(')
    -- modifiedString = string.gsub(modifiedString, "）", ')')
    -- modifiedString = string.gsub(modifiedString, "】", ']')
    -- modifiedString = string.gsub(modifiedString, "【", '[')
    -- modifiedString = string.gsub(modifiedString, "%(%+", "(0+")
    -- modifiedString = string.gsub(modifiedString, "%(%-", "(0-")
    -- return modifiedString
    local modifiedString = s:gsub("（", '('):gsub("）", ')'):gsub("【", '['):gsub("】", ']')
    modifiedString = modifiedString:gsub("%(%+", "(0+"):gsub("%(%-", "(0-"):gsub("%[%+", "[0+"):gsub("%[%-", "[0-"):gsub("%{%+", "{0+"):gsub("%{%-", "{0-")
    return modifiedString
end

--print(check.RemoveSpecial("{}【】（）【】()()(+ 12)+(-1)"))

--检验括号
function check.CheckBrackets(s)
    local ops = {}
    local i=1
    local n=string.len(s)
    while i<=n do
        local c=string.sub(s,i,i) 
        if c=='('or c=='{'or c=='[' then
            table.insert(ops,c)
        end
        if c==')' then
            if #ops>0 and ops[#ops]=='(' then
                table.remove(ops)
            else
                return false
            end
        end
        if c==']' then
            if #ops>0 and ops[#ops]=='[' then
                table.remove(ops)
            else
                return false
            end
        end
        if c=='}' then
            if #ops>0 and ops[#ops]=='{' then
                table.remove(ops)
            else
                return false
            end
        end
        i=i+1
    end
    return #ops==0

end
