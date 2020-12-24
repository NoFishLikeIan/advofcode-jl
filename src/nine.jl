notfound = (-1, -1)

"""
Check if n = a + b where a, b ∈ seq
"""
function findsum(seq, n)
    sorted = sort(filter(x -> x < n, seq))

    if length(sorted) ≤ 1 || n > sorted[end] + sorted[end - 1]
        return notfound 
    end

    I = length(sorted)

    for (i, x) in enumerate(sorted)
        lookfor = n - x
        low, high = i, I
        while low ≤ high
            mid = (low + high) ÷ 2

            if sorted[mid] > lookfor high = mid - 1
            elseif sorted[mid] < lookfor low = mid + 1
            else return x, lookfor
            end
        end
    end

    return notfound
end

ispossiblesum(seq, n) = findsum(seq, n)[1] > 0

sequence = parse.(Int, readlines("src/files/daynine.txt"))

function findfirstnonvalid(sequence, shift)
    N = length(sequence)
    isnotvalid = n -> !ispossiblesum(sequence[n - prev:n - 1], sequence[n])
    idx = findfirst(isnotvalid, (shift + 1):N) + shift

    return idx
end

notsum = sequence[findfirstnonvalid(sequence, 25)]

function contrangesumto!(sequence, target)
    N = length(sequence)
    
    for (j, x) in enumerate(sequence)
        rest = target - x
        
    end
end