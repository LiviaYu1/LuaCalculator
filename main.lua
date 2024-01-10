require("check")
require("clc")
print("----------------------------------")
print("------------Calculator------------")
print("-------input q/quit to quit-------")
print("-------input clear to reset-------")
print("----------------------------------")
while true do
    --S="{}【】（）【】()()(+ 12)+(-1)"
    --有用吗？我终端中按了两下上下左右键我的checkbrackets都会变成false，即使没有输入，不过好像没用

    io.flush()

    S = io.read()

    --quit q退出，clear清除缓存,readfile读取文件
    if S=="q" or S=="quit" then
        break
    elseif S=="clear" then
        while #clc.nums>0 do
            table.remove(clc.nums)
        end
        table.insert(clc.nums,0)
        goto continue
    --elseif S=="readfile" then
  
    end

    --先把中文括号变成英文括号并且一处一些不容易处理的字符
    S=check.RemoveSpecial(S)
    --print(check.RemoveSpecial(S))

    --进行括号的检验，如果括号对不上就不需要进行下一步了
    if check.CheckBrackets(S)==false then
        print("Brackets don't match, check your input")
        break
    end
    --移除空格
    S=check.RemoveSpace(S)

    --进行运算输出结果
    local result =clc.calculate(S)
    table.insert(clc.nums,result)

    --print(S)
    print("expression : "..S.." answer is : "..result)

    ::continue::
end
