clc={}
clc.nums = {0}
clc.ops = {}
--规定符号的优先级，目前是只有加减乘除
OperationLevel = {
    ['+'] = 1,
    ['-'] = 1,
    ['*'] = 2,
    ['/'] = 2,
    ['%'] = 2,
    ['^'] = 3,
}

--从数字栈和操作符栈中取出元素进行计算，并将结果返回数字栈中
function calc()
    if #clc.nums < 2 or #clc.ops == 0 then
        return
    end
    local b = table.remove(clc.nums)
    local a = table.remove(clc.nums)
    assert(type(a) == "number", "a 不是一个数字")
    assert(type(b) == "number", "b 不是一个数字")
    local op = table.remove(clc.ops)
    if op == '+' then
        table.insert(clc.nums, a + b)
    elseif op == '-' then
        table.insert(clc.nums, a - b)
    elseif op == '*' then
        table.insert(clc.nums, a * b)
    elseif op == '/' then
        --简单的除数不能为0判断
        assert(b ~= 0, "Divisor cannot be ZERO!!!")
        table.insert(clc.nums, a / b)
    elseif op == '^' then
        table.insert(clc.nums, a ^ b)
    elseif op == '%' then
        table.insert(clc.nums, a % b)
    end
end
--主逻辑
function clc.calculate(s)

    local n = string.len(s)
    local i = 1
    --循环检查
    while i <= n do
        local c = string.sub(s, i, i)
        --左括号就入栈
        if c == '('or c=='['or c=='{' then
            table.insert(clc.ops, c)
        --右括号就计算到上一个左括号，并把上一个左括号出栈
        elseif c == ')' then
            while #clc.ops > 0 do
                if clc.ops[#clc.ops] ~= '(' then
                    calc()
                else
                    table.remove(clc.ops)
                    break
                end
            end
        elseif c == '}' then
            while #clc.ops > 0 do
                if clc.ops[#clc.ops] ~= '{' then
                    calc()
                else
                    table.remove(clc.ops)
                    break
                end
            end
        elseif c == ']' then
            while #clc.ops > 0 do
                if clc.ops[#clc.ops] ~= '[' then
                    calc()
                else
                    table.remove(clc.ops)
                    break
                end
            end
        else
            --数字也入栈
            if tonumber(c) then
                local cur_num = tonumber(c)
                local j = i + 1
                while j <= n and tonumber(string.sub(s, j, j)) do
                    cur_num = cur_num * 10 + tonumber(string.sub(s, j, j))
                    j = j + 1
                end
                table.insert(clc.nums, cur_num)
                i = j - 1
            --如果是运算符就进行优先级上的计算后在入栈
            else
                while #clc.ops > 0 and clc.ops[#clc.ops] ~= '(' and clc.ops[#clc.ops] ~= '[' and clc.ops[#clc.ops] ~= '{' and OperationLevel[clc.ops[#clc.ops]] >= OperationLevel[c] do
                    calc()
                end
                table.insert(clc.ops, c)
            end
        end
        i = i + 1
    end
    while #clc.ops > 0 do
        calc()
    end
    return clc.nums[#clc.nums]
end









