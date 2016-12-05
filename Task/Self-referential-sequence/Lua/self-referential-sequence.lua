-- Return the next term in the self-referential sequence
function findNext (nStr)
    local nTab, outStr, pos, count = {}, "", 1, 1
    for i = 1, #nStr do nTab[i] = nStr:sub(i, i) end
    table.sort(nTab, function (a, b) return a > b end)
    while pos <= #nTab do
        if nTab[pos] == nTab[pos + 1] then
            count = count + 1
        else
            outStr = outStr .. count .. nTab[pos]
            count = 1
        end
        pos = pos + 1
    end
    return outStr
end

-- Return boolean indicating whether table t contains string s
function contains (t, s)
    for k, v in pairs(t) do
        if v == s then return true end
    end
    return false
end

-- Return the sequence generated by the given seed term
function buildSeq (term)
    local sequence = {}
    repeat
        table.insert(sequence, term)
        if not nextTerm[term] then nextTerm[term] = findNext(term) end
        term = nextTerm[term]
    until contains(sequence, term)
    return sequence
end

-- Main procedure
nextTerm = {}
local highest, seq, hiSeq = 0
for i = 1, 10^6 do
    seq = buildSeq(tostring(i))
    if #seq > highest then
        highest = #seq
        hiSeq = {seq}
    elseif #seq == highest then
        table.insert(hiSeq, seq)
    end
end
io.write("Seed values: ")
for _, v in pairs(hiSeq) do io.write(v[1] .. " ") end
print("\n\nIterations: " .. highest)
print("\nSample sequence:")
for _, v in pairs(hiSeq[1]) do print(v) end
