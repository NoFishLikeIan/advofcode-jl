function parserules(rule)
    inst, value = split(rule)
    return (inst, parse(Int, value))
end

flip(inst) = inst == "nop" ? "jmp" : "nop" 

function flipped(rules, n)
    newrules = copy(rules)
    inst, value = rules[n]
    newrules[n] = (flip(inst), value)

    return newrules
end

function computeacc(rules)    
    N = length(rules)
    acc, n = 0, 1
    
    run = Set{Int}()

    while n ≤ N && n ∉ run
        push!(run, n)
        inst, value = rules[n]
        n += (inst == "jmp" ? value : 1)
        acc += (inst == "acc" ? value : 0)
    end
    
    return acc, n
end

function fixacc(rules)
    N = length(rules)
    toflip = findall(r -> r[1] ∈ ["jmp", "nop"], rules)

    for n in toflip
        acc, run = computeacc(flipped(rules, n))
        if run - 1 == N return acc, run end
    end
end

rules = parserules.(readlines("src/files/dayeight.txt"))

acc, n = computeacc(rules)
acc, n = fixacc(rules)

