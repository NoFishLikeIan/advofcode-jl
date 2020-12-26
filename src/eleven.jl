shift = (tup for tup in Iterators.product([-1, 0, 1], [-1, 0, 1]) if any(tup .!= 0))

inside(x, bounds) = bounds[1] ≤ x ≤ bounds[2]

function adjacent(index::CartesianIndex, ibounds, jbounds)
    a, b = Tuple(index)
    neigh = Set{CartesianIndex}()

    for (i, j) in shift
        si, sj = a + i, b + j

        inbound = inside(si, ibounds) && inside(sj, jbounds)

        if inbound push!(neigh, CartesianIndex(si, sj)) end
    end

    return neigh
end

function makeevolve(R)
    function evolve(seats)
        N, M = size(seats)
        next = copy(seats)

        for I in R
            occ = sum(seats[N] for N in adjacent(I, (1, N), (1, M)) if seats[N] ≥ 0)
            if seats[I] == 0 && occ == 0 next[I] = 1
            elseif seats[I] == 1 && occ ≥ 4 next[I] = 0 end
        end

        return next
    end
end

sameseat(A, B) = all(A .== B)

function simulate(seats, fn)
    current, next = seats, fn(seats)
    while !sameseat(current, next)
        current = next
        next = fn(next)
    end

    return current
end

parserow(row) = [s == 'L' ? 0 : -1 for s in row]

seats = vcat(parserow.(readlines("src/files/dayeleven.txt"))'...)
evolve = makeevolve(findall(!=(-1), seats))

equilocc = sum(filter(x -> x == 1, simulate(seats, evolve)))