function chainadaptors!(coll, start, adaptors; distance=3)
    if isempty(adaptors) return true end

    available = findall(x -> 0 < x - start ≤ distance, adaptors)

    if isempty(available)
        pop!(coll)
        return false
    end

    for next in available
        res = chainadaptors!(coll, adaptors[next], adaptors[next + 1:end])
        if res
            push!(coll, start)
            return res
        end
    end

    return false
end

adaptors = sort(parse.(Int, readlines("src/files/daytenmock.txt")))
source, target = 0, maximum(adaptors) + 3

coll = Vector{Int64}()
chainadaptors!(coll, 0, adaptors)
coll = reverse(coll)
push!(coll, target)

Δjolts = diff(coll)
Δ1, Δ3 = count(==(1), Δjolts), count(==(3), Δjolts)