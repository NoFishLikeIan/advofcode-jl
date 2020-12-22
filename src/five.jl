mean(two) = (two[2] + two[1]) / 2

function split!(rule::Vector{Char}, left::Vector{Int})::Int
    if isempty(rule) return first(left) end

    next = pop!(rule)

    μ = mean(left)
    left = (next == 'F') ? [left[1], floor(Int, μ)] : [ceil(Int,  μ), left[2]]


    return split!(rule, left)
end

function parseticket(ticket::String)

    rows, columns = ticket[1:7], ticket[8:end]
    rowrule = reverse(collect(rows))
    columnrule = reverse([ch == 'R' ? 'B' : 'F' for ch in columns])

    row = split!(rowrule, [0, 127])
    column = split!(columnrule, [0, 8])

    return row * 8 + column
end


findid(ids) = findfirst(n -> n - 1 + first(ids) != ids[n], 1:length(ids)) - 1 + first(ids)

rawtickets = readlines("src/files/dayfive.txt")
ids = sort(parseticket.(rawtickets))
maxid = last(ids)

myid = findid(ids)

